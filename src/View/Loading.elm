module View.Loading exposing (view)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Msg exposing (RootMsg)


view : RootModel -> Element RootMsg
view _ =
    column
        [ width fill
        , height fill
        ]
        [ el
            [ centerX
            , centerY
            ]
            (text "加载中...")
        ]
