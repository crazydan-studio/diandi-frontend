module Style.Home exposing
    ( bottomBar
    , logoInTopBar
    , topBar
    , userAvatarInTopBar
    )

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


logoInTopBar : List (Attribute msg)
logoInTopBar =
    [ width shrink
    , height (px 32)
    ]


userAvatarInTopBar : List (Attribute msg)
userAvatarInTopBar =
    Style.Default.boundaryBorderAll 1
        ++ [ width shrink
           , height fill
           , padding 8
           , Background.color (rgb255 255 255 255)
           , Border.rounded 16
           , Font.center
           ]


bottomBar : List (Attribute msg)
bottomBar =
    Style.Default.boundaryBorderEach
        { top = 1
        , bottom = 0
        , left = 0
        , right = 0
        }
        ++ [ width fill
           , height (px 32)
           , Background.color (rgb255 255 255 255)
           , paddingXY 16 4
           ]
