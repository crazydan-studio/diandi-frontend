module View.Page.Blank exposing (view)

import Element exposing (..)
import Model
import Msg


view : Model.State -> Element Msg.Msg
view _ =
    el
        [ width fill
        , height fill
        ]
        none
