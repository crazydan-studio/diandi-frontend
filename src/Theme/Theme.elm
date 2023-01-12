module Theme.Theme exposing
    ( Theme
    , primaryBtn
    , primaryFontColor
    , secondaryBtn
    )

import Element
import Theme.Color
import Theme.Color.Element


type alias Theme =
    { primaryFontSize : Int
    , primaryFontColor : Theme.Color.Color
    , secondaryFontSize : Int
    , primaryBtnColor : Theme.Color.Color
    , secondaryBtnColor : Theme.Color.Color
    }


primaryFontColor : Theme -> Element.Color
primaryFontColor theme =
    Theme.Color.Element.toRgbColor
        theme.primaryFontColor


primaryBtn : Theme -> List (Element.Attribute msg)
primaryBtn theme =
    Theme.Color.Element.defaultPalette theme.primaryBtnColor

secondaryBtn : Theme -> List (Element.Attribute msg)
secondaryBtn theme =
    Theme.Color.Element.defaultPalette theme.secondaryBtnColor
