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


module Widget.Html exposing
    ( allPointerEvents
    , class
    , cursor
    , draggable
    , id
    , noPointerEvents
    , noUserSelect
    , style
    , styles
    , zIndex
    )

import Element
    exposing
        ( Attribute
        , htmlAttribute
        )
import Html.Attributes as HtmlAttr


id : String -> Attribute msg
id val =
    HtmlAttr.id val |> htmlAttribute


style : String -> String -> Attribute msg
style name val =
    HtmlAttr.style name val |> htmlAttribute


styles : List ( String, String ) -> List (Attribute msg)
styles attrs =
    attrs
        |> List.map
            (\( name, val ) ->
                style name val
            )


class : String -> Attribute msg
class name =
    HtmlAttr.class name |> htmlAttribute


draggable : String -> Attribute msg
draggable val =
    HtmlAttr.draggable val |> htmlAttribute



-- TODO 参考Element UI实现css动态嵌入机制


zIndex : Int -> Attribute msg
zIndex val =
    style "z-index" (String.fromInt val)


cursor : String -> Attribute msg
cursor val =
    style "cursor" val


noUserSelect : Attribute msg
noUserSelect =
    style "user-select" "none"


noPointerEvents : Attribute msg
noPointerEvents =
    style "pointer-events" "none"


allPointerEvents : Attribute msg
allPointerEvents =
    style "pointer-events" "all"
