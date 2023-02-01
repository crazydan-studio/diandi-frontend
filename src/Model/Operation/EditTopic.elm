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


module Model.Operation.EditTopic exposing
    ( EditTopic
    , Msg(..)
    , init
    , update
    )

import Element.Input exposing (Selection)
import Model.Topic exposing (Topic)


type alias EditTopic =
    { id : String
    , content : String
    , selection : Maybe Selection
    , focused : Bool
    , error : Maybe String
    }


type Msg
    = InputFocusIn
    | InputFocusOut
    | InputFocusBlur Selection
    | InputContentChanged String


init : Topic -> EditTopic
init topic =
    { id = topic.id
    , content = topic.content
    , selection = Nothing
    , focused = False
    , error = Nothing
    }


update : Msg -> EditTopic -> EditTopic
update msg editTopic =
    case msg of
        InputFocusIn ->
            { editTopic | focused = True }

        InputFocusOut ->
            { editTopic
                | -- id置空以确保重新编辑时，编辑内容与当前Topic内容一致
                  id = ""
                , focused = False
            }

        InputFocusBlur selection ->
            { editTopic | selection = Just selection }

        InputContentChanged content ->
            { editTopic
                | content = content
                , error = Nothing
            }
