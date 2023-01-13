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
