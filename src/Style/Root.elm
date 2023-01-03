module Style.Root exposing (rootLayout)

import Element exposing (Attribute)
import Element.Font as Font
import Style.Basic


rootLayout : List (Attribute msg)
rootLayout =
    [ Font.family
        [ Font.serif
        ]
    , Font.size Style.Basic.majorFontSize
    , Font.color Style.Basic.majorFontColor
    ]
