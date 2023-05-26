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
import App.Store.Mode as StoreMode
import Browser
import Browser.Navigation as Nav
import Msg exposing (Msg)
import Url
import View.App
import Widget.PageLayer as PageLayer


type alias State =
    { app : AppState.State
    , pageLayer : PageLayer.State AppState.State Msg
    , stepMsgQueue :
        { nextMsgId : Int
        , msg : List ( Int, Msg )
        }
    }


type alias Config =
    { title : String
    , description : String
    , lang : String
    , webCtxRootPath : String
    , useLocalStore : Bool
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
                , webCtxRootPath = config.webCtxRootPath
                , navKey = navKey
                , navUrl = navUrl
                , storeMode =
                    if config.useLocalStore then
                        StoreMode.Local

                    else
                        StoreMode.Remote
                }
    in
    ( { app = app
      , pageLayer = PageLayer.init
      , stepMsgQueue =
            { nextMsgId = 0
            , msg = []
            }
      }
    , Msg.fromAppCmd cmd
    )


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    updateHelper msg -1 state



-- -------------------------------------------------------------------------------


updateHelper : Msg -> Int -> State -> ( State, Cmd Msg )
updateHelper msg nextMsgId ({ app, pageLayer, stepMsgQueue } as state) =
    case msg of
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
                ( newApp, newAppCmd, nextMsg ) =
                    AppState.update appMsg nextMsgId app

                ( newState, nextCmd ) =
                    updateByNextStepMsg nextMsg
                        { state
                            | app = newApp
                        }

                newCmd =
                    Msg.fromAppCmd newAppCmd
            in
            ( newState, Cmd.batch [ newCmd, nextCmd ] )

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

        Msg.StepMsg currentMsg nextMsg ->
            updateHelper currentMsg
                stepMsgQueue.nextMsgId
                { state
                    | stepMsgQueue =
                        { nextMsgId = stepMsgQueue.nextMsgId + 1
                        , msg =
                            ( stepMsgQueue.nextMsgId, nextMsg )
                                :: stepMsgQueue.msg
                        }
                }


updateByNextStepMsg : Maybe ( Int, Bool ) -> State -> ( State, Cmd Msg )
updateByNextStepMsg stepMsg ({ stepMsgQueue } as state) =
    case stepMsg of
        Nothing ->
            ( state, Cmd.none )

        Just ( msgId, shouldBeContinue ) ->
            let
                newState =
                    { state
                        | stepMsgQueue =
                            { stepMsgQueue
                                | msg =
                                    stepMsgQueue.msg
                                        |> List.filter
                                            (\( id, _ ) -> id /= msgId)
                            }
                    }
            in
            if shouldBeContinue then
                stepMsgQueue.msg
                    |> List.filter (\( id, _ ) -> id == msgId)
                    |> List.head
                    |> Maybe.map
                        (\( _, msg ) ->
                            updateHelper msg -1 newState
                        )
                    |> Maybe.withDefault ( newState, Cmd.none )

            else
                -- 失败：直接移除，不处理该消息
                ( newState, Cmd.none )
