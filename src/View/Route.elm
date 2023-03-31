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
    , route
    , searchTopics
    )

import Browser.Navigation as Nav
import Model.App as App
import Url
import Url.Parser
    exposing
        ( (</>)
        , (<?>)
        , Parser
        , map
        , oneOf
        , parse
        , s
        , top
        )
import Url.Parser.Query as Query
import Widget.Util.Basic exposing (trim)


type Route
    = Home
    | Forbidden
    | NotFound
    | TopicsSearch (Maybe String)


{-| 解析URL得到路由信息
-}
route : Url.Url -> Route
route url =
    Maybe.withDefault NotFound (parse routeHelper url)


gotoHome : App.State -> Cmd msg
gotoHome =
    goto "/"


goto403 : App.State -> Cmd msg
goto403 =
    goto "/error/403"


goto404 : App.State -> Cmd msg
goto404 =
    goto "/error/404"


searchTopics : String -> App.State -> Cmd msg
searchTopics keywords =
    let
        params =
            case trim keywords of
                Nothing ->
                    ""

                Just k ->
                    "?q=" ++ k
    in
    goto ("/topics" ++ params)



-- --------------------------------------------------------------


routeHelper : Parser (Route -> a) a
routeHelper =
    -- https://package.elm-lang.org/packages/elm/url/latest/Url-Parser
    oneOf
        [ map Home top
        , map TopicsSearch (s "topics" <?> Query.string "q")
        , map Forbidden (s "error" </> s "403")
        ]


goto : String -> App.State -> Cmd msg
goto url app =
    Nav.pushUrl app.navKey url
