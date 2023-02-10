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


module Widget.Widget.TextEditor exposing (editor)

import Element
    exposing
        ( Element
        , alignTop
        , cursor
        , el
        , fill
        , height
        , none
        , padding
        , px
        , rgb255
        , row
        , text
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick, onLoseFocus)
import Element.Input as Input
import Widget.Html exposing (class, onClickOutOfMe)
import Widget.Internal.Widget.TextEditor as Internal


type alias Config =
    { id : String
    }


type alias Context a msg =
    { a | textEditorContext : Internal.Context msg }


editor :
    Config
    -> Context a msg
    -> Element msg
editor config { textEditorContext } =
    createHelper textEditorContext config



-- -----------------------------------------------------------


createHelper : Internal.Context msg -> Config -> Element msg
createHelper ({ getState, onUpdate } as context) ({ id } as config) =
    let
        state =
            getState id
                |> Maybe.withDefault Internal.init
    in
    el
        [ width fill
        , height fill
        , padding 8
        , onClick
            (onUpdate id
                (\s ->
                    Just
                        { s | focused = True }
                )
            )
        , onClickOutOfMe
            (onUpdate id
                (\s ->
                    Just
                        { s | focused = False }
                )
            )
        ]
        (row
            [ width fill
            , height fill
            , cursor "text"
            ]
            [ text state.text
            , createCursor context config state
            ]
        )


createCursor :
    Internal.Context msg
    -> Config
    -> Internal.State
    -> Element msg
createCursor { onUpdate } { id } state =
    if state.focused then
        el
            [ -- TODO 光标高度设置为左侧元素的高度，
              -- 左侧无元素时，设置为右侧元素高度，否则，设置为行高
              height (px 20)
            , alignTop
            , class "blink-cursor"
            ]
            (Input.text
                [ Element.id (id ++ "-input")
                , width (px 2)
                , height fill
                , padding 0
                , Border.width 0
                , Background.color (rgb255 255 0 0)
                ]
                { onChange =
                    \t ->
                        onUpdate id
                            (\s ->
                                Just
                                    { s | text = t }
                            )
                , text = ""
                , placeholder = Nothing
                , label = Input.labelHidden ""
                , selection = Nothing
                }
            )

    else
        none
