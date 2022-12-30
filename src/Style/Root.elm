module Style.Root exposing (rootLayout)

import Element exposing (Attribute, rgb255)
import Element.Font as Font


rootLayout : List (Attribute msg)
rootLayout =
    [ Font.family
        [ Font.serif
        ]
    , Font.size 14
    , Font.color (rgb255 6 126 213)
    ]
