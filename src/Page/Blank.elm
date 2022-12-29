module Page.Blank exposing (create)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Msg exposing (RootMsg)


create : RootModel -> Element RootMsg
create model =
    el
        [ width fill
        , height fill
        ]
        none
