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


module App.Store.Msg exposing (Msg(..), opResultDecoder)

import App.Topic exposing (Topic)
import Http
import Json.Decode as Decode
    exposing
        ( Decoder
        , bool
        , nullable
        , string
        )
import Json.Decode.Pipeline exposing (optional, required)


type Msg
    = NoOp
    | QueryMyTopics (Result Http.Error (List Topic))
    | DeleteMyTopics Int (Result Http.Error OpResult)
    | SaveMyNewTopic Int (Result Http.Error Topic)
    | SaveMyEditTopic Int (Result Http.Error Topic)
    | TrashMyTopic String (Result Http.Error String)
    | DeleteMyTopic String (Result Http.Error String)
    | RestoreMyTrashedTopic String (Result Http.Error String)


type alias OpResult =
    { success : Bool, msg : Maybe String }


opResultDecoder : Decoder OpResult
opResultDecoder =
    Decode.succeed OpResult
        |> required "success" bool
        |> optional "msg" (nullable string) Nothing
