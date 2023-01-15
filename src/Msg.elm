module Msg exposing
    ( Msg(..)
    , toCmd
    , toRemoteCmd
    )

import Browser
import I18n.Port
import Model.Remote.Msg as RemoteMsg
import Url


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
      -- 请求远端数据
    | RemoteFetched RemoteMsg.Msg
      -- 国际化
    | I18nPorts I18n.Port.Msg


toCmd : Msg -> Cmd Msg
toCmd msg =
    Cmd.map
        (\_ ->
            msg
        )
        Cmd.none


{-| 发起远程请求
-}
toRemoteCmd : Cmd RemoteMsg.Msg -> Cmd Msg
toRemoteCmd msg =
    Cmd.map RemoteFetched msg
