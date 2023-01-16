module Widget.Model exposing
    ( Msg(..)
    , WidgetUpdater
    , Widgets
    , init
    , onMsg
    , update
    )

import Dict exposing (Dict)
import Widget.Model.Button as Button


type Msg
    = UpdateButtonState (WidgetUpdateConfig Button.State)


type alias WidgetUpdateConfig widgetState =
    { id : String
    , init : () -> widgetState
    , update : WidgetUpdater widgetState
    }


type alias WidgetUpdater widgetState =
    widgetState -> widgetState


type alias Widgets rootMsg =
    { config : Config rootMsg
    , button : Dict String Button.State
    }


type alias Config rootMsg =
    { toRootMsg : Msg -> rootMsg
    }


init :
    Config rootMsg
    -> Widgets rootMsg
init config =
    { config = config
    , button = Dict.empty
    }


update :
    Msg
    -> Widgets rootMsg
    -> Widgets rootMsg
update msg widgets =
    case msg of
        UpdateButtonState config ->
            let
                newState =
                    Dict.get config.id widgets.button
                        |> Maybe.withDefault (config.init ())
                        |> config.update
            in
            { widgets
                | button =
                    widgets.button
                        |> Dict.insert config.id newState
            }


onMsg :
    (() -> Msg)
    -> Widgets rootMsg
    -> rootMsg
onMsg toMsg widgets =
    toMsg () |> widgets.config.toRootMsg
