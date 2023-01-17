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
    ( State
    , init
    , onMsg
    , update
    )

import Dict exposing (Dict)
import Widget.Model.Button as Button
import Widget.Msg exposing (Msg(..), WidgetUpdateConfig)


type State appMsg
    = State (Config appMsg) WidgetStates


type alias Config appMsg =
    { toAppMsg : Msg -> appMsg
    }


type alias WidgetStates =
    { button : Dict String Button.State
    }


init : Config appMsg -> State appMsg
init config =
    State config
        { button = Dict.empty
        }


onMsg : (() -> Msg) -> State appMsg -> appMsg
onMsg toMsg (State config _) =
    toMsg () |> config.toAppMsg


update : Msg -> State appMsg -> State appMsg
update msg (State config widgets) =
    State config (updateHelper msg widgets)



-- --------------------------------------------------


updateHelper : Msg -> WidgetStates -> WidgetStates
updateHelper msg widgets =
    case msg of
        UpdateButtonState widget ->
            { widgets
                | button =
                    widgets.button
                        |> updateWidgetHelper
                            widget
            }


updateWidgetHelper :
    WidgetUpdateConfig widgetState
    -> Dict String widgetState
    -> Dict String widgetState
updateWidgetHelper updateConfig stateDict =
    case
        stateDict
            |> Dict.get updateConfig.id
            |> Maybe.withDefault (updateConfig.init ())
            |> updateConfig.update
    of
        Nothing ->
            stateDict
                |> Dict.remove updateConfig.id

        Just state ->
            stateDict
                |> Dict.insert updateConfig.id state
