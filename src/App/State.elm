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


module App.State exposing
    ( Config
    , State
    , init
    , sub
    , update
    )

import App.I18n.App as I18n
import App.Msg as Msg exposing (Msg)
import App.Operation as Operation
import App.Operation.EditTopic as EditTopic exposing (EditTopic)
import App.Remote as Remote
import App.Remote.Data as RemoteData
import App.Remote.GraphQL.Topic as RemoteTopic
import App.Remote.Msg as RemoteMsg
import App.Topic exposing (Topic)
import App.TopicCard as TopicCard exposing (TopicCard)
import Browser.Navigation as Nav
import Data.TreeStore as TreeStore exposing (TreeStore)
import Http
import I18n.Lang exposing (Lang)
import I18n.Port
import I18n.Translator exposing (TextsNeedToBeTranslated, TranslateResult)
import Task
import Time
import Url
import View.I18n.Default
import View.Page as Page
import View.Route
import Widget.Util.Basic exposing (trim)


type alias State =
    { title : String
    , description : String

    -- 国际化
    , lang : Lang
    , textsWithoutI18n : List TextsNeedToBeTranslated
    , timeZone : Time.Zone
    , themeDark : Bool

    -- 路由
    , navKey : Nav.Key
    , navUrl : Url.Url

    -- 远程请求错误信息
    , remoteError : Maybe TranslateResult
    , currentPage : Page.Type

    -- 业务数据
    , topicCards : RemoteTopicCards

    -- 操作数据
    , topicSearchingText : Maybe String
    , newTopic : Maybe EditTopic
    , editTopic : Maybe EditTopic
    , topicTagEditInputId : String
    }


type alias Config =
    { title : String
    , description : String
    , lang : String
    , navKey : Nav.Key
    , navUrl : Url.Url
    }


type alias RemoteTopicCards =
    RemoteData.Status (TreeStore TopicCard)


init : Config -> ( State, Cmd Msg )
init config =
    let
        ( state, cmd ) =
            { title = config.title
            , description = config.description

            --
            , lang =
                I18n.Lang.fromStringWithDefault
                    View.I18n.Default.lang
                    config.lang
            , textsWithoutI18n = []
            , timeZone = Time.utc
            , themeDark = True

            --
            , navKey = config.navKey
            , navUrl = config.navUrl

            --
            , remoteError = Nothing
            , currentPage = Page.Loading

            --
            , topicCards = RemoteData.LoadWaiting

            --
            , topicSearchingText = Nothing
            , newTopic = Nothing
            , editTopic = Nothing
            , topicTagEditInputId = "topic-tag-edit-input"
            }
                |> routeUpdateHelper config.navUrl
    in
    ( state
    , Cmd.batch
        [ cmd
        , Task.perform Msg.AdjustTimeZone Time.here
        ]
    )


sub : State -> Sub Msg
sub state =
    Sub.batch
        [ I18n.Port.sub Msg.I18nPortMsg
        ]


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        Msg.RemoteMsg remoteMsg ->
            remoteUpdateHelper remoteMsg state

        Msg.UrlChanged url ->
            routeUpdateHelper url state

        Msg.I18nPortMsg i18nPortMsg ->
            i18nUpdateHelper i18nPortMsg state

        Msg.SwitchToDarkTheme dark ->
            ( { state | themeDark = dark }
            , Cmd.none
            )

        Msg.AdjustTimeZone zone ->
            ( { state | timeZone = zone }
            , Cmd.none
            )

        Msg.SearchTopicInputing keywords ->
            ( { state
                | topicSearchingText = Just keywords
              }
            , Cmd.none
            )

        Msg.SearchTopic ->
            ( state
            , View.Route.searchTopics
                (state.topicSearchingText |> Maybe.withDefault "")
                state.navKey
            )

        Msg.TopicCardMsg topicId topicCardMsg ->
            topicCardUpdateHelper topicId topicCardMsg state

        Msg.RemoveTopicCard topicId ->
            ( state |> removeTopicCard topicId
            , Cmd.none
            )

        Msg.NewTopicPending ->
            ( { state | newTopic = Just EditTopic.init }
            , Cmd.none
            )

        Msg.NewTopicMsg newTopicMsg ->
            newTopicUpdateHelper newTopicMsg state

        Msg.NewTopicSaving ->
            newTopicSavingHelper state

        Msg.NewTopicCleaned ->
            ( { state
                | newTopic = Nothing
              }
            , Cmd.none
            )

        Msg.EditTopicPending topicId ->
            ( state |> initEditTopic topicId
            , Cmd.none
            )

        Msg.EditTopicMsg editTopicMsg ->
            editTopicUpdateHelper editTopicMsg state

        Msg.EditTopicSaving ->
            editTopicSavingHelper state

        Msg.EditTopicCleaned ->
            ( { state | editTopic = Nothing }
            , Cmd.none
            )

        _ ->
            ( state, Cmd.none )


getTopic : String -> State -> Maybe Topic
getTopic topicId { topicCards } =
    topicCards
        |> RemoteData.andThen
            (TreeStore.get topicId)
        |> Maybe.map .topic


updateTopicCard : String -> TopicCard.Msg -> State -> State
updateTopicCard topicId topicCardMsg state =
    state
        |> updateTopicCardHelper topicId
            (TopicCard.update
                topicCardMsg
            )


removeTopicCard : String -> State -> State
removeTopicCard topicId ({ topicCards } as state) =
    { state
        | topicCards =
            topicCards
                |> RemoteData.update
                    (TreeStore.removeById topicId)
    }


updateNewTopic :
    (EditTopic -> EditTopic)
    -> State
    -> State
updateNewTopic updater ({ newTopic } as state) =
    { state | newTopic = newTopic |> Maybe.map updater }


prepareSavingNewTopic : State -> ( Maybe EditTopic, Maybe Topic )
prepareSavingNewTopic { lang, newTopic } =
    newTopic
        |> Maybe.map
            (\newTopic_ ->
                case trim newTopic_.content of
                    Nothing ->
                        ( Just
                            (newTopic_
                                |> EditTopic.error
                                    ([ "主题内容是空白的，请先输入点什么" ]
                                        |> I18n.translate lang
                                    )
                            )
                        , Nothing
                        )

                    _ ->
                        ( Just { newTopic_ | updating = True }
                        , Just (EditTopic.to newTopic_)
                        )
            )
        |> Maybe.withDefault ( newTopic, Nothing )


updateSavedNewTopic :
    Result Http.Error Topic
    -> State
    -> State
updateSavedNewTopic result ({ lang } as state) =
    case result of
        Ok topic ->
            state
                |> updateNewTopic
                    EditTopic.clean
                |> updateNewTopic
                    (EditTopic.info
                        ([ "新增主题已保存成功" ]
                            |> I18n.translate lang
                        )
                    )
                |> addTopicHelper topic

        Err error ->
            state
                |> updateNewTopic
                    (EditTopic.error
                        (Remote.parseError lang error)
                    )
                |> updateNewTopic (\t -> { t | updating = False })


initEditTopic :
    String
    -> State
    -> State
initEditTopic topicId state =
    { state
        | editTopic =
            state
                |> getTopic topicId
                |> Maybe.map EditTopic.from
    }


updateEditTopic :
    (EditTopic -> EditTopic)
    -> State
    -> State
updateEditTopic updater ({ editTopic } as state) =
    { state | editTopic = editTopic |> Maybe.map updater }


prepareSavingEditTopic : State -> ( Maybe EditTopic, Maybe Topic )
prepareSavingEditTopic ({ lang, editTopic } as state) =
    editTopic
        |> Maybe.map
            (\editTopic_ ->
                case trim editTopic_.content of
                    Nothing ->
                        ( Just
                            (editTopic_
                                |> EditTopic.error
                                    ([ "主题内容是空白的，请先输入点什么" ]
                                        |> I18n.translate lang
                                    )
                            )
                        , Nothing
                        )

                    _ ->
                        ( Just { editTopic_ | updating = True }
                        , state
                            |> getTopic editTopic_.id
                            |> Maybe.map
                                (EditTopic.patch editTopic_)
                        )
            )
        |> Maybe.withDefault ( editTopic, Nothing )


updateSavedEditTopic :
    Result Http.Error Topic
    -> State
    -> State
updateSavedEditTopic result ({ lang } as state) =
    case result of
        Ok topic ->
            state
                |> updateEditTopic
                    (EditTopic.info
                        ([ "当前主题已更新成功" ]
                            |> I18n.translate lang
                        )
                    )
                |> updateEditTopic (\t -> { t | updating = False })
                |> addTopicHelper topic

        Err error ->
            state
                |> updateEditTopic
                    (EditTopic.error
                        (Remote.parseError lang error)
                    )
                |> updateEditTopic (\t -> { t | updating = False })



-- --------------------------------------------------------------------


addTopicHelper :
    Topic
    -> State
    -> State
addTopicHelper topic ({ topicCards } as state) =
    let
        addTopicToStore topic_ store =
            store
                |> TreeStore.add
                    (store
                        |> TreeStore.get topic_.id
                        |> Maybe.map
                            (\topicCard ->
                                { topicCard | topic = topic_ }
                            )
                        |> Maybe.withDefault (TopicCard.create topic_)
                    )
    in
    { state
        | topicCards =
            topicCards
                |> RemoteData.update
                    (addTopicToStore topic)
    }


updateTopicCardHelper :
    String
    -> (TopicCard -> TopicCard)
    -> State
    -> State
updateTopicCardHelper topicId updater ({ topicCards } as state) =
    topicCards
        |> RemoteData.andThen
            (TreeStore.get topicId)
        |> Maybe.map
            (\topicCard ->
                { state
                    | topicCards =
                        topicCards
                            |> RemoteData.update
                                (TreeStore.add
                                    (updater topicCard)
                                )
                }
            )
        |> Maybe.withDefault state


createTopicCardsHelper : List Topic -> TreeStore TopicCard
createTopicCardsHelper topics =
    let
        posixToMillis posixMaybe =
            posixMaybe
                |> Maybe.map Time.posixToMillis
                |> Maybe.withDefault 0
    in
    TreeStore.create
        { idGetter = \{ topic } -> topic.id
        , parentGetter = \_ -> Nothing
        , sorter =
            Just
                (\a b ->
                    compare
                        (posixToMillis b.topic.updatedAt)
                        (posixToMillis a.topic.updatedAt)
                )
        }
        (topics |> List.map TopicCard.create)


{-| 远程请求更新
-}
remoteUpdateHelper :
    RemoteMsg.Msg
    -> State
    -> ( State, Cmd Msg )
remoteUpdateHelper msg state =
    case msg of
        RemoteMsg.QueryMyTopics result ->
            ( { state
                | topicCards =
                    result
                        |> RemoteData.from
                            state.lang
                            createTopicCardsHelper
              }
            , Cmd.none
            )

        RemoteMsg.SaveMyNewTopic result ->
            ( state
                |> updateSavedNewTopic result
            , Cmd.none
            )

        RemoteMsg.SaveMyEditTopic result ->
            ( state
                |> updateSavedEditTopic result
            , Cmd.none
            )

        RemoteMsg.TrashMyTopic topicId result ->
            ( state
                |> updateTopicCard topicId
                    (case result of
                        Ok _ ->
                            TopicCard.Trash Operation.Done

                        Err e ->
                            TopicCard.Trash
                                (Operation.Error
                                    (Remote.parseError state.lang e)
                                )
                    )
            , Cmd.none
            )

        _ ->
            ( state, Cmd.none )


routeUpdateHelper : Url.Url -> State -> ( State, Cmd Msg )
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
                            { state
                                | topicSearchingText = keywords
                            }
                                |> doRemoteQueryMyTopics
                    in
                    ( Page.Home, s, c )

                View.Route.Forbidden ->
                    ( Page.Forbidden, state, Cmd.none )

                View.Route.NotFound ->
                    ( Page.NotFound, state, Cmd.none )
    in
    ( newState
        |> (\app ->
                { app
                    | currentPage = page
                    , navUrl = navUrl
                }
           )
    , cmd
    )


i18nUpdateHelper : I18n.Port.Msg -> State -> ( State, Cmd Msg )
i18nUpdateHelper msg state =
    case I18n.Port.update msg of
        ( r, m ) ->
            ( { state
                | textsWithoutI18n = r.results
              }
            , m
            )


topicCardUpdateHelper :
    String
    -> TopicCard.Msg
    -> State
    -> ( State, Cmd Msg )
topicCardUpdateHelper topicId msg state =
    ( state
        |> updateTopicCard topicId msg
    , case msg of
        TopicCard.Trash op ->
            case op of
                Operation.Doing ->
                    Msg.fromRemoteCmd
                        (RemoteTopic.trashMyTopic topicId)

                _ ->
                    Cmd.none

        _ ->
            Cmd.none
    )


newTopicUpdateHelper :
    EditTopic.Msg
    -> State
    -> ( State, Cmd Msg )
newTopicUpdateHelper msg state =
    ( state
        |> updateNewTopic
            (EditTopic.update msg)
    , case msg of
        EditTopic.TagDeleted _ ->
            Msg.focusOn state.topicTagEditInputId

        _ ->
            Cmd.none
    )


newTopicSavingHelper :
    State
    -> ( State, Cmd Msg )
newTopicSavingHelper state =
    let
        ( newTopic, topic ) =
            prepareSavingNewTopic state
    in
    ( state
        |> (\s -> { s | newTopic = newTopic })
    , topic
        |> Maybe.map
            (\t ->
                Msg.fromRemoteCmd
                    (RemoteTopic.saveMyNewTopic t)
            )
        |> Maybe.withDefault
            Cmd.none
    )


editTopicSavingHelper :
    State
    -> ( State, Cmd Msg )
editTopicSavingHelper state =
    let
        ( editTopic, topic ) =
            prepareSavingEditTopic state
    in
    ( state
        |> (\s -> { s | editTopic = editTopic })
    , topic
        |> Maybe.map
            (\t ->
                Msg.fromRemoteCmd
                    (RemoteTopic.saveMyEditTopic t)
            )
        |> Maybe.withDefault
            Cmd.none
    )


editTopicUpdateHelper :
    EditTopic.Msg
    -> State
    -> ( State, Cmd Msg )
editTopicUpdateHelper msg state =
    ( state
        |> updateEditTopic
            (EditTopic.update msg)
    , case msg of
        EditTopic.TagDeleted _ ->
            Msg.focusOn state.topicTagEditInputId

        _ ->
            Cmd.none
    )


doRemoteQueryMyTopics : State -> ( State, Cmd Msg )
doRemoteQueryMyTopics state =
    ( state
        |> (\app ->
                { app
                    | topicCards = RemoteData.Loading
                }
           )
    , Cmd.batch
        [ Msg.fromRemoteCmd
            (RemoteTopic.queryMyTopics
                { keyword = state.topicSearchingText
                , tags = Nothing
                }
            )
        ]
    )
