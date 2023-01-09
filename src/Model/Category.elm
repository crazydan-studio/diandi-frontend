module Model.Category exposing (..)


type alias Category =
    { id : String
    , name : String
    , parent : Maybe String
    , icon : Maybe String
    , description : Maybe String
    }
