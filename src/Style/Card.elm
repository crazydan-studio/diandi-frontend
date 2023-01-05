module Style.Card exposing
    ( card
    , cardBody
    , cardBodyDefaultColor
    , cardHeader
    , cardList
    , cardPadding
    , cardSpacing
    , cardWidth
    , contentInCardBody
    , indexInCardBody
    )

import Element
    exposing
        ( Attribute
        , centerX
        , fill
        , height
        , minimum
        , padding
        , paddingEach
        , paddingXY
        , px
        , rgb255
        , rgba255
        , shrink
        , spacing
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Style.Basic
import Style.Html


cardCornerRadius : Int
cardCornerRadius =
    2


cardWidth : Int
cardWidth =
    456 * 2


cardSpacing : Int
cardSpacing =
    8


cardPadding : Int
cardPadding =
    16


contentFontSizeInCardBody : Int
contentFontSizeInCardBody =
    18


fontSizeInCardHeader : Int
fontSizeInCardHeader =
    Style.Basic.juniorFontSize


cardList : List (Attribute msg)
cardList =
    [ width (px cardWidth)
    , height fill
    , spacing cardSpacing
    , padding cardPadding
    , centerX
    ]


card : List (Attribute msg)
card =
    [ width fill
    , height shrink
    , Background.color (rgb255 255 255 255)
    , Border.rounded cardCornerRadius
    , Style.Html.class "card"
    ]


cardBody : List (Attribute msg)
cardBody =
    [ width fill
    , Border.roundEach
        { topLeft = 0
        , topRight = 0
        , bottomLeft = cardCornerRadius
        , bottomRight = cardCornerRadius
        }
    ]


cardBodyDefaultColor : List (Attribute msg)
cardBodyDefaultColor =
    [ Background.color (rgb255 0 150 136)
    , Font.color (rgb255 255 255 255)
    ]


contentInCardBody : List (Attribute msg)
contentInCardBody =
    [ width fill
    , height
        (fill
            |> minimum (contentFontSizeInCardBody * 2)
        )
    , Font.size contentFontSizeInCardBody
    ]


indexInCardBody : List (Attribute msg)
indexInCardBody =
    [ paddingEach
        { left = 0
        , top = 0
        , right = 8
        , bottom = 0
        }
    , Font.size (Style.Basic.majorFontSize * 3)
    , Font.bold
    ]


cardHeader : List (Attribute msg)
cardHeader =
    [ width fill
    , height shrink
    , paddingXY 8 4
    , Font.size fontSizeInCardHeader
    , Font.color (rgba255 0 0 0 0.2)
    , Background.color (rgb255 255 255 255)
    , Border.roundEach
        { topLeft = cardCornerRadius
        , topRight = cardCornerRadius
        , bottomLeft = 0
        , bottomRight = 0
        }
    ]
