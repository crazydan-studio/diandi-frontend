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
    , primaryBorderColor
    , primaryBtn
    , primaryBtnIcon
    , primaryBtnIconSize
    , primaryFont
    , primaryFontColor
    , primaryGreyBackground
    , primaryGreyBackgroundColor
    , primaryIcon
    , primaryLinkBtnIcon
    , secondaryBtn
    )

import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Widget.Color exposing (Color, defaultPalette, fgColorForBg, toRgbColor)
import Widget.Icon as Icon exposing (Icon)


type alias Theme =
    { primaryFontSize : Int
    , primaryFontColor : Color
    , secondaryFontSize : Int
    , primaryBtnColor : Color
    , secondaryBtnColor : Color
    , primaryBtnIconSize : Int
    , placeholderFontColor : Color
    , primaryBorderColor : Element.Color
    , primaryGreyBackgroundColor : Element.Color
    }


primaryFontColor : Theme -> Element.Color
primaryFontColor theme =
    toRgbColor
        theme.primaryFontColor


placeholderFontColor : Theme -> Element.Color
placeholderFontColor theme =
    toRgbColor
        theme.placeholderFontColor


primaryBorderColor : Theme -> Element.Color
primaryBorderColor theme =
    theme.primaryBorderColor


primaryGreyBackgroundColor : Theme -> Element.Color
primaryGreyBackgroundColor theme =
    theme.primaryGreyBackgroundColor


primaryBtnIconSize : Theme -> Int
primaryBtnIconSize theme =
    theme.primaryBtnIconSize


primaryFont : Theme -> List (Element.Attribute msg)
primaryFont theme =
    [ Font.color (primaryFontColor theme)
    ]


placeholderFont : Theme -> List (Element.Attribute msg)
placeholderFont theme =
    [ Font.color (placeholderFontColor theme)
    ]


primaryIcon :
    Int
    -> Icon
    -> Theme
    -> Element msg
primaryIcon size icon theme =
    Icon.icon
        { size = size
        , color = primaryFontColor theme
        }
        icon


primaryBtn : Theme -> List (Element.Attribute msg)
primaryBtn theme =
    defaultPalette theme.primaryBtnColor


secondaryBtn : Theme -> List (Element.Attribute msg)
secondaryBtn theme =
    defaultPalette theme.secondaryBtnColor


primaryBtnIcon :
    Icon
    -> Theme
    -> Element msg
primaryBtnIcon icon theme =
    Icon.icon
        { size = primaryBtnIconSize theme
        , color =
            toRgbColor
                (fgColorForBg theme.primaryBtnColor)
        }
        icon


primaryLinkBtnIcon :
    Icon
    -> Theme
    -> Element msg
primaryLinkBtnIcon icon theme =
    primaryIcon
        (primaryBtnIconSize theme)
        icon
        theme


primaryGreyBackground : Theme -> List (Element.Attribute msg)
primaryGreyBackground theme =
    [ Background.color (primaryGreyBackgroundColor theme)
    ]
