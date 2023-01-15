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
import Theme.Color
import Theme.Color.Element


type alias Theme =
    { primaryFontSize : Int
    , primaryFontColor : Theme.Color.Color
    , secondaryFontSize : Int
    , primaryBtnColor : Theme.Color.Color
    , secondaryBtnColor : Theme.Color.Color
    , placeholderFontColor : Theme.Color.Color
    }


primaryFontColor : Theme -> Element.Color
primaryFontColor theme =
    Theme.Color.Element.toRgbColor
        theme.primaryFontColor


placeholderFontColor : Theme -> Element.Color
placeholderFontColor theme =
    Theme.Color.Element.toRgbColor
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
    Theme.Color.Element.defaultPalette theme.primaryBtnColor


secondaryBtn : Theme -> List (Element.Attribute msg)
secondaryBtn theme =
    Theme.Color.Element.defaultPalette theme.secondaryBtnColor
