module Page.Topic.ListView exposing (create)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Model.ColorPalette
import Model.Root exposing (RootModel)
import Model.Topic
import Msg exposing (RootMsg)
import Style.Topic
import Style.Color


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
                            Style.Topic.topicHeader
                            [ paragraph
                                [ width fill
                                ]
                                (topicTagList topic.tags)
                            , el
                                [ alignRight
                                ]
                                (text "设置")
                            ]
                        , row
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
                                        [ text topic.content
                                        ]
                                    )
                                )
                            ]
                        ]
                )
        )


topicTagList : List Model.Topic.Tag -> List (Element RootMsg)
topicTagList tags =
    tags
        |> List.foldl
            (\tag els ->
                els
                    ++ [ el
                            [ width (px 10)
                            , Font.center
                            ]
                            (text ">")
                       , el
                            []
                            (text tag)
                       ]
            )
            []
        |> List.tail
        |> Maybe.withDefault []
