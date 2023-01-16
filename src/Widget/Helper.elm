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

module Widget.Helper exposing
    ( css
    , style
    , styles
    )

import Element
    exposing
        ( Attribute
        , htmlAttribute
        )
import Html.Attributes as HtmlAttr


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


css : String -> Attribute msg
css name =
    HtmlAttr.class name |> htmlAttribute
