module Page.Card.ListView exposing (create)

import Element exposing (..)
import Model.Card
import Model.ColorPalette
import Model.Root exposing (RootModel)
import Msg exposing (RootMsg)
import Style.Card
import Style.Color


create : RootModel -> Element RootMsg
create model =
    cardList model.cards



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


cardList : List Model.Card.Card -> Element RootMsg
cardList cards =
    wrappedRow
        [ width (fill |> maximum ((Style.Card.cardWidth + Style.Card.cardSpacing) * 4))
        , spacing Style.Card.cardSpacing
        , padding Style.Card.cardPadding
        , centerX
        ]
        (cards
            |> List.indexedMap
                (\i card ->
                    column
                        (Style.Card.card
                            ++ [ width (px Style.Card.cardWidth)
                               ]
                        )
                        [ row
                            (Style.Card.cardBody
                                ++ fromColorPalette card.colorPalette
                                    Style.Card.cardBodyDefaultColor
                                ++ [ width fill
                                   ]
                            )
                            [ el
                                (Style.Card.contentInCardBody
                                    ++ []
                                )
                                (paragraph
                                    []
                                    [ el Style.Card.indexInCardBody
                                        (text (String.fromInt (i + 1)))
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
