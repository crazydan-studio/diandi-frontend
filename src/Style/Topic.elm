module Style.Topic exposing
    ( contentInTopicBody
    , topic
    , topicBody
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
import Theme.Color
import Theme.Color.Element
import Widget.Html


topicCornerRadius : Int
topicCornerRadius =
    4


topicWidth : Int
topicWidth =
    456 * 2


topicSpacing : Int
topicSpacing =
    16


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
    , Background.color (rgba255 0 0 0 0.1)
    ]


topic : List (Attribute msg)
topic =
    [ width fill
    , clip
    , Background.color (rgb255 255 255 255)
    , Border.rounded topicCornerRadius
    , Widget.Html.class "topic"
    ]


topicBody : List (Attribute msg)
topicBody =
    [ width fill
    , height fill
    , Border.roundEach
        { topLeft = 0
        , topRight = 0
        , bottomLeft = topicCornerRadius
        , bottomRight = topicCornerRadius
        }
    , Background.color (rgba255 0 0 0 0)
    , Widget.Html.styles
        [ ( "background-image", "linear-gradient(#91d1d3 1px, transparent 0)" )
        , ( "background-size"
          , "100% "
                ++ String.fromInt ((contentFontSizeInTopicBody + 2) * 2)
                ++ "px"
          )
        , ( "background-position", "0 " ++ String.fromInt (contentFontSizeInTopicBody + 2) ++ "px" )
        ]
    ]


topicDefaultColor : Theme.Color.Color
topicDefaultColor =
    Theme.Color.Blue600


contentInTopicBody : List (Attribute msg)
contentInTopicBody =
    [ width fill
    , height fill
    , Font.size contentFontSizeInTopicBody
    ]
