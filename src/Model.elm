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
    , State
    , init
    , sub
    , update
    )

import Browser.Events as Events
import Browser.Navigation as Nav
import Element exposing (classifyDevice)
import I18n.I18n exposing (I18nElement, withI18nElement)
import I18n.Port
import Model.App as App
import Model.Operation.EditTopic as EditTopic
import Model.Remote.GraphQL.Topic as RemoteTopic
import Model.Remote.Msg as RemoteMsg
import Msg
import Theme.Theme as Theme
import Theme.Theme.Default as ThemeDefault
import Url
import View.Page as Page
import View.Route
import Widget.Widget as Widget


type alias Config =
    { title : String
    , description : String
    , screen : { width : Int, height : Int }
    , lang : String
    }


type alias State =
    { -- 应用状态
      app : App.State
    , theme : Theme.Theme Msg.Msg
    , withI18nElement : I18nElement Msg.Msg

    -- 组件内部状态
    , widgets : Widget.Widgets Msg.Msg
    , layers : List Page.Layer
    }


init : Config -> Url.Url -> Nav.Key -> ( State, Cmd Msg.Msg )
init config navUrl navKey =
    let
        ( widgets, widgetsCmd ) =
            Widget.init
                { toAppMsg = Msg.WidgetMsg
                }

        app =
            App.init
                { title = config.title
                , description = config.description
                , device = classifyDevice config.screen
                , lang = config.lang
                , navKey = navKey
                , navUrl = navUrl
                }

        ( state, cmd ) =
            { app = app
            , theme = Theme.create ThemeDefault.init
            , withI18nElement = withI18nElement app.lang
            , widgets = widgets
            , layers = []
            }
                |> routeUpdateHelper navUrl
    in
    ( state, Cmd.batch [ widgetsCmd, cmd ] )


sub : State -> Sub Msg.Msg
sub state =
    Sub.batch
        [ Events.onResize (\w h -> Msg.ScreenResize w h)
        , I18n.Port.sub Msg.I18nPortMsg
        , Widget.sub state.widgets
        ]


update : Msg.Msg -> State -> ( State, Cmd Msg.Msg )
update msg state =
    case msg of
        Msg.Batch msgs ->
            batchUpdateHelper msgs state

        Msg.RemoteMsg remoteMsg ->
            remoteUpdateHelper remoteMsg state

        Msg.UrlChanged url ->
            routeUpdateHelper url state

        Msg.I18nPortMsg i18nPortMsg ->
            i18nUpdateHelper i18nPortMsg state

        Msg.WidgetMsg widgetMsg ->
            state |> updateWidgetsState (Widget.update widgetMsg)

        Msg.ScreenResize w h ->
            ( state
                |> updateAppState
                    (App.updateDevice
                        (classifyDevice { width = w, height = h })
                    )
            , Cmd.none
            )

        Msg.SearchTopicInputing keywords ->
            ( state
                |> updateAppState
                    (App.updateTopicSearchingText (Just keywords))
            , Cmd.none
            )

        Msg.SearchTopic ->
            ( state
            , View.Route.searchTopics
                (state.app.topicSearchingText |> Maybe.withDefault "")
                state.app
            )

        Msg.DeleteTopic topicId ->
            ( state
            , Msg.toRemoteCmd
                (RemoteTopic.deleteMyTopic topicId)
            )

        Msg.DeleteTopicPending topicId ->
            -- TODO 显示等待遮罩，向后端发起删除请求，成功后，显示删除动画，并在动画结束后执行前端清理
            ( state |> updateAppState (App.addToRemovingTopics topicId)
            , Cmd.none
            )

        Msg.NewTopicPending ->
            ( state |> updateAppState App.initNewTopic
            , Cmd.none
            )

        Msg.NewTopicMsg newTopicMsg ->
            newTopicUpdateHelper newTopicMsg state

        Msg.NewTopicSaving ->
            newTopicSavingHelper state

        Msg.NewTopicCleaned ->
            ( state |> updateAppState App.cleanNewTopic
            , Cmd.none
            )

        Msg.EditTopicPending topicId ->
            ( state |> updateAppState (App.initEditTopic topicId)
            , Cmd.none
            )

        Msg.EditTopicMsg editTopicMsg ->
            editTopicUpdateHelper editTopicMsg state

        Msg.EditTopicSaving ->
            editTopicSavingHelper state

        Msg.EditTopicCleaned ->
            ( state |> updateAppState App.cleanEditTopic
            , Cmd.none
            )

        Msg.ShowPageLayer layer ->
            ( { state
                | layers = layer :: state.layers
              }
            , case layer of
                Page.NewTopicLayer ->
                    Msg.focusOn state.app.topicEditInputId

                Page.EditTopicLayer ->
                    Msg.focusOn state.app.topicEditInputId

                _ ->
                    Cmd.none
            )

        Msg.ClosePageLayer layer ->
            ( { state
                | layers =
                    state.layers
                        |> List.filter (\l -> l /= layer)
              }
            , Cmd.none
            )

        _ ->
            ( state, Cmd.none )



-- -------------------------------------------------------------------


updateAppState :
    (App.State -> App.State)
    -> State
    -> State
updateAppState updater ({ app } as state) =
    let
        newApp =
            updater app
    in
    { state
        | app = newApp
        , withI18nElement = withI18nElement newApp.lang
    }


updateWidgetsState :
    Widget.Updater Msg.Msg
    -> State
    -> ( State, Cmd Msg.Msg )
updateWidgetsState updater ({ widgets } as state) =
    let
        ( newWidgets, newWidgetsCmd ) =
            updater widgets
    in
    ( { state
        | widgets = newWidgets
      }
    , newWidgetsCmd
    )


batchUpdateHelper : List Msg.Msg -> State -> ( State, Cmd Msg.Msg )
batchUpdateHelper msgs state =
    msgs
        |> List.foldl
            (\msg ( s, c ) ->
                let
                    ( ns, nc ) =
                        update msg s
                in
                ( ns, Cmd.batch [ c, nc ] )
            )
            ( state, Cmd.none )


{-| 远程请求更新
-}
remoteUpdateHelper :
    RemoteMsg.Msg
    -> State
    -> ( State, Cmd Msg.Msg )
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
            , Msg.focusOn app.topicEditInputId
            )

        RemoteMsg.SaveMyEditTopic result ->
            ( state
                |> updateAppState
                    (App.updateSavedEditTopic result)
            , Msg.focusOn app.topicEditInputId
            )

        RemoteMsg.DeleteMyTopic result ->
            case result of
                Ok topicId ->
                    ( state
                        |> updateAppState
                            (App.removeTopic topicId)
                    , Cmd.none
                    )

                _ ->
                    ( state, Cmd.none )

        _ ->
            ( state, Cmd.none )


routeUpdateHelper : Url.Url -> State -> ( State, Cmd Msg.Msg )
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


i18nUpdateHelper : I18n.Port.Msg -> State -> ( State, Cmd Msg.Msg )
i18nUpdateHelper msg ({ app } as state) =
    case I18n.Port.update msg of
        ( r, m ) ->
            ( { state
                | app = { app | textsWithoutI18n = r.results }
              }
            , m
            )


newTopicUpdateHelper :
    EditTopic.Msg
    -> State
    -> ( State, Cmd Msg.Msg )
newTopicUpdateHelper msg state =
    ( state
        |> updateAppState
            (App.updateNewTopic
                (EditTopic.update msg)
            )
    , case msg of
        EditTopic.TagDeleted _ ->
            Msg.focusOn state.app.topicTagEditInputId

        _ ->
            Cmd.none
    )


newTopicSavingHelper :
    State
    -> ( State, Cmd Msg.Msg )
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
                Msg.toRemoteCmd
                    (RemoteTopic.saveMyNewTopic t)
            )
        |> Maybe.withDefault Cmd.none
    )


editTopicSavingHelper :
    State
    -> ( State, Cmd Msg.Msg )
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
                Msg.toRemoteCmd
                    (RemoteTopic.saveMyEditTopic t)
            )
        |> Maybe.withDefault Cmd.none
    )


editTopicUpdateHelper :
    EditTopic.Msg
    -> State
    -> ( State, Cmd Msg.Msg )
editTopicUpdateHelper msg state =
    ( state
        |> updateAppState
            (App.updateEditTopic
                (EditTopic.update msg)
            )
    , case msg of
        EditTopic.TagDeleted _ ->
            Msg.focusOn state.app.topicTagEditInputId

        _ ->
            Cmd.none
    )


doRemoteQueryMyTopics : State -> ( State, Cmd Msg.Msg )
doRemoteQueryMyTopics state =
    ( state
        |> updateAppState
            (\app ->
                { app
                    | topics = App.loading
                }
            )
    , Cmd.batch
        [ Msg.toRemoteCmd
            (RemoteTopic.queryMyTopics
                { keyword = state.app.topicSearchingText
                , tags = []
                }
            )
        ]
    )
