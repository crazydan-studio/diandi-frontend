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
import I18n.Port
import Model.App as App
import Model.Operation.EditTopic as EditTopic
import Model.Operation.NewTopic as NewTopic exposing (NewTopic)
import Model.Remote as Remote
import Model.Remote.Auth as RemoteAuth
import Model.Remote.Demo.Topic as RemoteTopic
import Model.Remote.Msg as RemoteMsg
import Model.Remote.User as RemoteUser
import Model.Topic.Category exposing (Category)
import Model.User as User
import Msg
import Theme.Theme as Theme
import Theme.Theme.Default as ThemeDefault
import Url
import View.Page as PageType
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
    in
    { app =
        App.init
            { title = config.title
            , description = config.description
            , lang = config.lang
            , navKey = navKey
            , navUrl = navUrl
            }
    , theme = Theme.create ThemeDefault.init
    , widgets = widgets
    , withWidgetContext = withWidgetContext
    }
        |> routeUpdateHelper navUrl


sub : State -> Sub Msg.Msg
sub _ =
    Sub.batch
        [ I18n.Port.sub Msg.I18nPortMsg
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

        Msg.TopicCategorySelected categoryId ->
            ( state
                |> updateAppState
                    (\a ->
                        { a
                            | selectedTopicCategory = Just categoryId
                        }
                    )
            , Cmd.none
            )

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
    { state | app = updater app }


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
remoteUpdateHelper msg ({ app } as state) =
    case msg of
        RemoteMsg.GotMyUserInfo result ->
            case result of
                Ok user ->
                    ( { state
                        | app =
                            { app
                                | me = User.User user
                                , topics = App.loading
                                , categories = App.loading
                            }
                      }
                    , Cmd.batch
                        [ Msg.toRemoteCmd RemoteTopic.getMyAllTopics
                        , Msg.toRemoteCmd RemoteTopic.getMyAllCategories
                        ]
                    )

                Err _ ->
                    ( state, View.Route.gotoLogin app )

        RemoteMsg.UserLogout _ ->
            ( state, View.Route.gotoLogin app )

        RemoteMsg.QueryMyTopics result ->
            ( { state
                | app = app |> App.loadTopics result
              }
            , Cmd.none
            )

        RemoteMsg.QueryMyTopicCategories result ->
            ( { state
                | app = app |> App.loadTopicCategories result
              }
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
routeUpdateHelper navUrl ({ app } as state) =
    let
        ( page, cmd ) =
            case View.Route.route navUrl of
                View.Route.Login ->
                    ( PageType.Login, Cmd.none )

                View.Route.Logout ->
                    ( PageType.Login, Msg.toRemoteCmd RemoteAuth.logout )

                View.Route.Home ->
                    ( PageType.Home, Msg.toRemoteCmd RemoteUser.getMyUserInfo )

                View.Route.Forbidden ->
                    ( PageType.Forbidden, Cmd.none )

                View.Route.NotFound ->
                    ( PageType.NotFound, Cmd.none )
    in
    ( { state
        | app = { app | currentPage = page, navUrl = navUrl }
      }
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
