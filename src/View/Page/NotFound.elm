module View.Page.NotFound exposing (view)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Msg


view : RootModel -> Element Msg.Msg
view _ =
    column
        [ width fill
        , height fill
        ]
        [ text "Page Not Found" ]
