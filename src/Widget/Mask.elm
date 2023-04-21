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


module Widget.Mask exposing (create)

import Html exposing (Html, div)
import Html.Attributes exposing (class)


type alias Config msg =
    { show : Bool
    , styles : List String
    , content : List (Html msg)
    }


create : Config msg -> Html msg
create { show, styles, content } =
    div
        [ class "w-full h-full"
        , class "absolute z-10"
        , class "flex p-8"
        , class "items-center justify-center"
        , class "rounded-md"
        , class "bg-black/60 dark:bg-black/50"
        , class "text-white text-base"
        , class "whitespace-pre-wrap break-all"
        , class
            (if show then
                ""

             else
                "hidden"
            )
        , styles |> String.join " " |> class
        ]
        content
