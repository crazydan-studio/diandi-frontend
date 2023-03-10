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


module Theme.Theme exposing (Theme, create)

import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Theme.Internal.Theme as Internal
import Widget.Color exposing (defaultPalette, fgColorForBg, toRgbColor)
import Widget.Icon as Icon exposing (Icon)


type alias Theme msg =
    { --
      primaryFontSize : Int
    , primaryFontColor : Element.Color
    , primaryFont : List (Element.Attribute msg)

    --
    , primaryBtnColor : Element.Color
    , primaryBtnIconSize : Int
    , primaryBtn : List (Element.Attribute msg)

    --
    , primaryIcon : Int -> Icon -> Element msg
    , primaryBtnIcon : Icon -> Element msg
    , primaryLinkBtnIcon : Icon -> Element msg

    --
    , primaryBorderColor : Element.Color
    , primaryGreyBackgroundColor : Element.Color
    , primaryGreyBackground : List (Element.Attribute msg)

    --
    , secondaryFontSize : Int
    , secondaryBtnColor : Element.Color
    , secondaryBtn : List (Element.Attribute msg)

    --
    , placeholderFontColor : Element.Color
    , placeholderFont : List (Element.Attribute msg)
    }


create : Internal.Theme -> Theme msg
create theme =
    { primaryFontSize = theme.primaryFontSize
    , primaryFontColor = primaryFontColor theme
    , primaryFont = primaryFont theme
    , primaryBtnColor = toRgbColor theme.primaryBtnColor
    , primaryBtnIconSize = theme.primaryBtnIconSize
    , primaryBtn = primaryBtn theme
    , primaryIcon = primaryIcon theme
    , primaryBtnIcon = primaryBtnIcon theme
    , primaryLinkBtnIcon = primaryLinkBtnIcon theme
    , primaryBorderColor = theme.primaryBorderColor
    , primaryGreyBackgroundColor = theme.primaryGreyBackgroundColor
    , primaryGreyBackground = primaryGreyBackground theme
    , secondaryFontSize = theme.secondaryFontSize
    , secondaryBtnColor = toRgbColor theme.secondaryBtnColor
    , secondaryBtn = secondaryBtn theme
    , placeholderFontColor = placeholderFontColor theme
    , placeholderFont = placeholderFont theme
    }


primaryFontColor : Internal.Theme -> Element.Color
primaryFontColor theme =
    toRgbColor
        theme.primaryFontColor


placeholderFontColor : Internal.Theme -> Element.Color
placeholderFontColor theme =
    toRgbColor
        theme.placeholderFontColor


primaryFont : Internal.Theme -> List (Element.Attribute msg)
primaryFont theme =
    [ Font.color (primaryFontColor theme)
    , Font.size theme.primaryFontSize
    ]


placeholderFont : Internal.Theme -> List (Element.Attribute msg)
placeholderFont theme =
    [ Font.color (placeholderFontColor theme)
    ]


primaryIcon :
    Internal.Theme
    -> Int
    -> Icon
    -> Element msg
primaryIcon theme size icon =
    Icon.icon
        { size = size
        , color = primaryFontColor theme
        }
        icon


primaryBtn : Internal.Theme -> List (Element.Attribute msg)
primaryBtn theme =
    defaultPalette theme.primaryBtnColor


secondaryBtn : Internal.Theme -> List (Element.Attribute msg)
secondaryBtn theme =
    defaultPalette theme.secondaryBtnColor


primaryBtnIcon :
    Internal.Theme
    -> Icon
    -> Element msg
primaryBtnIcon theme icon =
    Icon.icon
        { size = theme.primaryBtnIconSize
        , color =
            toRgbColor
                (fgColorForBg theme.primaryBtnColor)
        }
        icon


primaryLinkBtnIcon :
    Internal.Theme
    -> Icon
    -> Element msg
primaryLinkBtnIcon theme icon =
    primaryIcon theme
        theme.primaryBtnIconSize
        icon


primaryGreyBackground : Internal.Theme -> List (Element.Attribute msg)
primaryGreyBackground theme =
    [ Background.color theme.primaryGreyBackgroundColor
    ]
