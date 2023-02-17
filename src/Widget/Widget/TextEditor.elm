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

import Element exposing (..)
import Element.Border as Border
import Element.Events exposing (onClick)
import Html
import Html.Attributes as HtmlAttr
import Html.Events as HtmlEvent
import Widget.Html exposing (class, onClickOutOfMe)
import Widget.Internal.Widget.TextEditor as Internal
    exposing
        ( inputId
        , onKeyDown
        )


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

        lineHeight =
            20

        textStyle =
            htmlStyleAttribute
                [ ( "line-height"
                  , String.fromInt lineHeight ++ "px"
                  )
                , ( "letter-spacing", "1px" )

                -- Note：确保文字与图片在同一行时，文字能够居中显示
                , ( "vertical-align", "top" )
                ]
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
            [ paragraph
                [ alignTop
                , textStyle
                ]
                [ el
                    [ height (px lineHeight)

                    -- 光标放在到文档元素的右侧，且光标与字符在相同容器内，
                    -- 故，光标高度与该元素等高。若光标前后无文档元素，则其高度为行高
                    , inFront (createCursor context config state)
                    ]
                    (if String.isEmpty state.text then
                        el [ width (px 2), height fill ] none

                     else
                        text state.text
                    )
                ]
            ]
        )


createCursor :
    Internal.Context msg
    -> Config
    -> Internal.State
    -> Element msg
createCursor { onUpdate } { id } state =
    if state.focused then
        let
            editorInputId =
                inputId id
        in
        el
            [ width (px 0)
            , height fill
            , clip
            , class "blink-cursor"
            , alignRight
            , Border.widthXY 1 0
            , Border.color (rgb255 255 0 0)
            , inFront
                (Html.textarea
                    [ HtmlAttr.id editorInputId
                    , HtmlAttr.style "width" "1px"
                    , HtmlAttr.style "height" "1px"
                    , HtmlAttr.style "border" "0px none"
                    , HtmlAttr.value state.text
                    , HtmlEvent.on "keydown"
                        (onKeyDown
                            (\event ->
                                onUpdate id
                                    (\s ->
                                        Just { s | keyboard = Just event }
                                    )
                            )
                        )
                    -- , HtmlEvent.onInput
                    --     (\text ->
                    --         onUpdate id
                    --             (\s ->
                    --                 Just { s | text = text }
                    --             )
                    --     )
                    ]
                    []
                    |> html
                )
            ]
            none

    else
        none
