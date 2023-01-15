module Widget.Model.Button exposing (State, init)


type alias State =
    { disabled : Bool
    }


init : State
init =
    { disabled = False
    }
