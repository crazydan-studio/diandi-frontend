module Style.Topic exposing
    ( contentFontSizeInTopicBody
    , contentInTopicBody
    , topic
    , topicBody
    , topicCornerRadius
    , topicDefaultColor
    , topicList
    , topicPadding
    , topicSpacing
    , topicWidth
    )

import Element
    exposing
        ( Attribute
        , centerX
        , clip
        , fill
        , height
        , minimum
        , paddingEach
        , paddingXY
        , rgb255
        , rgba
        , rgba255
        , shrink
        , spacing
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Widget.Color exposing (Color)
import Widget.Html


topicCornerRadius : Int
topicCornerRadius =
    4


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
    14


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
    []


topicBody : List (Attribute msg)
topicBody =
    []


topicDefaultColor : Color
topicDefaultColor =
    Widget.Color.Blue600


contentInTopicBody : List (Attribute msg)
contentInTopicBody =
    [ width fill
    , height fill
    , Font.size contentFontSizeInTopicBody
    ]
