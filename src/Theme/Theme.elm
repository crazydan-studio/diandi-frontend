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


module Theme.Theme exposing
    ( Theme
    , placeholderFont
    , placeholderFontColor
    , primaryBtn
    , primaryFontColor
    , primaryFontFont
    , secondaryBtn
    )

import Element
import Element.Font as Font
import Widget.Color


type alias Theme =
    { primaryFontSize : Int
    , primaryFontColor : Widget.Color.Color
    , secondaryFontSize : Int
    , primaryBtnColor : Widget.Color.Color
    , secondaryBtnColor : Widget.Color.Color
    , placeholderFontColor : Widget.Color.Color
    }


primaryFontColor : Theme -> Element.Color
primaryFontColor theme =
    Widget.Color.toRgbColor
        theme.primaryFontColor


placeholderFontColor : Theme -> Element.Color
placeholderFontColor theme =
    Widget.Color.toRgbColor
        theme.placeholderFontColor


primaryFontFont : Theme -> List (Element.Attribute msg)
primaryFontFont theme =
    [ Font.color (primaryFontColor theme)
    ]


placeholderFont : Theme -> List (Element.Attribute msg)
placeholderFont theme =
    [ Font.color (placeholderFontColor theme)
    ]


primaryBtn : Theme -> List (Element.Attribute msg)
primaryBtn theme =
    Widget.Color.defaultPalette theme.primaryBtnColor


secondaryBtn : Theme -> List (Element.Attribute msg)
secondaryBtn theme =
    Widget.Color.defaultPalette theme.secondaryBtnColor
