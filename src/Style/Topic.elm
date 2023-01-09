module Style.Topic exposing
    ( topic
    , topicBody
    , topicBodyDefaultColor
    , topicHeader
    , topicList
    , topicPadding
    , topicSpacing
    , topicWidth
    , contentInTopicBody
    , indexInTopicBody
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


topicCornerRadius : Int
topicCornerRadius =
    2


topicWidth : Int
topicWidth =
    456 * 2


topicSpacing : Int
topicSpacing =
    8


topicPadding : Int
topicPadding =
    16


contentFontSizeInTopicBody : Int
contentFontSizeInTopicBody =
    Style.Basic.majorFontSize


fontSizeInTopicHeader : Int
fontSizeInTopicHeader =
    Style.Basic.juniorFontSize


topicList : List (Attribute msg)
topicList =
    [ width fill
    , height fill
    , spacing topicSpacing
    , paddingXY (topicPadding * 4) topicPadding
    , centerX
    ]


topic : List (Attribute msg)
topic =
    [ width fill
    , height shrink
    , Background.color (rgb255 255 255 255)
    , Border.rounded topicCornerRadius
    , Style.Html.class "topic"
    ]


topicBody : List (Attribute msg)
topicBody =
    [ width fill
    , Border.roundEach
        { topLeft = 0
        , topRight = 0
        , bottomLeft = topicCornerRadius
        , bottomRight = topicCornerRadius
        }
    ]


topicBodyDefaultColor : List (Attribute msg)
topicBodyDefaultColor =
    [ Background.color (rgb255 0 150 136)
    , Font.color (rgb255 255 255 255)
    ]


contentInTopicBody : List (Attribute msg)
contentInTopicBody =
    [ width fill
    , height
        (fill
            |> minimum (contentFontSizeInTopicBody * 2)
        )
    , Font.size contentFontSizeInTopicBody
    ]


indexInTopicBody : List (Attribute msg)
indexInTopicBody =
    [ paddingEach
        { left = 0
        , top = 0
        , right = 8
        , bottom = 0
        }
    , Font.size (Style.Basic.majorFontSize * 3)
    , Font.bold
    ]


topicHeader : List (Attribute msg)
topicHeader =
    [ width fill
    , height shrink
    , spacing 8
    , paddingXY 8 4
    , Font.size fontSizeInTopicHeader
    , Font.color (rgba255 0 0 0 0.2)
    , Background.color (rgb255 255 255 255)
    , Border.roundEach
        { topLeft = topicCornerRadius
        , topRight = topicCornerRadius
        , bottomLeft = 0
        , bottomRight = 0
        }
    , Style.Html.style "display" "none"
    ]
