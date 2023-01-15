module Model.Remote.Data exposing
    ( Status(..)
    , from
    )

import Http
import Model.Remote exposing (parseError)


type Status dataType
    = LoadWaiting
    | Loading
    | Loaded dataType
    | LoadingError String


from : (a -> b) -> Result Http.Error a -> Status b
from convert result =
    case result of
        Ok data ->
            Loaded (convert data)

        Err error ->
            LoadingError (parseError error)
