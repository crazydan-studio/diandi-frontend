{-
   点滴(DianDi) - 聚沙成塔，集腋成裘
   Copyright (C) 2022 by Crazydan Studio (https://studio.crazydan.org/)

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
-}


module Msg exposing
    ( Msg(..)
    , toCmd
    , toRemoteCmd
    )

import Browser
import I18n.Port
import Model.Remote.Msg as RemoteMsg
import Url
import Widget.Msg


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
      -- 远端消息
    | RemoteMsg RemoteMsg.Msg
      -- 国际化Port消息
    | I18nPortMsg I18n.Port.Msg
      -- 组件消息
    | WidgetMsg Widget.Msg.Msg
      -- 选中数据
    | TopicCategorySelected String


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
