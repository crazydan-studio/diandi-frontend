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


module App.Msg exposing (Msg(..), focusOn, toRemoteCmd)

import Browser
import Browser.Dom as Dom
import I18n.Port
import App.Operation.EditTopic as EditTopic
import App.Remote.Msg as RemoteMsg
import App.TopicCard as TopicCard
import Task
import Time
import Url


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | FocusOn String
    | SwitchToDarkTheme Bool
    | AdjustTimeZone Time.Zone
      -- 远端消息
    | RemoteMsg RemoteMsg.Msg
      -- 国际化Port消息
    | I18nPortMsg I18n.Port.Msg
      -- 数据操作
    | SearchTopic
    | SearchTopicInputing String
    | TopicCardMsg String TopicCard.Msg
    | RemoveTopicCard String
    | NewTopicPending
    | NewTopicMsg EditTopic.Msg
    | NewTopicSaving
    | NewTopicCleaned
    | EditTopicPending String
    | EditTopicMsg EditTopic.Msg
    | EditTopicSaving
    | EditTopicCleaned


{-| 发起远程请求
-}
toRemoteCmd : Cmd RemoteMsg.Msg -> Cmd Msg
toRemoteCmd msg =
    Cmd.map RemoteMsg msg


{-| 获取焦点
-}
focusOn : String -> Cmd Msg
focusOn id =
    Task.attempt
        (\_ -> FocusOn id)
        (Dom.focus id)