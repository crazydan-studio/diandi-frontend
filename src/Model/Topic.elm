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
        , list
        , nullable
        , string
        )
import Json.Decode.Pipeline exposing (optional, required)


{-| 点滴卡

任务、知识等内容的载体

-}
type alias Topic =
    { id : String

    --
    , content : String
    , category : Maybe String
    , tags : List String

    -- 创建信息
    , createdAt : String
    }


init : Topic
init =
    { id = ""
    , content = ""
    , category = Nothing
    , tags = []
    , createdAt = ""
    }


topicListDecoder : Decoder (List Topic)
topicListDecoder =
    list topicDecoder


topicDecoder : Decoder Topic
topicDecoder =
    Decode.succeed Topic
        |> required "id" string
        |> required "content" string
        |> optional "category" (nullable string) Nothing
        |> optional "tags" (list string) []
        |> required "created_at" string
