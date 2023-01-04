module Style.Card exposing
    ( card
    , cardBody
    , cardBodyDefaultColor
    , cardFooter
    , contentInCardBody
    , indexInCardBody
    , labelInCardFooter
    , tagInCardFooter
    , tagSeparatorInCardFooter
    )

import Element
    exposing
        ( Attribute
        , Color
        , clip
        , fill
        , height
        , padding
        , paddingEach
        , px
        , rgb255
        , scrollbarY
        , spacing
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Style.Basic
import Style.Html


cardCornerRadius : Int
cardCornerRadius =
    4


card : List (Attribute msg)
card =
    [ Border.rounded cardCornerRadius
    , Background.color (rgb255 255 255 255)
    , Style.Html.style
        "box-shadow"
        ("0 1.35pt 2.25pt rgba(0, 0, 0, 0.14)"
            ++ ", 0 0.3pt 2.7pt 0.3pt rgba(0, 0, 0, 0.12)"
            ++ ", 0 0.75pt 1.2pt -0.45pt rgba(0, 0, 0, 0.4)"
        )
    ]


cardBody : List (Attribute msg)
cardBody =
    [ height (px 128)
    , clip
    , padding 8
    , Border.roundEach
        { topLeft = cardCornerRadius
        , topRight = cardCornerRadius
        , bottomLeft = 0
        , bottomRight = 0
        }
    ]


cardBodyDefaultColor : List (Attribute msg)
cardBodyDefaultColor =
    [ Background.color (rgb255 0 150 136)
    , Font.color (rgb255 255 255 255)
    ]


contentInCardBody : List (Attribute msg)
contentInCardBody =
    [ width fill
    , height fill
    , scrollbarY
    , Font.size (toFloat Style.Basic.majorFontSize * 1.5 |> round)
    ]


indexInCardBody : List (Attribute msg)
indexInCardBody =
    [ paddingEach { left = 0, top = 0, right = 8, bottom = 0 }
    , Font.size (Style.Basic.majorFontSize * 3)
    , Font.bold
    ]


fontSizeInCardFooter : Int
fontSizeInCardFooter =
    Style.Basic.minorFontSize


cardFooter : List (Attribute msg)
cardFooter =
    [ padding 8
    , spacing 8
    , Font.size fontSizeInCardFooter
    , Border.roundEach
        { topLeft = 0
        , topRight = 0
        , bottomLeft = cardCornerRadius
        , bottomRight = cardCornerRadius
        }
    ]


labelInCardFooter : Int -> List (Attribute msg)
labelInCardFooter textMaxLength =
    [ width (px (fontSizeInCardFooter * textMaxLength))
    ]


tagInCardFooter : String -> List (Attribute msg)
tagInCardFooter tag =
    -- 文本内容宽度不能自动确定，暂时只能根据文本长度确定元素宽度
    [ width
        (px
            (fontSizeInCardFooter
                * ((List.map
                        (\char ->
                            let
                                len =
                                    Char.toCode char
                            in
                            -- ascii码占1/2个字体宽度
                            if len > 0 && len <= 255 then
                                0.5

                            else
                                1.0
                        )
                        (String.toList tag)
                        |> List.foldl (+) 0
                        |> round
                   )
                    + 1
                  )
            )
        )
    , padding 4
    , Font.center
    , Border.rounded fontSizeInCardFooter
    , Background.color (rgb255 223 225 230)
    ]


tagSeparatorInCardFooter : List (Attribute msg)
tagSeparatorInCardFooter =
    [ width (px (fontSizeInCardFooter // 2))
    , Font.center
    ]
