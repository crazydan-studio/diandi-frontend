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

import Browser
import Model exposing (Config, Model)
import Msg exposing (Msg)
import View.App
import Widget.PageLayer as PageLayer exposing (PageLayer)


type alias State =
    { model : Model
    , pageLayer : PageLayer Model Msg
    }


main : Program Config State Msg
main =
    -- https://guide.elm-lang.org/webapps/navigation.html
    Browser.application
        { view =
            \{ model, pageLayer } ->
                View.App.view pageLayer model
        , init =
            \config url navKey ->
                let
                    ( model, cmd ) =
                        Model.init config url navKey
                in
                ( { model = model
                  , pageLayer = PageLayer.init
                  }
                , Msg.fromModelCmd cmd
                )
        , update = update
        , subscriptions =
            \{ model } ->
                Msg.fromModelSub (Model.sub model)
        , onUrlChange =
            \url ->
                Msg.model (Model.UrlChanged url)
        , onUrlRequest =
            \req ->
                Msg.model (Model.LinkClicked req)
        }


update : Msg -> State -> ( State, Cmd Msg )
update msg ({ model, pageLayer } as state) =
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
                        pageLayer
                        pageLayerMsg
              }
            , Cmd.none
            )

        Msg.ModelMsg modelMsg ->
            let
                ( newModel, newCmd ) =
                    Model.update modelMsg model
            in
            ( { state
                | model = newModel
              }
            , Msg.fromModelCmd newCmd
            )
