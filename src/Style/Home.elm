module Style.Home exposing (topBar)

import Element
    exposing
        ( Attribute
        , fill
        , height
        , padding
        , paddingXY
        , px
        , rgb255
        , shrink
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Style.Default


topBar : List (Attribute msg)
topBar =
    Style.Default.boundaryBorderEach
        { top = 0
        , bottom = 1
        , left = 0
        , right = 0
        }
        ++ [ width fill
           , height (px 64)
           , Background.color (rgb255 255 255 255)
           , paddingXY 16 8
           ]
