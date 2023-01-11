module Msg exposing (RootMsg(..), toCmd)

import Browser
import I18n.Port
import Remote exposing (RemoteMsg)
import Url


type RootMsg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
      -- 请求远端数据
    | RemoteFetched RemoteMsg
      -- 国际化
    | I18nPorts I18n.Port.Msg


toCmd : RootMsg -> Cmd RootMsg
toCmd msg =
    Cmd.map
        (\_ ->
            msg
        )
        Cmd.none
