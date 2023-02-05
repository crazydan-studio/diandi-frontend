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


module View.Route exposing
    ( Route(..)
    , goto403
    , goto404
    , gotoHome
    , gotoLogin
    , gotoLogout
    , route
    , showTopics
    )

import Browser.Navigation as Nav
import Model.App as App
import Url
import Url.Parser
    exposing
        ( (</>)
        , Parser
        , map
        , oneOf
        , parse
        , s
        , string
        , top
        )


type Route
    = Login
    | Logout
    | Home
    | Forbidden
    | NotFound
    | TopicsList String


{-| 解析URL得到路由信息
-}
route : Url.Url -> Route
route url =
    Maybe.withDefault NotFound (parse routeHelper url)


gotoLogin : App.State -> Cmd msg
gotoLogin =
    goto "/login"


gotoLogout : App.State -> Cmd msg
gotoLogout =
    goto "/logout"


gotoHome : App.State -> Cmd msg
gotoHome =
    goto "/"


goto403 : App.State -> Cmd msg
goto403 =
    goto "/error/403"


goto404 : App.State -> Cmd msg
goto404 =
    goto "/error/404"


showTopics : String -> App.State -> Cmd msg
showTopics categoryId =
    goto ("/topics/" ++ categoryId)



-- --------------------------------------------------------------


routeHelper : Parser (Route -> a) a
routeHelper =
    -- https://package.elm-lang.org/packages/elm/url/latest/Url-Parser
    oneOf
        [ map Home top
        , map TopicsList (s "topics" </> string)
        , map Login (s "login")
        , map Logout (s "logout")
        , map Forbidden (s "error" </> s "403")
        ]


goto : String -> App.State -> Cmd msg
goto url app =
    Nav.pushUrl app.navKey url
