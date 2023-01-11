module View.Topic.ListView exposing (create)

import Element exposing (..)
import Model.ColorPalette
import Model.Root exposing (RootModel)
import Model.Topic
import Msg exposing (RootMsg)
import Style.Color
import Style.Topic
import Widget.Markdown


create : RootModel -> Element RootMsg
create model =
    topicList model.topics



-- ---------------------------------------------------------------


fromColorPalette :
    Maybe Model.ColorPalette.Palette
    -> List (Attribute msg)
    -> List (Attribute msg)
fromColorPalette palette defaultColor =
    case palette of
        Just p ->
            Style.Color.fromPalette p

        Nothing ->
            defaultColor


topicList : List Model.Topic.Topic -> Element RootMsg
topicList topics =
    column
        Style.Topic.topicList
        (topics
            |> List.map
                (\topic ->
                    column
                        Style.Topic.topic
                        [ row
                            (Style.Topic.topicBody
                                ++ fromColorPalette topic.colorPalette
                                    Style.Topic.topicBodyDefaultColor
                            )
                            [ el
                                [ width fill
                                , padding 8
                                ]
                                (el
                                    Style.Topic.contentInTopicBody
                                    (paragraph
                                        [ height shrink
                                        , centerY
                                        ]
                                        [ Widget.Markdown.render topic.content
                                        ]
                                    )
                                )
                            ]
                        ]
                )
        )
