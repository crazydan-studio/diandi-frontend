module Model exposing (Flags, init, sub, update)

import Browser.Navigation as Nav
import Http
import Model.Root exposing (RootModel)
import Model.User as User
import Msg exposing (..)
import Page.Type as PageType
import Remote exposing (RemoteMsg, getMyUserInfo)
import Route
import Url


type alias Flags =
    { title : String
    , description : String
    , lang : String
    }


init : Flags -> Url.Url -> Nav.Key -> ( RootModel, Cmd RootMsg )
init flags url key =
    { title = flags.title
    , description = flags.description
    , lang = flags.lang

    --
    , navKey = key
    , navUrl = url

    --
    , me = User.None
    , remoteError = Nothing
    , currentPage = PageType.Loading
    }
        |> routeUpdateHelper url


sub : RootModel -> Sub RootMsg
sub _ =
    Sub.none


update : RootMsg -> RootModel -> ( RootModel, Cmd RootMsg )
update msg model =
    case msg of
        RemoteFetched remoteMsg ->
            remoteUpdateHelper remoteMsg model

        UrlChanged url ->
            routeUpdateHelper url model

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
                    Route.gotoHome { model | me = User.User user }

                Err _ ->
                    Route.gotoLogin model

        Remote.UserLogout _ ->
            Route.gotoLogin model

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
                    ( PageType.Login, Cmd.none )

                Route.Logout ->
                    ( PageType.Login, remote Remote.logout )

                Route.Home ->
                    ( PageType.Home, remote getMyUserInfo )

                Route.Forbidden ->
                    ( PageType.Forbidden, Cmd.none )

                Route.NotFound ->
                    ( PageType.NotFound, Cmd.none )
    in
    ( { model | currentPage = page, navUrl = url }, cmd )
