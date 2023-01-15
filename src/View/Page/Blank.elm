module View.Page.Blank exposing (view)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Msg exposing (RootMsg)


view : RootModel -> Element RootMsg
view _ =
    el
        [ width fill
        , height fill
        ]
        none
