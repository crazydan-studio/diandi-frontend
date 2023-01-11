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
import Style.Default
import Style.Html
import Theme.Color
import Theme.Color.Element


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


topicBodyDefaultPalette : List (Attribute msg)
topicBodyDefaultPalette =
    Theme.Color.Element.defaultPalette Theme.Color.Blue600


contentInTopicBody : List (Attribute msg)
contentInTopicBody =
    [ width fill
    , height
        (fill
            |> minimum (contentFontSizeInTopicBody * 2)
        )
    , Font.size contentFontSizeInTopicBody
    ]
