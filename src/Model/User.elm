module Model.User exposing (User(..), UserInfo, userInfoDecoder)

import Json.Decode as Decode exposing (Decoder, nullable, string)
import Json.Decode.Pipeline exposing (required)


type User
    = None
    | User UserInfo


type alias UserInfo =
    { id : String
    , name : String
    , email : Maybe String
    }


userInfoDecoder : Decoder UserInfo
userInfoDecoder =
    Decode.succeed UserInfo
        |> required "id" string
        |> required "name" string
        |> required "email" (nullable string)
