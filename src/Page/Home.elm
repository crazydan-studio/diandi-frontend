module Page.Home exposing (create)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Model.Card
import Model.Root exposing (RootModel)
import Model.User
import Msg exposing (RootMsg)
import Style.Card
import Style.Home


create : RootModel -> Element RootMsg
create model =
    column
        [ width fill
        , height fill
        ]
        [ row
            (Style.Home.topBar
                ++ [ width fill
                   ]
            )
            [ image
                [ alignLeft
                , height (px 32)
                ]
                { src = "/logo.svg", description = "" }
            , el
                (Style.Home.userAvatar
                    ++ [ alignRight
                       ]
                )
                (text (userName model.me))
            ]
        , row
            [ width fill
            , height fill

            -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
            , clip
            ]
            [ el
                [ width fill
                , height fill
                , paddingXY 482 0
                , scrollbarY
                ]
                (cardList model.cards)
            ]
        , row
            (Style.Home.bottomBar
                ++ [ width fill
                   ]
            )
            []
        ]


userName : Model.User.User -> String
userName user =
    case user of
        Model.User.None ->
            "匿名"

        Model.User.User u ->
            u.name


fromCardColor : Model.Card.Color -> Color
fromCardColor color =
    rgb255 color.r color.g color.b


cardList : List Model.Card.Card -> Element RootMsg
cardList cards =
    wrappedRow
        [ width shrink
        , spacing 16
        , padding 16
        ]
        (List.indexedMap
            (\i card ->
                column
                    (Style.Card.card
                        ++ [ width (px 456)
                           ]
                    )
                    [ row
                        (Style.Card.cardBody
                            ++ [ width fill
                               , Background.color (fromCardColor card.bgColor)
                               ]
                        )
                        [ el
                            (Style.Card.contentInCardBody
                                ++ []
                            )
                            (paragraph
                                [ Font.color (fromCardColor card.fontColor)
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
                                (Style.Card.labelInCardFooter 5
                                    ++ []
                                )
                                (text "标签:")
                            , wrappedRow
                                [ width fill
                                , spacing 4
                                ]
                                (cardTagList card.tags)
                            ]
                        , row
                            [ width fill
                            ]
                            [ el
                                (Style.Card.labelInCardFooter 5
                                    ++ []
                                )
                                (text "创建时间:")
                            , el
                                [ width fill
                                ]
                                (text card.createdAt)
                            ]
                        ]
                    ]
            )
            cards
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
