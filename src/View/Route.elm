module View.Route exposing
    ( Route(..)
    , goto403
    , goto404
    , gotoHome
    , gotoLogin
    , gotoLogout
    , route
    )

import Browser.Navigation as Nav
import Model.Root exposing (RootModel)
import Msg
import Url
import Url.Parser exposing ((</>), Parser, map, oneOf, parse, s, top)


type Route
    = Login
    | Logout
    | Home
    | Forbidden
    | NotFound


{-| 解析URL得到路由信息
-}
route : Url.Url -> Route
route url =
    Maybe.withDefault NotFound (parse routeHelper url)


gotoLogin : RootModel -> ( RootModel, Cmd Msg.Msg )
gotoLogin model =
    goto "/login" model


gotoLogout : RootModel -> ( RootModel, Cmd Msg.Msg )
gotoLogout model =
    goto "/logout" model


gotoHome : RootModel -> ( RootModel, Cmd Msg.Msg )
gotoHome model =
    goto "/" model


goto403 : RootModel -> ( RootModel, Cmd Msg.Msg )
goto403 model =
    goto "/error/403" model


goto404 : RootModel -> ( RootModel, Cmd Msg.Msg )
goto404 model =
    goto "/error/404" model



-- --------------------------------------------------------------


routeHelper : Parser (Route -> a) a
routeHelper =
    -- https://package.elm-lang.org/packages/elm/url/latest/Url-Parser
    oneOf
        [ map Home top
        , map Login (s "login")
        , map Logout (s "logout")
        , map Forbidden (s "error" </> s "403")
        ]


goto : String -> RootModel -> ( RootModel, Cmd Msg.Msg )
goto url model =
    ( model, Nav.pushUrl model.navKey url )
