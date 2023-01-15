module Widget.Model exposing
    ( Msg(..)
    , State
    , Widget
    , WidgetStateUpdater
    , init
    , onMsg
    , update
    )

import Dict exposing (Dict)
import Widget.Model.Button as Button


type Msg
    = UpdateButtonState String (() -> Button.State) (WidgetStateUpdater Button.State)


type alias WidgetStateUpdater widgetState =
    widgetState -> widgetState


type alias State rootMsg =
    { toRootMsg : Msg -> rootMsg
    , button : Dict String Button.State
    }


type alias Widget rootMsg =
    { id : String
    , state : State rootMsg
    }


init :
    (Msg -> rootMsg)
    -> State rootMsg
init toRootMsg =
    { toRootMsg = toRootMsg
    , button = Dict.empty
    }


update :
    Msg
    -> State rootMsg
    -> State rootMsg
update msg state =
    case msg of
        UpdateButtonState id initState updateState ->
            let
                newState =
                    Dict.get id state.button
                        |> Maybe.withDefault (initState ())
                        |> updateState
            in
            { state
                | button =
                    state.button
                        |> Dict.insert id newState
            }


onMsg :
    (String -> Msg)
    -> Widget rootMsg
    -> rootMsg
onMsg toMsg { id, state } =
    toMsg id |> state.toRootMsg
