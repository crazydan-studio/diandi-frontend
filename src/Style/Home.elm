module Style.Home exposing
    ( bottomBar
    , logoInTopBar
    , topBar
    , userAvatarInTopBar
    )

import Element
    exposing
        ( Attribute
        , alignLeft
        , alignRight
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


topBar : List (Attribute msg)
topBar =
    [ width fill
    , height (px 48)
    , Border.solid
    , Border.color (rgb255 223 225 230)
    , Border.widthEach { top = 0, bottom = 1, left = 0, right = 0 }
    , Background.color (rgb255 255 255 255)
    , paddingXY 16 8
    ]


logoInTopBar : List (Attribute msg)
logoInTopBar =
    [ width shrink
    , height (px 32)
    , alignLeft
    ]


userAvatarInTopBar : List (Attribute msg)
userAvatarInTopBar =
    [ width shrink
    , height fill
    , alignRight
    , padding 8
    , Background.color (rgb255 255 255 255)
    , Border.solid
    , Border.color (rgb255 223 225 230)
    , Border.width 1
    , Border.rounded 16
    ]


bottomBar : List (Attribute msg)
bottomBar =
    [ width fill
    , height (px 32)
    , Border.solid
    , Border.color (rgb255 223 225 230)
    , Border.widthEach { top = 1, bottom = 0, left = 0, right = 0 }
    , Background.color (rgb255 255 255 255)
    , paddingXY 16 4
    ]
