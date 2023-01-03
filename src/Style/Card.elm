module Style.Card exposing
    ( card
    , cardBody
    , cardBodyDefaultBgColor
    , cardBodyDefaultFgColor
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
        , rgba255
        , scrollbarY
        , spacing
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Style.Basic


cardCornerRadius : Int
cardCornerRadius =
    8


card : List (Attribute msg)
card =
    [ Border.rounded cardCornerRadius
    , Border.shadow
        { offset = ( 0, 0 )
        , size = 2
        , blur = 10
        , color = rgba255 0 0 0 0.05
        }
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


cardBodyDefaultBgColor : Color
cardBodyDefaultBgColor =
    rgb255 0 150 136


cardBodyDefaultFgColor : Color
cardBodyDefaultFgColor =
    rgb255 255 255 255


contentInCardBody : List (Attribute msg)
contentInCardBody =
    [ width fill
    , height fill
    , scrollbarY
    , Font.size (Style.Basic.majorFontSize * 2)
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
    , Background.color (rgb255 255 255 255)
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
