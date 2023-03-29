{-
   点滴(DianDi) - 聚沙成塔，集腋成裘
   Copyright (C) 2022 by Crazydan Studio (https://studio.crazydan.org/)

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
-}


module Widget.Widget.Button exposing
    ( Config
    , button
    , circle
    , link
    )

import Element
    exposing
        ( Attribute
        , Element
        , focused
        , htmlStyleAttribute
        , minimum
        , mouseOver
        , padding
        , paddingXY
        , rgba255
        , shrink
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Widget.Animation.Transition as Transition
import Widget.Html exposing (class)
import Widget.Internal.Widget.Button as Internal
import Widget.Shadow as Shadow


type alias Config msg =
    { content : Element msg
    , onPress : Maybe msg
    , attrs : List (Attribute msg)
    }


type alias Context a msg =
    { a | buttonContext : Internal.Context msg }


{-| 普通按钮
-}
button :
    Config msg
    -> Context a msg
    -> Element msg
button ({ attrs } as config) { buttonContext } =
    createHelper buttonContext
        { config
            | attrs =
                [ width
                    (shrink
                        |> minimum 64
                    )
                , paddingXY 16 6
                , Border.rounded 4
                ]
                    ++ attrs
        }


{-| 圆形按钮
-}
circle :
    Config msg
    -> Context a msg
    -> Element msg
circle ({ attrs } as config) { buttonContext } =
    createHelper buttonContext
        { config
            | attrs =
                [ padding 16
                , htmlStyleAttribute
                    [ ( "border-radius", "50%" )
                    ]
                ]
                    ++ attrs
        }


createHelper : Internal.Context msg -> Config msg -> Element msg
createHelper _ { content, onPress, attrs } =
    -- https://v4.mui.com/components/buttons/
    Input.button
        ([ Shadow.normal

         -- https://github.com/mdgriffith/elm-ui/blob/master/CSS-LOOKUP.md
         -- :hover
         , mouseOver [ Shadow.hover ]

         -- :focus
         , focused [ Shadow.hover ]
         ]
            ++ commonStyles
            ++ attrs
        )
        { onPress = onPress
        , label = content
        }


{-| 链接按钮
-}
link :
    Config msg
    -> Context a msg
    -> Element msg
link { content, onPress, attrs } _ =
    Input.button
        -- https://v4.mui.com/components/buttons/#text-buttons
        ([ width
            (shrink
                |> minimum 64
            )
         , paddingXY 8 6
         , Border.rounded 4
         , mouseOver
            [ Background.color (rgba255 25 118 210 0.04)
            ]
         ]
            ++ commonStyles
            ++ attrs
        )
        { onPress = onPress
        , label = content
        }


commonStyles : List (Attribute msg)
commonStyles =
    [ Font.size 14
    , Font.letterSpacing 0.39998
    , Font.weight 500
    , Font.center
    , class "wgt-button"
    , Transition.defaultWith
        [ "background-color"
        , "box-shadow"
        , "border"
        ]
    ]
