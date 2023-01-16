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
    , link
    , primary
    , secondary
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
import Theme.Theme
import Widget.Helper exposing (css)
import Widget.Model
    exposing
        ( Msg(..)
        , WidgetUpdater
        , Widgets
        )
import Widget.Model.Button


type alias Config msg =
    { id : String
    , content : Element msg
    , onPress : Maybe msg
    , theme : Theme.Theme.Theme
    , attrs : List (Attribute msg)
    }


{-| 一级按钮
-}
primary : Widgets msg -> Config msg -> Element msg
primary =
    btnCreator Theme.Theme.primaryBtn


{-| 二级按钮
-}
secondary : Widgets msg -> Config msg -> Element msg
secondary =
    btnCreator Theme.Theme.secondaryBtn


{-| 链接按钮
-}
link : Element msg
link =
    Element.none



-- ---------------------------------------------------------------


btnCreator :
    (Theme.Theme.Theme -> List (Attribute msg))
    -> Widgets msg
    -> Config msg
    -> Element msg
btnCreator fromTheme widgets { id, content, onPress, theme, attrs } =
    Input.button
        ([ width
            (shrink
                |> minimum 64
            )
         , height (px 36)
         , paddingXY 16 0
         , css "button"
         , Font.size 14
         , Font.letterSpacing 1.25
         , Border.rounded 4
         , mouseOver []
         , focused []
         ]
            ++ fromTheme theme
            ++ attrs
        )
        { onPress =
            Just
                (widgets
                    |> onButtonMsg id
                        (\state ->
                            { state
                                | disabled = not state.disabled
                            }
                        )
                )
        , label = content
        }


onButtonMsg :
    String
    -> WidgetUpdater Widget.Model.Button.State
    -> Widgets msg
    -> msg
onButtonMsg id updateState =
    Widget.Model.onMsg
        (\() ->
            UpdateButtonState
                { id = id
                , init = \() -> Widget.Model.Button.init
                , update = updateState
                }
        )
