module View.Page.Blank exposing (view)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Msg


view : RootModel -> Element Msg.Msg
view _ =
    el
        [ width fill
        , height fill
        ]
        none
