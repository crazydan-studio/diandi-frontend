module View.Page.Login exposing (view)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Msg


view : RootModel -> Element Msg.Msg
view _ =
    column
        [ width fill
        , height fill
        ]
        [ text "Login Page" ]
