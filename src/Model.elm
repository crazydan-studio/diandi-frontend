module Model exposing (Flags, RootModel, init, sub, update)

import Browser.Navigation as Nav
import Http
import Model.User as User
import Msg exposing (..)
import Page.Type as PageType exposing (ErrorPage)
import Remote exposing (RemoteMsg, getMyUserInfo)
import Url


type alias RootModel =
    { title : String
    , description : String
    , lang : String

    -- 当前用户信息
    , me : User.User

    -- 远程请求错误信息
    , remoteError : Maybe String
    , errorPage : ErrorPage
    }


type alias Flags =
    { title : String
    , description : String
    , lang : String
    }


init : Flags -> Url.Url -> Nav.Key -> ( RootModel, Cmd RootMsg )
init flags url key =
    ( { title = flags.title
      , description = flags.description
      , lang = flags.lang
      , me = User.None
      , remoteError = Nothing
      , errorPage = PageType.Loading
      }
    , remote getMyUserInfo
    )


sub : RootModel -> Sub RootMsg
sub _ =
    Sub.none


update : RootMsg -> RootModel -> ( RootModel, Cmd RootMsg )
update msg model =
    case msg of
        RemoteFetched remoteMsg ->
            remoteUpdateHelper remoteMsg model

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
                    -- TODO 获取首页数据
                    ( { model | me = User.User user, errorPage = PageType.None }, Cmd.none )

                Err error ->
                    let
                        ( newModel, newMsg ) =
                            remoteErrorUpdateHelper error model
                    in
                    case newModel.errorPage of
                        PageType.NotFound ->
                            ( { newModel | errorPage = PageType.Login }, Cmd.none )

                        _ ->
                            ( newModel, newMsg )

        _ ->
            ( model, Cmd.none )


{-| 远程请求异常的统一处理
-}
remoteErrorUpdateHelper : Http.Error -> RootModel -> ( RootModel, Cmd RootMsg )
remoteErrorUpdateHelper error model =
    case error of
        Http.BadStatus status ->
            if status == 401 then
                ( { model | errorPage = PageType.Login }, Cmd.none )

            else if status == 403 then
                ( { model | errorPage = PageType.Forbidden }, Cmd.none )

            else if status == 404 then
                ( { model | errorPage = PageType.NotFound }, Cmd.none )

            else
                ( model, Cmd.none )

        Http.Timeout ->
            ( { model | remoteError = Just "网络请求超时，请稍后再试" }, Cmd.none )

        Http.NetworkError ->
            ( { model | remoteError = Just "网络连接异常，请稍后再试" }, Cmd.none )

        _ ->
            ( model, Cmd.none )
