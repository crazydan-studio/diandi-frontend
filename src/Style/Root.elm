module Style.Root exposing (rootLayout)

import Element exposing (Attribute)
import Element.Font as Font
import Style.Default


rootLayout : List (Attribute msg)
rootLayout =
    [ Font.family
        [ Font.typeface "Roboto"
        , Font.sansSerif
        ]
    , Font.size Style.Default.primaryFontSize
    , Font.color Style.Default.primaryFontColor
    ]
