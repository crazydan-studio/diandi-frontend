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


module Widget.Internal.Widget.TextEditor exposing
    ( Context
    , State
    , focuseOn
    , init
    , inputId
    , onKeyDown
    , updateByKeyboard
    )

import Browser.Dom as Dom
import Json.Decode as Decode exposing (Decoder)
import Keyboard.Event exposing (KeyboardEvent, decodeKeyboardEvent)
import Task
import Widget.Internal.Context as Internal


type alias State =
    { focused : Bool
    , cursor :
        {}
    , text : String
    }


type alias Context msg =
    Internal.Context State msg


init : State
init =
    { focused = False
    , cursor =
        {}
    , text = ""
    }


focuseOn : String -> (String -> msg) -> Maybe State -> Cmd msg
focuseOn id toMsg stateMaybe =
    stateMaybe
        |> Maybe.map
            (\state ->
                if state.focused then
                    let
                        target =
                            inputId id
                    in
                    Task.attempt
                        (\_ -> toMsg target)
                        (Dom.focus target)

                else
                    Cmd.none
            )
        |> Maybe.withDefault Cmd.none


inputId : String -> String
inputId id =
    id ++ "-input"


onKeyDown : (KeyboardEvent -> msg) -> Decoder msg
onKeyDown toMsg =
    Decode.map toMsg decodeKeyboardEvent


updateByKeyboard : KeyboardEvent -> State -> State
updateByKeyboard keyboard state =
    -- Debug.log ("Keyboard: " ++ Debug.toString keyboard.key)
    -- TODO 仅处理控制字符
    state
