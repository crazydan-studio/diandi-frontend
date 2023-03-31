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
    , getNewTopicWithInit
    , init
    , sub
    , update
    )

import Browser.Navigation as Nav
import Http
import I18n.I18n exposing (I18nElement, withI18nElement)
import I18n.Port
import Model.App as App
import Model.Operation.EditTopic as EditTopic
import Model.Operation.NewTopic as NewTopic exposing (NewTopic)
import Model.Remote as Remote
import Model.Remote.Demo.Topic as RemoteTopic
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
    , lang : String
    }


type alias State =
    { -- 应用状态
      app : App.State
    , theme : Theme.Theme Msg.Msg
    , withI18nElement : I18nElement Msg.Msg

    -- 组件内部状态
    , widgets : Widget.Widgets Msg.Msg
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
                , lang = config.lang
                , navKey = navKey
                , navUrl = navUrl
                }

        ( state, cmd ) =
            { app = app
            , theme = Theme.create ThemeDefault.init
            , withI18nElement = withI18nElement app.lang
            , widgets = widgets
            }
                |> routeUpdateHelper navUrl
    in
    ( state, Cmd.batch [ widgetsCmd, cmd ] )


sub : State -> Sub Msg.Msg
sub state =
    Sub.batch
        [ I18n.Port.sub Msg.I18nPortMsg
        , Widget.sub state.widgets
        ]


update : Msg.Msg -> State -> ( State, Cmd Msg.Msg )
update msg state =
    case msg of
        Msg.RemoteMsg remoteMsg ->
            remoteUpdateHelper remoteMsg state

        Msg.UrlChanged url ->
            routeUpdateHelper url state

        Msg.I18nPortMsg i18nPortMsg ->
            i18nUpdateHelper i18nPortMsg state

        Msg.WidgetMsg widgetMsg ->
            state |> updateWidgetsState (Widget.update widgetMsg)

        Msg.SearchTopicMsg text ->
            state
                |> updateAppState
                    (App.updateTopicSearchingText text)
                |> doRemoteQueryMyTopics

        Msg.DropTopicMsg topicId ->
            ( state
                |> updateAppState
                    (App.removeTopic topicId)
            , Cmd.none
            )

        Msg.ShowTopicsList keywords ->
            ( state, View.Route.showTopics keywords state.app )

        Msg.NewTopicMsg inputId newTopicMsg ->
            newTopicUpdateHelper inputId newTopicMsg state

        Msg.EditTopicMsg topicId editTopicMsg ->
            editTopicUpdateHelper topicId editTopicMsg state

        Msg.NewTopicAdded inputId ->
            ( state |> updateAppState (App.addNewTopic inputId)
            , Cmd.batch
                [ Msg.focusOn inputId
                , Msg.scrollToBottom state.app.topicListViewId
                ]
            )

        Msg.EditTopicUpdated topicId ->
            ( state |> updateAppState (App.updateTopicByEdit topicId)
            , Cmd.none
            )

        _ ->
            ( state, Cmd.none )


getNewTopicWithInit : String -> State -> NewTopic
getNewTopicWithInit inputId { app } =
    App.getNewTopicWithInit inputId app



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


{-| 远程请求更新
-}
remoteUpdateHelper :
    RemoteMsg.Msg
    -> State
    -> ( State, Cmd Msg.Msg )
remoteUpdateHelper msg state =
    case msg of
        RemoteMsg.QueryMyTopics result ->
            ( state
                |> updateAppState
                    (App.loadTopics result)
            , Cmd.none
            )

        _ ->
            ( state, Cmd.none )


{-| 远程请求异常的统一处理
-}
remoteErrorUpdateHelper : Http.Error -> State -> ( State, Cmd Msg.Msg )
remoteErrorUpdateHelper error ({ app } as state) =
    case error of
        Http.BadStatus status ->
            if status == 403 then
                ( state, View.Route.goto403 app )

            else if status == 404 then
                ( state, View.Route.goto404 app )

            else
                ( state, Cmd.none )

        _ ->
            ( { state
                | app =
                    { app
                        | remoteError =
                            Just (Remote.parseError app.lang error)
                    }
              }
            , Cmd.none
            )


routeUpdateHelper : Url.Url -> State -> ( State, Cmd Msg.Msg )
routeUpdateHelper navUrl state =
    let
        ( page, newState, cmd ) =
            case View.Route.route navUrl of
                View.Route.Home ->
                    let
                        ( s, c ) =
                            doRemoteQueryMyTopics state
                    in
                    ( Page.Home, s, c )

                View.Route.TopicsList keywords ->
                    let
                        ( s, c ) =
                            state
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
    String
    -> NewTopic.Msg
    -> State
    -> ( State, Cmd Msg.Msg )
newTopicUpdateHelper inputId msg state =
    ( state
        |> updateAppState
            (App.updateNewTopic inputId
                (NewTopic.update msg)
            )
    , case msg of
        NewTopic.InputFocusIn ->
            Msg.focusOn inputId

        _ ->
            Cmd.none
    )


editTopicUpdateHelper :
    String
    -> EditTopic.Msg
    -> State
    -> ( State, Cmd Msg.Msg )
editTopicUpdateHelper topicId msg state =
    ( state
        |> updateAppState
            (App.updateEditTopic topicId
                (EditTopic.update msg)
            )
    , case msg of
        EditTopic.InputFocusIn ->
            Msg.focusOn topicId

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
                { keywords = state.app.topicSearchingText
                }
            )
        ]
    )
