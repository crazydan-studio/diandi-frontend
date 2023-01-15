module Msg exposing
    ( RootMsg(..)
    , toCmd
    , toRemoteCmd
    )

import Browser
import I18n.Port
import Model.Remote.Msg as RemoteMsg
import Url


type RootMsg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
      -- 请求远端数据
    | RemoteFetched RemoteMsg.Msg
      -- 国际化
    | I18nPorts I18n.Port.Msg


toCmd : RootMsg -> Cmd RootMsg
toCmd msg =
    Cmd.map
        (\_ ->
            msg
        )
        Cmd.none


{-| 发起远程请求
-}
toRemoteCmd : Cmd RemoteMsg.Msg -> Cmd RootMsg
toRemoteCmd msg =
    Cmd.map RemoteFetched msg
