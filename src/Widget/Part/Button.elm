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


module Widget.Part.Button exposing
    ( Config
    , button
    , link
    )

import Element
    exposing
        ( Attribute
        , Element
        , focused
        , height
        , minimum
        , mouseDown
        , mouseOver
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
import Widget.Html exposing (class)
import Widget.Model exposing (State)
import Widget.Model.Button as Button
import Widget.Msg as Msg


type alias Config msg =
    { id : String
    , content : Element msg
    , onPress : Maybe msg
    , attrs : List (Attribute msg)
    }


{-| 普通按钮
-}
button : State msg -> Config msg -> Element msg
button widgets { id, content, onPress, attrs } =
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
        ([ width
            (shrink
                |> minimum 64
            )
         , height (px 36)
         , paddingXY 16 0
         , class "wp-btn"
         , Font.size 14
         , Font.letterSpacing 1.25
         , Font.weight 500
         , Border.rounded 4
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
        { onPress =
            Just
                (widgets
                    |> onMsg id
                        (\s ->
                            Just
                                { s
                                    | disabled = not s.disabled
                                }
                        )
                )
        , label = content
        }


{-| 链接按钮
-}
link : Element msg
link =
    Element.none



-- ---------------------------------------------------------------


onMsg :
    String
    -> (Button.State -> Maybe Button.State)
    -> State msg
    -> msg
onMsg id updateState =
    Widget.Model.onMsg
        (\() ->
            Msg.UpdateButtonState
                { id = id
                , init = \() -> Button.init
                , update = updateState
                }
        )
