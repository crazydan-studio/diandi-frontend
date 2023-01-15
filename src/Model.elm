module Model exposing
    ( Config
    , State
    , init
    , sub
    , update
    )

import Browser.Navigation as Nav
import Http
import I18n.Port
import Model.App
import Model.Remote as Remote
import Model.Remote.Auth as RemoteAuth
import Model.Remote.Msg as RemoteMsg
import Model.Remote.Topic as RemoteTopic
import Model.Remote.User as RemoteUser
import Model.User as User
import Msg
import Url
import View.Page as PageType
import View.Route
import Widget.Model


type alias Config =
    { title : String
    , description : String
    , lang : String
    }


type alias State =
    { -- 应用状态
      app : Model.App.State

    -- 组件内部状态
    , ui : Widget.Model.State Msg.Msg
    }


init : Config -> Url.Url -> Nav.Key -> ( State, Cmd Msg.Msg )
init config navUrl navKey =
    { app =
        Model.App.init
            { title = config.title
            , description = config.description
            , lang = config.lang
            , navKey = navKey
            , navUrl = navUrl
            }
    , ui = Widget.Model.init Msg.WidgetMsg
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
            ( { state
                | ui = state.ui |> Widget.Model.update widgetMsg
              }
            , Cmd.none
            )

        _ ->
            ( state, Cmd.none )



-- -------------------------------------------------------------------


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
                                , topics = Model.App.loading
                                , categories = Model.App.loading
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
                | app = app |> Model.App.loadTopics result
              }
            , Cmd.none
            )

        RemoteMsg.QueryMyTopicCategories result ->
            ( { state
                | app = app |> Model.App.loadTopicCategories result
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
                | app = { app | remoteError = Just (Remote.parseError error) }
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
