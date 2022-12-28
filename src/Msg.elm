module Msg exposing (RootMsg(..), toCmd)

import Browser
import Remote exposing (RemoteMsg)
import Url


type RootMsg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
      -- 请求远端数据
    | RemoteFetched RemoteMsg


toCmd : RootMsg -> Cmd RootMsg
toCmd msg =
    Cmd.map
        (\_ ->
            msg
        )
        Cmd.none
