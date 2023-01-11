module Theme.Theme exposing
    ( Theme
    , primaryBtn
    , primaryFontColor
    )

import Element
import Theme.Color
import Theme.Color.Element


type alias Theme =
    { primaryFontSize : Int
    , primaryFontColor : Theme.Color.Color
    , secondaryFontSize : Int
    , primaryBtnColor : Theme.Color.Color
    }


primaryFontColor : Theme -> Element.Color
primaryFontColor theme =
    Theme.Color.Element.toRgbColor
        theme.primaryFontColor


primaryBtn : Theme -> List (Element.Attribute msg)
primaryBtn theme =
    Theme.Color.Element.defaultPalette theme.primaryBtnColor
