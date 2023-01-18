module Style.Topic exposing
    ( contentInTopicBody
    , topic
    , topicBody
    , topicBodyDefaultPalette
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
        , rgba255
        , shrink
        , spacing
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Style.Html
import Theme.Color
import Theme.Color.Element


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
    , Style.Html.class "topic"
    , paddingEach { top = 0, left = 36, right = 0, bottom = 0 }
    ]


topicBody : List (Attribute msg)
topicBody =
    [ width fill
    , height fill
    , Style.Html.class "topic-body"
    , Border.roundEach
        { topLeft = 0
        , topRight = 0
        , bottomLeft = topicCornerRadius
        , bottomRight = topicCornerRadius
        }
    ]


topicBodyDefaultPalette : List (Attribute msg)
topicBodyDefaultPalette =
    -- Theme.Color.Element.defaultPalette Theme.Color.Blue600
    []


contentInTopicBody : List (Attribute msg)
contentInTopicBody =
    [ width fill
    , height
        (fill
            |> minimum (contentFontSizeInTopicBody * 2)
        )
    , Font.size contentFontSizeInTopicBody
    ]
