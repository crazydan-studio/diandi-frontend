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
        , height
        , htmlStyleAttribute
        , minimum
        , mouseDown
        , mouseOver
        , padding
        , paddingXY
        , px
        , rgba255
        , shrink
        , width
        )
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Transition as Transition
import Widget.Internal.Widget.Button as Internal


type alias Config msg =
    { id : String
    , content : Element msg
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
                , paddingXY 16 10
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
    let
        shadow =
            -- box-shadow: rgba(0, 0, 0, 0.2) 0px 3px 1px -2px, rgba(0, 0, 0, 0.14) 0px 2px 2px 0px, rgba(0, 0, 0, 0.12) 0px 1px 5px 0px;
            Border.shadows
                [ { inset = False
                  , offset = ( 0, 3 )
                  , blur = 1
                  , size = -2
                  , color = rgba255 0 0 0 0.2
                  }
                , { inset = False
                  , offset = ( 0, 2 )
                  , blur = 2
                  , size = 0
                  , color = rgba255 0 0 0 0.14
                  }
                , { inset = False
                  , offset = ( 0, 1 )
                  , blur = 5
                  , size = 0
                  , color = rgba255 0 0 0 0.12
                  }
                ]

        hoverShadow =
            -- box-shadow: 0px 2px 4px -1px rgba(0, 0, 0, 0.2), 0px 4px 5px 0px rgba(0, 0, 0, 0.14), 0px 1px 10px 0px rgba(0, 0, 0, 0.12);
            Border.shadows
                [ { inset = False
                  , offset = ( 0, 2 )
                  , blur = 4
                  , size = -1
                  , color = rgba255 0 0 0 0.2
                  }
                , { inset = False
                  , offset = ( 0, 4 )
                  , blur = 5
                  , size = 0
                  , color = rgba255 0 0 0 0.14
                  }
                , { inset = False
                  , offset = ( 0, 1 )
                  , blur = 10
                  , size = 0
                  , color = rgba255 0 0 0 0.12
                  }
                ]

        activeShadow =
            -- box-shadow: 0px 5px 5px -3px rgba(0, 0, 0, 0.2), 0px 8px 10px 1px rgba(0, 0, 0, 0.14), 0px 3px 14px 2px rgba(0, 0, 0, 0.12);
            Border.shadows
                [ { inset = False
                  , offset = ( 0, 5 )
                  , blur = 5
                  , size = -3
                  , color = rgba255 0 0 0 0.2
                  }
                , { inset = False
                  , offset = ( 0, 8 )
                  , blur = 10
                  , size = 1
                  , color = rgba255 0 0 0 0.14
                  }
                , { inset = False
                  , offset = ( 0, 3 )
                  , blur = 14
                  , size = 2
                  , color = rgba255 0 0 0 0.12
                  }
                ]
    in
    Input.button
        -- https://aforemny.github.io/material-components-web-elm/#buttons
        ([ Font.size 14
         , Font.letterSpacing 1.25
         , Font.weight 500
         , Font.center
         , shadow
         , Transition.with
            [ Transition.property "box-shadow"
                [ Transition.duration 0.28
                , Transition.delay 0
                , Transition.cubic 0.4 0 0.2 1
                ]
            ]

         -- https://github.com/mdgriffith/elm-ui/blob/master/CSS-LOOKUP.md
         -- :hover
         , mouseOver [ hoverShadow ]

         -- :focus
         , focused [ hoverShadow ]

         -- :active
         , mouseDown [ activeShadow ]
         ]
            ++ attrs
        )
        { onPress = onPress
        , label = content
        }


{-| 链接按钮
-}
link : Element msg
link =
    Element.none
