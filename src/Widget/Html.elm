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


module Widget.Html exposing
    ( onClickOutOfMe
    , onEnter
    )

import Html exposing (Attribute)
import Html.Events exposing (on)
import Json.Decode as Decode


onClickOutOfMe : msg -> Attribute msg
onClickOutOfMe msg =
    on "clickOutOfMe"
        (Decode.succeed msg)


onEnter : msg -> Html.Attribute msg
onEnter msg =
    -- Note: 只有监听 keydown 事件才能判断当前是否在输入法输入过程中
    -- https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboardevent.iscomposing
    on "keydown"
        (Decode.map2 KeyEvent
            (Decode.field "key" Decode.string)
            (Decode.field "isComposing" Decode.bool)
            |> Decode.andThen
                (\{ key, composing } ->
                    if key == "Enter" && not composing then
                        Decode.succeed msg

                    else
                        Decode.fail "Not the enter key"
                )
        )


type alias KeyEvent =
    { key : String
    , composing : Bool
    }
