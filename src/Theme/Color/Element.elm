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

module Theme.Color.Element exposing
    ( customPalette
    , defaultPalette
    , toRgbColor
    , toRgbaColor
    )

import Element
import Element.Background
import Element.Font
import Theme.Color exposing (Color(..), fgColorForBg, toRgb)


defaultPalette : Color -> List (Element.Attribute msg)
defaultPalette bg =
    customPalette bg (fgColorForBg bg)


customPalette : Color -> Color -> List (Element.Attribute msg)
customPalette bg fg =
    [ Element.Background.color (toRgbColor bg)
    , Element.Font.color (toRgbColor fg)
    ]


toRgbColor : Color -> Element.Color
toRgbColor c =
    toRgbaColor c 1


toRgbaColor : Color -> Float -> Element.Color
toRgbaColor c a =
    let
        { r, g, b } =
            toRgb c
    in
    Element.rgba255 r g b a
