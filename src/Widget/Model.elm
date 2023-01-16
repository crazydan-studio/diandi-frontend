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
