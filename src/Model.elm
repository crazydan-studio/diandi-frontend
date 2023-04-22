{-
   点滴(DianDi) - 聚沙成塔，集腋成裘
   Copyright (C) 2022 by Crazydan Studio (https://studio.crazydan.org/)

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
-}


module Model exposing
    ( Config
    , Model
    , Msg(..)
    , init
    , sub
    , update
    )

import Browser
import Browser.Dom as Dom
import Browser.Navigation as Nav
import I18n.Port
import Model.App as App
import Model.Operation as Operation
import Model.Operation.EditTopic as EditTopic
import Model.Remote as Remote
import Model.Remote.GraphQL.Topic as RemoteTopic
import Model.Remote.Msg as RemoteMsg
import Model.TopicCard as TopicCard
import Task
import Time
import Url
import View.Page as Page
import View.Route


type alias Config =
    { title : String
    , description : String
    , screen : { width : Int, height : Int }
    , lang : String
    }


type alias Model =
    { -- 应用状态
      app : App.State
    , timeZone : Time.Zone
    , themeDark : Bool
    }


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | FocusOn String
    | SwitchToDarkTheme Bool
    | AdjustTimeZone Time.Zone
      -- 远端消息
    | RemoteMsg RemoteMsg.Msg
      -- 国际化Port消息
    | I18nPortMsg I18n.Port.Msg
      -- 数据操作
    | SearchTopic
    | SearchTopicInputing String
    | TopicCardMsg String TopicCard.Msg
    | RemoveTopicCard String
    | NewTopicPending
    | NewTopicMsg EditTopic.Msg
    | NewTopicSaving
    | NewTopicCleaned
    | EditTopicPending String
    | EditTopicMsg EditTopic.Msg
    | EditTopicSaving
    | EditTopicCleaned


{-| 发起远程请求
-}
toRemoteCmd : Cmd RemoteMsg.Msg -> Cmd Msg
toRemoteCmd msg =
    Cmd.map RemoteMsg msg


focusOn : String -> Cmd Msg
focusOn id =
    Task.attempt
        (\_ -> FocusOn id)
        (Dom.focus id)


init : Config -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init config navUrl navKey =
    let
        app =
            App.init
                { title = config.title
                , description = config.description
                , lang = config.lang
                , navKey = navKey
                , navUrl = navUrl
                }

        ( state, cmd ) =
            { app = app
            , timeZone = Time.utc
            , themeDark = False
            }
                |> routeUpdateHelper navUrl
    in
    ( state
    , Cmd.batch
        [ cmd
        , Task.perform AdjustTimeZone Time.here
        ]
    )


sub : Model -> Sub Msg
sub state =
    Sub.batch
        [ I18n.Port.sub I18nPortMsg
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg state =
    case msg of
        RemoteMsg remoteMsg ->
            remoteUpdateHelper remoteMsg state

        UrlChanged url ->
            routeUpdateHelper url state

        I18nPortMsg i18nPortMsg ->
            i18nUpdateHelper i18nPortMsg state

        SwitchToDarkTheme dark ->
            ( { state | themeDark = dark }
            , Cmd.none
            )

        AdjustTimeZone zone ->
            ( { state | timeZone = zone }
            , Cmd.none
            )

        SearchTopicInputing keywords ->
            ( state
                |> updateAppState
                    (App.updateTopicSearchingText (Just keywords))
            , Cmd.none
            )

        SearchTopic ->
            ( state
            , View.Route.searchTopics
                (state.app.topicSearchingText |> Maybe.withDefault "")
                state.app
            )

        TopicCardMsg topicId topicCardMsg ->
            topicCardUpdateHelper topicId topicCardMsg state

        RemoveTopicCard topicId ->
            ( state |> updateAppState (App.removeTopicCard topicId)
            , Cmd.none
            )

        NewTopicPending ->
            ( state |> updateAppState App.initNewTopic
            , Cmd.none
            )

        NewTopicMsg newTopicMsg ->
            newTopicUpdateHelper newTopicMsg state

        NewTopicSaving ->
            newTopicSavingHelper state

        NewTopicCleaned ->
            ( state |> updateAppState App.cleanNewTopic
            , Cmd.none
            )

        EditTopicPending topicId ->
            ( state |> updateAppState (App.initEditTopic topicId)
            , Cmd.none
            )

        EditTopicMsg editTopicMsg ->
            editTopicUpdateHelper editTopicMsg state

        EditTopicSaving ->
            editTopicSavingHelper state

        EditTopicCleaned ->
            ( state |> updateAppState App.cleanEditTopic
            , Cmd.none
            )

        _ ->
            ( state, Cmd.none )



-- -------------------------------------------------------------------


updateAppState :
    (App.State -> App.State)
    -> Model
    -> Model
updateAppState updater ({ app } as state) =
    let
        newApp =
            updater app
    in
    { state
        | app = newApp
    }


{-| 远程请求更新
-}
remoteUpdateHelper :
    RemoteMsg.Msg
    -> Model
    -> ( Model, Cmd Msg )
remoteUpdateHelper msg ({ app } as state) =
    case msg of
        RemoteMsg.QueryMyTopics result ->
            ( state
                |> updateAppState
                    (App.loadTopics result)
            , Cmd.none
            )

        RemoteMsg.SaveMyNewTopic result ->
            ( state
                |> updateAppState
                    (App.updateSavedNewTopic result)
            , Cmd.none
            )

        RemoteMsg.SaveMyEditTopic result ->
            ( state
                |> updateAppState
                    (App.updateSavedEditTopic result)
            , Cmd.none
            )

        RemoteMsg.TrashMyTopic topicId result ->
            ( state
                |> updateAppState
                    (App.updateTopicCard topicId
                        (case result of
                            Ok _ ->
                                TopicCard.Trash Operation.Done

                            Err e ->
                                TopicCard.Trash
                                    (Operation.Error
                                        (Remote.parseError state.app.lang e)
                                    )
                        )
                    )
            , Cmd.none
            )

        _ ->
            ( state, Cmd.none )


routeUpdateHelper : Url.Url -> Model -> ( Model, Cmd Msg )
routeUpdateHelper navUrl state =
    let
        ( page, newState, cmd ) =
            case View.Route.route navUrl of
                View.Route.Home ->
                    let
                        ( s, c ) =
                            state |> doRemoteQueryMyTopics
                    in
                    ( Page.Home, s, c )

                View.Route.TopicsSearch keywords ->
                    let
                        ( s, c ) =
                            state
                                |> updateAppState
                                    (App.updateTopicSearchingText keywords)
                                |> doRemoteQueryMyTopics
                    in
                    ( Page.Home, s, c )

                View.Route.Forbidden ->
                    ( Page.Forbidden, state, Cmd.none )

                View.Route.NotFound ->
                    ( Page.NotFound, state, Cmd.none )
    in
    ( newState
        |> updateAppState
            (\app ->
                { app
                    | currentPage = page
                    , navUrl = navUrl
                }
            )
    , cmd
    )


i18nUpdateHelper : I18n.Port.Msg -> Model -> ( Model, Cmd Msg )
i18nUpdateHelper msg ({ app } as state) =
    case I18n.Port.update msg of
        ( r, m ) ->
            ( { state
                | app = { app | textsWithoutI18n = r.results }
              }
            , m
            )


topicCardUpdateHelper :
    String
    -> TopicCard.Msg
    -> Model
    -> ( Model, Cmd Msg )
topicCardUpdateHelper topicId msg state =
    ( state
        |> updateAppState (App.updateTopicCard topicId msg)
    , case msg of
        TopicCard.Trash op ->
            case op of
                Operation.Doing ->
                    toRemoteCmd
                        (RemoteTopic.trashMyTopic topicId)

                _ ->
                    Cmd.none

        _ ->
            Cmd.none
    )


newTopicUpdateHelper :
    EditTopic.Msg
    -> Model
    -> ( Model, Cmd Msg )
newTopicUpdateHelper msg state =
    ( state
        |> updateAppState
            (App.updateNewTopic
                (EditTopic.update msg)
            )
    , case msg of
        EditTopic.TagDeleted _ ->
            focusOn state.app.topicTagEditInputId

        _ ->
            Cmd.none
    )


newTopicSavingHelper :
    Model
    -> ( Model, Cmd Msg )
newTopicSavingHelper ({ app } as state) =
    let
        ( newTopic, topic ) =
            App.prepareSavingNewTopic app
    in
    ( state
        |> updateAppState
            (\s -> { s | newTopic = newTopic })
    , topic
        |> Maybe.map
            (\t ->
                toRemoteCmd
                    (RemoteTopic.saveMyNewTopic t)
            )
        |> Maybe.withDefault
            Cmd.none
    )


editTopicSavingHelper :
    Model
    -> ( Model, Cmd Msg )
editTopicSavingHelper ({ app } as state) =
    let
        ( editTopic, topic ) =
            App.prepareSavingEditTopic app
    in
    ( state
        |> updateAppState
            (\s -> { s | editTopic = editTopic })
    , topic
        |> Maybe.map
            (\t ->
                toRemoteCmd
                    (RemoteTopic.saveMyEditTopic t)
            )
        |> Maybe.withDefault
            Cmd.none
    )


editTopicUpdateHelper :
    EditTopic.Msg
    -> Model
    -> ( Model, Cmd Msg )
editTopicUpdateHelper msg state =
    ( state
        |> updateAppState
            (App.updateEditTopic
                (EditTopic.update msg)
            )
    , case msg of
        EditTopic.TagDeleted _ ->
            focusOn state.app.topicTagEditInputId

        _ ->
            Cmd.none
    )


doRemoteQueryMyTopics : Model -> ( Model, Cmd Msg )
doRemoteQueryMyTopics state =
    ( state
        |> updateAppState
            (\app ->
                { app
                    | topicCards = App.loading
                }
            )
    , Cmd.batch
        [ toRemoteCmd
            (RemoteTopic.queryMyTopics
                { keyword = state.app.topicSearchingText
                , tags = Nothing
                }
            )
        ]
    )
