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


module Model.Topic exposing
    ( Topic
    , init
    , topicDecoder
    , topicListDecoder
    )

{-| -}

import Json.Decode as Decode
    exposing
        ( Decoder
        , int
        , list
        , nullable
        , string
        )
import Json.Decode.Pipeline exposing (optional, required)
import Time exposing (Posix)


{-| 点滴卡

任务、知识等内容的载体

-}
type alias Topic =
    { id : String

    --
    , title : Maybe String
    , content : String
    , tags : List String
    , updatedAt : Maybe Posix
    }


init : Topic
init =
    { id = ""
    , title = Nothing
    , content = ""
    , tags = []
    , updatedAt = Nothing
    }


topicListDecoder : Decoder (List Topic)
topicListDecoder =
    list topicDecoder


topicDecoder : Decoder Topic
topicDecoder =
    Decode.succeed Topic
        |> required "id" string
        |> optional "title" (nullable string) Nothing
        |> required "content" string
        |> optional "tags" (list string) []
        |> optional "updated_at"
            (nullable
                (Decode.map Time.millisToPosix int)
            )
            Nothing
