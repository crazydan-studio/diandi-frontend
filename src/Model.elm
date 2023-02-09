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
    , getSelectedTopicCategory
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
import Model.Remote.Auth as RemoteAuth
import Model.Remote.Data as RemoteData
import Model.Remote.Demo.Topic as RemoteTopic
import Model.Remote.Demo.User as RemoteUser
import Model.Remote.Msg as RemoteMsg
import Model.Topic.Category exposing (Category)
import Model.User as User
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
    , widgets : Widget.State Msg.Msg
    , withWidgetContext : Widget.WithContext Msg.Msg
    }


init : Config -> Url.Url -> Nav.Key -> ( State, Cmd Msg.Msg )
init config navUrl navKey =
    let
        ( widgets, withWidgetContext ) =
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
    in
    { app = app
    , theme = Theme.create ThemeDefault.init
    , withI18nElement = withI18nElement app.lang
    , widgets = widgets
    , withWidgetContext = withWidgetContext
    }
        |> routeUpdateHelper navUrl


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
            ( state |> updateWidgetsState (Widget.update widgetMsg)
            , Cmd.none
            )

        Msg.ShowTopicsList categoryId ->
            ( state, View.Route.showTopics categoryId state.app )

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


getSelectedTopicCategory : State -> Maybe Category
getSelectedTopicCategory { app } =
    App.getSelectedTopicCategory app


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
    -> State
updateWidgetsState updater ({ widgets } as state) =
    let
        ( newWidgets, newWithWidgetContext ) =
            updater widgets
    in
    { state
        | widgets = newWidgets
        , withWidgetContext = newWithWidgetContext
    }


{-| 远程请求更新
-}
remoteUpdateHelper :
    RemoteMsg.Msg
    -> State
    -> ( State, Cmd Msg.Msg )
remoteUpdateHelper msg state =
    case msg of
        RemoteMsg.GotMyUserInfo result ->
            case result of
                Ok user ->
                    state
                        |> updateAppState
                            (\app ->
                                { app | me = User.User user }
                            )
                        |> doRemoteQueryMyTopics

                Err _ ->
                    ( state, View.Route.gotoLogin state.app )

        RemoteMsg.UserLogout _ ->
            ( state, View.Route.gotoLogin state.app )

        RemoteMsg.QueryMyTopics result ->
            ( state
                |> updateAppState
                    (App.loadTopics result)
            , Cmd.none
            )

        RemoteMsg.QueryMyTopicCategories result ->
            ( state
                |> updateAppState
                    (App.loadTopicCategories result)
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
            if status == 401 then
                ( state, View.Route.gotoLogin app )

            else if status == 403 then
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
                View.Route.Login ->
                    ( Page.Login, state, Cmd.none )

                View.Route.Logout ->
                    ( Page.Login, state, Msg.toRemoteCmd RemoteAuth.logout )

                View.Route.Home ->
                    let
                        ( s, c ) =
                            doRemoteWithAuthUser doRemoteQueryMyTopics state
                    in
                    ( Page.Home, s, c )

                View.Route.TopicsList categoryId ->
                    let
                        ( s, c ) =
                            state
                                |> updateAppState
                                    (\app ->
                                        { app | selectedTopicCategory = Just categoryId }
                                    )
                                |> doRemoteWithAuthUser doRemoteQueryMyTopics
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


doRemoteWithAuthUser :
    (State -> ( State, Cmd Msg.Msg ))
    -> State
    -> ( State, Cmd Msg.Msg )
doRemoteWithAuthUser doRemote ({ app } as state) =
    if User.isNone app.me then
        ( state, Msg.toRemoteCmd RemoteUser.getMyUserInfo )

    else
        doRemote state


doRemoteQueryMyTopics : State -> ( State, Cmd Msg.Msg )
doRemoteQueryMyTopics state =
    ( state
        |> updateAppState
            (\app ->
                { app
                    | categories =
                        app.categories
                            |> RemoteData.ifNotLoaded
                                App.loading
                    , topics = App.loading
                }
            )
    , Cmd.batch
        [ state.app.categories
            |> RemoteData.map
                (\_ ->
                    Cmd.none
                )
            |> Maybe.withDefault
                (Msg.toRemoteCmd
                    RemoteTopic.getMyAllCategories
                )
        , Msg.toRemoteCmd
            (RemoteTopic.queryMyTopics
                { category = state.app.selectedTopicCategory
                }
            )
        ]
    )
