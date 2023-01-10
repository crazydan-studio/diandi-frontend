module Style.Root exposing (rootLayout)

import Element exposing (Attribute)
import Element.Font as Font
import Style.Default


rootLayout : List (Attribute msg)
rootLayout =
    [ Font.family
        [ Font.serif
        ]
    , Font.size Style.Default.majorFontSize
    , Font.color Style.Default.majorFontColor
    ]
