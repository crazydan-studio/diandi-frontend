module Style.Home exposing (bottomBar, topBar, userAvatar)

import Element exposing (Attribute, height, padding, px, rgb255)
import Element.Background as Background
import Element.Border as Border
import Element exposing (paddingXY)


topBar : List (Attribute msg)
topBar =
    [ height (px 48)
    , Border.solid
    , Border.color (rgb255 223 225 230)
    , Border.widthEach { top = 0, bottom = 1, left = 0, right = 0 }
    , Background.color (rgb255 255 255 255)
    , paddingXY 16 8
    ]


bottomBar : List (Attribute msg)
bottomBar =
    [ height (px 32)
    , Border.solid
    , Border.color (rgb255 223 225 230)
    , Border.widthEach { top = 1, bottom = 0, left = 0, right = 0 }
    , Background.color (rgb255 255 255 255)
    , paddingXY 16 4
    ]


userAvatar : List (Attribute msg)
userAvatar =
    [ padding 8
    , Background.color (rgb255 255 255 255)
    , Border.solid
    , Border.color (rgb255 223 225 230)
    , Border.width 1
    , Border.rounded 16
    ]
