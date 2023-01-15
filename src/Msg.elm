module Msg exposing
    ( Msg(..)
    , toCmd
    , toRemoteCmd
    )

import Browser
import I18n.Port
import Model.Remote.Msg as RemoteMsg
import Url
import Widget.Model


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
      -- 远端消息
    | RemoteMsg RemoteMsg.Msg
      -- 国际化Port消息
    | I18nPortMsg I18n.Port.Msg
      -- 组件消息
    | WidgetMsg Widget.Model.Msg


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
    Cmd.map RemoteMsg msg
