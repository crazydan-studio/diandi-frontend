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


module Main exposing (main)

import App.State as AppState
import Browser
import Browser.Navigation as Nav
import Msg exposing (Msg)
import Url
import View.App
import Widget.PageLayer as PageLayer


type alias State =
    { app : AppState.State
    , pageLayer : PageLayer.State AppState.State Msg
    }


type alias Config =
    { title : String
    , description : String
    , lang : String
    }


main : Program Config State Msg
main =
    -- https://guide.elm-lang.org/webapps/navigation.html
    Browser.application
        { -- view
          view = \{ app, pageLayer } -> View.App.view pageLayer app

        -- model
        , init = init
        , update = update
        , subscriptions = \{ app } -> Msg.fromAppSub (AppState.sub app)

        -- routes
        , onUrlChange = Msg.onUrlChange
        , onUrlRequest = Msg.onUrlRequest
        }


init : Config -> Url.Url -> Nav.Key -> ( State, Cmd Msg )
init config navUrl navKey =
    let
        ( app, cmd ) =
            AppState.init
                { title = config.title
                , description = config.description
                , lang = config.lang
                , navKey = navKey
                , navUrl = navUrl
                }
    in
    ( { app = app
      , pageLayer = PageLayer.init
      }
    , Msg.fromAppCmd cmd
    )


update : Msg -> State -> ( State, Cmd Msg )
update msg ({ app, pageLayer } as state) =
    case msg of
        Msg.BatchMsg batchMsg ->
            batchMsg
                |> List.foldl
                    (\subMsg ( prevState, prevCmd ) ->
                        let
                            ( nextState, nextCmd ) =
                                update subMsg prevState
                        in
                        ( nextState
                        , Cmd.batch [ prevCmd, nextCmd ]
                        )
                    )
                    ( state, Cmd.none )

        Msg.PageLayerMsg pageLayerMsg ->
            ( { state
                | pageLayer =
                    PageLayer.update
                        pageLayerMsg
                        pageLayer
              }
            , Cmd.none
            )

        Msg.AppMsg appMsg ->
            let
                ( newApp, newCmd ) =
                    AppState.update appMsg app
            in
            ( { state
                | app = newApp
              }
            , Msg.fromAppCmd newCmd
            )
