module View.Page.Login exposing (view)

import Element exposing (..)
import Model
import Msg


view : Model.State -> Element Msg.Msg
view _ =
    column
        [ width fill
        , height fill
        ]
        [ text "Login Page" ]
