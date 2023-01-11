module Model exposing (Flags, init, sub, update)

import Browser.Navigation as Nav
import Http
import I18n.Lang
import I18n.Port
import Model.Root exposing (RootModel)
import Model.User as User
import Msg exposing (..)
import Remote exposing (RemoteMsg, getMyUserInfo)
import Route
import Url
import View.I18n.Default
import View.Type as ViewType


type alias Flags =
    { title : String
    , description : String
    , lang : String
    }


init : Flags -> Url.Url -> Nav.Key -> ( RootModel, Cmd RootMsg )
init flags url key =
    { title = flags.title
    , description = flags.description

    --
    , lang = I18n.Lang.fromStringWithDefault View.I18n.Default.lang flags.lang
    , textsWithoutI18n = []

    --
    , navKey = key
    , navUrl = url

    --
    , me = User.None
    , remoteError = Nothing
    , currentPage = ViewType.Loading

    --
    , topics = []
    }
        |> routeUpdateHelper url


sub : RootModel -> Sub RootMsg
sub _ =
    Sub.batch
        [ I18n.Port.sub I18nPorts
        ]


update : RootMsg -> RootModel -> ( RootModel, Cmd RootMsg )
update msg model =
    case msg of
        RemoteFetched remoteMsg ->
            remoteUpdateHelper remoteMsg model

        UrlChanged url ->
            routeUpdateHelper url model

        I18nPorts i18nMsg ->
            i18nUpdateHelper i18nMsg model

        _ ->
            ( model, Cmd.none )



-- -------------------------------------------------------------------


{-| 发起远程请求
-}
remote : Cmd RemoteMsg -> Cmd RootMsg
remote msg =
    Cmd.map RemoteFetched msg


{-| 远程请求更新
-}
remoteUpdateHelper : RemoteMsg -> RootModel -> ( RootModel, Cmd RootMsg )
remoteUpdateHelper msg model =
    case msg of
        Remote.GotMyUserInfo result ->
            case result of
                Ok user ->
                    ( { model
                        | me = User.User user
                      }
                    , remote Remote.getAllMyTopics
                    )

                Err _ ->
                    Route.gotoLogin model

        Remote.UserLogout _ ->
            Route.gotoLogin model

        Remote.QueryMyTopics result ->
            case result of
                Ok topics ->
                    ( { model
                        | topics = topics
                      }
                    , Cmd.none
                    )

                Err error ->
                    remoteErrorUpdateHelper error model

        _ ->
            ( model, Cmd.none )


{-| 远程请求异常的统一处理
-}
remoteErrorUpdateHelper : Http.Error -> RootModel -> ( RootModel, Cmd RootMsg )
remoteErrorUpdateHelper error model =
    case error of
        Http.BadStatus status ->
            if status == 401 then
                Route.gotoLogin model

            else if status == 403 then
                Route.goto403 model

            else if status == 404 then
                Route.goto404 model

            else
                ( model, Cmd.none )

        Http.Timeout ->
            ( { model | remoteError = Just "网络请求超时，请稍后再试" }, Cmd.none )

        Http.NetworkError ->
            ( { model | remoteError = Just "网络连接异常，请稍后再试" }, Cmd.none )

        _ ->
            ( model, Cmd.none )


routeUpdateHelper : Url.Url -> RootModel -> ( RootModel, Cmd RootMsg )
routeUpdateHelper url model =
    let
        ( page, cmd ) =
            case Route.route url of
                Route.Login ->
                    ( ViewType.Login, Cmd.none )

                Route.Logout ->
                    ( ViewType.Login, remote Remote.logout )

                Route.Home ->
                    ( ViewType.Home, remote getMyUserInfo )

                Route.Forbidden ->
                    ( ViewType.Forbidden, Cmd.none )

                Route.NotFound ->
                    ( ViewType.NotFound, Cmd.none )
    in
    ( { model | currentPage = page, navUrl = url }, cmd )


i18nUpdateHelper : I18n.Port.Msg -> RootModel -> ( RootModel, Cmd RootMsg )
i18nUpdateHelper msg model =
    case I18n.Port.update msg of
        ( r, m ) ->
            ( { model | textsWithoutI18n = r.results }, m )
