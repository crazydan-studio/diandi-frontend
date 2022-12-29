module Page.NotFound exposing (create)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Msg exposing (RootMsg)


create : RootModel -> Element RootMsg
create model =
    column
        [ width fill
        , height fill
        ]
        [ text "Page Not Found" ]
