module Model.Tag exposing (..)

import Model.Icon exposing (Icon)


type alias Tag =
    { id : String
    , name : String
    , icon : Maybe Icon
    , description : Maybe String
    }
