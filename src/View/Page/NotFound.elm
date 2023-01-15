module View.Page.NotFound exposing (view)

import Element exposing (..)
import Model
import Msg


view : Model.State -> Element Msg.Msg
view _ =
    column
        [ width fill
        , height fill
        ]
        [ text "Page Not Found" ]
