module View.Page.Loading exposing (view)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Msg


view : RootModel -> Element Msg.Msg
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
