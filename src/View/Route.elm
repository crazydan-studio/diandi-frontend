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
import Model.App
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


gotoLogin : Model.App.State -> Cmd msg
gotoLogin =
    goto "/login"


gotoLogout : Model.App.State -> Cmd msg
gotoLogout =
    goto "/logout"


gotoHome : Model.App.State -> Cmd msg
gotoHome =
    goto "/"


goto403 : Model.App.State -> Cmd msg
goto403 =
    goto "/error/403"


goto404 : Model.App.State -> Cmd msg
goto404 =
    goto "/error/404"



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


goto : String -> Model.App.State -> Cmd msg
goto url app =
    Nav.pushUrl app.navKey url
