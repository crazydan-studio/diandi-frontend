module View.Topic.ListView exposing (create)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Model.Topic
import Msg exposing (RootMsg)
import Style.Topic
import Theme.Color
import Theme.Color.Element
import Widget.Markdown


create : RootModel -> Element RootMsg
create model =
    topicList model.topics



-- ---------------------------------------------------------------


getPaletteWithDefault :
    Maybe Theme.Color.Color
    -> List (Attribute msg)
    -> List (Attribute msg)
getPaletteWithDefault bgColor defaultPalette =
    case bgColor of
        Just color ->
            Theme.Color.Element.defaultPalette color

        Nothing ->
            defaultPalette


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
                                ++ getPaletteWithDefault topic.color
                                    Style.Topic.topicBodyDefaultPalette
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
