module Page.Loading exposing (create)

import Element exposing (..)
import Model exposing (RootModel)
import Msg exposing (RootMsg)


create : RootModel -> Element RootMsg
create model =
    column
        [ width fill
        , height fill
        ]
        [ text "Loading Page" ]
