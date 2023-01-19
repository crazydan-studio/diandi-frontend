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
    , toRgba
    , zIndex
    )

import Element
    exposing
        ( Attribute
        , Color
        , htmlAttribute
        , htmlStyleAttribute
        , toRgb
        )
import Html.Attributes as HtmlAttr


toRgba : Color -> String
toRgba color =
    let
        { red, green, blue, alpha } =
            toRgb color
    in
    "rgba("
        ++ ([ red * 255
            , green * 255
            , blue * 255
            , alpha
            ]
                |> List.map
                    (\n ->
                        String.fromFloat n
                    )
                |> String.join ","
           )
        ++ ")"


id : String -> Attribute msg
id val =
    HtmlAttr.id val |> htmlAttribute


style : String -> String -> Attribute msg
style name val =
    [ ( name, val ) ] |> htmlStyleAttribute


styles : List ( String, String ) -> Attribute msg
styles attrs =
    attrs |> htmlStyleAttribute


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
