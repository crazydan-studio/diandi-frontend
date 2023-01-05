module Page.Card.ListView exposing (create)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
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
    column
        Style.Card.cardList
        (cards
            |> List.map
                (\card ->
                    column
                        Style.Card.card
                        [ row
                            Style.Card.cardHeader
                            [ paragraph
                                [ width fill
                                ]
                                (cardTagList card.tags)
                            ]
                        , row
                            (Style.Card.cardBody
                                ++ fromColorPalette card.colorPalette
                                    Style.Card.cardBodyDefaultColor
                            )
                            [ el
                                [ width fill
                                , padding 8
                                ]
                                (el
                                    Style.Card.contentInCardBody
                                    (paragraph
                                        [ height shrink
                                        , centerY
                                        ]
                                        [ text card.content
                                        ]
                                    )
                                )
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
