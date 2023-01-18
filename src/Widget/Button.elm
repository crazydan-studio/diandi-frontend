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


module Widget.Button exposing
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
        , mouseOver
        , paddingXY
        , px
        , shrink
        , width
        )
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Widget.Html exposing (class)
import Widget.Model exposing (State)
import Widget.Model.Button as Button
import Widget.Msg exposing (Msg(..))


type alias Config msg =
    { id : String
    , content : Element msg
    , onPress : Maybe msg
    , attrs : List (Attribute msg)
    }


{-| 普通按钮
-}
button : State msg -> Config msg -> Element msg
button state { id, content, onPress, attrs } =
    Input.button
        ([ width
            (shrink
                |> minimum 64
            )
         , height (px 36)
         , paddingXY 16 0
         , class "button"
         , Font.size 14
         , Font.letterSpacing 1.25
         , Border.rounded 4
         , mouseOver []
         , focused []
         ]
            ++ attrs
        )
        { onPress =
            Just
                (state
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
            UpdateButtonState
                { id = id
                , init = \() -> Button.init
                , update = updateState
                }
        )
