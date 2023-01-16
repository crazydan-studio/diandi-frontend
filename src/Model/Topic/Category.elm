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

module Model.Topic.Category exposing
    ( Category
    , categoryDecoder
    , categoryListDecoder
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


type alias Category =
    { id : String
    , name : String
    , parent : Maybe String
    , icon : Maybe String
    , description : Maybe String
    }


categoryListDecoder : Decoder (List Category)
categoryListDecoder =
    list categoryDecoder


categoryDecoder : Decoder Category
categoryDecoder =
    Decode.succeed Category
        |> required "id" string
        |> required "name" string
        |> optional "parent" (nullable string) Nothing
        |> optional "icon" (nullable string) Nothing
        |> optional "description" (nullable string) Nothing
