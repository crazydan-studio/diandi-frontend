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
    , filterTopics
    , goto403
    , goto404
    , gotoHome
    , route
    )

import App.TopicFilter exposing (TopicFilter)
import Browser.Navigation as Nav
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
    | TopicsFilter TopicFilter
    | TrashedTopicsFilter TopicFilter


{-| 解析URL得到路由信息
-}
route : Url.Url -> Route
route url =
    parse routeHelper url
        |> Maybe.withDefault NotFound


gotoHome : Nav.Key -> Cmd msg
gotoHome =
    goto "/"


goto403 : Nav.Key -> Cmd msg
goto403 =
    goto "/error/403"


goto404 : Nav.Key -> Cmd msg
goto404 =
    goto "/error/404"


filterTopics : TopicFilter -> Nav.Key -> Cmd msg
filterTopics { trashed, keyword, tags } =
    let
        params =
            (case trim (keyword |> Maybe.withDefault "") of
                Nothing ->
                    []

                Just k ->
                    [ "q=" ++ k ]
            )
                ++ (tags
                        |> List.map
                            (\tag ->
                                "tags=" ++ tag
                            )
                   )
    in
    goto
        ("/topics"
            ++ (if trashed then
                    "/trashed"

                else
                    ""
               )
            ++ (if params |> List.isEmpty then
                    ""

                else
                    "?" ++ (params |> String.join "&")
               )
        )



-- --------------------------------------------------------------


goto : String -> Nav.Key -> Cmd msg
goto url navKey =
    Nav.pushUrl navKey url


routeHelper : Parser (Route -> a) a
routeHelper =
    -- https://package.elm-lang.org/packages/elm/url/latest/Url-Parser
    oneOf
        [ map Home top
        , map TopicsFilter
            (map
                (\keyword tags ->
                    { keyword = keyword
                    , tags = tags
                    , trashed = False
                    }
                )
                (s "topics"
                    <?> Query.string "q"
                    <?> Query.custom "tags" identity
                )
            )
        , map TrashedTopicsFilter
            (map
                (\keyword tags ->
                    { keyword = keyword
                    , tags = tags
                    , trashed = True
                    }
                )
                (s "topics"
                    </> s "trashed"
                    <?> Query.string "q"
                    <?> Query.custom "tags" identity
                )
            )
        , map Forbidden (s "error" </> s "403")
        ]
