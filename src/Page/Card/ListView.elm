module Page.Card.ListView exposing (create)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Model.Card
import Model.Root exposing (RootModel)
import Msg exposing (RootMsg)
import Style.Card


create : RootModel -> Element RootMsg
create model =
    cardList model.cards



-- ---------------------------------------------------------------


fromCardColor : Maybe Model.Card.Color -> Color -> Color
fromCardColor colorMaybe colorDefault =
    case colorMaybe of
        Just color ->
            rgb255 color.r color.g color.b

        Nothing ->
            colorDefault


cardList : List Model.Card.Card -> Element RootMsg
cardList cards =
    wrappedRow
        [ width shrink
        , spacing 16
        , padding 16
        ]
        (cards
            |> List.indexedMap
                (\i card ->
                    column
                        (Style.Card.card
                            ++ [ width (px 456)
                               ]
                        )
                        [ row
                            (Style.Card.cardBody
                                ++ [ width fill
                                   , Background.color
                                        (fromCardColor card.bgColor
                                            Style.Card.cardBodyDefaultBgColor
                                        )
                                   ]
                            )
                            [ el
                                (Style.Card.contentInCardBody
                                    ++ []
                                )
                                (paragraph
                                    [ Font.color
                                        (fromCardColor card.fgColor
                                            Style.Card.cardBodyDefaultFgColor
                                        )
                                    ]
                                    [ el Style.Card.indexInCardBody
                                        (text (String.fromInt i))
                                    , text card.content
                                    ]
                                )
                            ]
                        , column
                            (Style.Card.cardFooter
                                ++ [ width fill
                                   ]
                            )
                            [ row
                                [ width fill
                                ]
                                [ el
                                    (Style.Card.labelInCardFooter 3
                                        ++ []
                                    )
                                    (text "标签:")
                                , wrappedRow
                                    [ width fill
                                    , spacing 4
                                    ]
                                    (cardTagList card.tags)
                                ]
                            ]
                        ]
                )
        )


cardTagList : List Model.Card.Tag -> List (Element RootMsg)
cardTagList tags =
    tags
        |> List.foldl
            (\tag els ->
                els
                    ++ [ el
                            (Style.Card.tagSeparatorInCardFooter
                                ++ []
                            )
                            (text "/")
                       , el
                            (Style.Card.tagInCardFooter tag
                                ++ []
                            )
                            (text tag)
                       ]
            )
            []
        |> List.tail
        |> Maybe.withDefault []
