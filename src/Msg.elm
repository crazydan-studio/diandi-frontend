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
    , focusOn
    , scrollToBottom
    , scrollToRight
    , toCmd
    , toRemoteCmd
    )

import Browser
import Browser.Dom as Dom
import I18n.Port
import Model.Operation.EditTopic as EditTopic
import Model.Operation.NewTopic as NewTopic
import Model.Remote.Msg as RemoteMsg
import Task
import Url
import Widget.Widget as Widget


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | FocusOn String
    | ScrollTo String
      -- 远端消息
    | RemoteMsg RemoteMsg.Msg
      -- 国际化Port消息
    | I18nPortMsg I18n.Port.Msg
      -- 组件消息
    | WidgetMsg (Widget.Msg Msg)
      -- 数据操作
    | SearchTopicMsg String
    | DropTopicMsg String
    | ShowTopicsList String
    | NewTopicAdded String
    | NewTopicMsg String NewTopic.Msg
    | EditTopicUpdated String
    | EditTopicMsg String EditTopic.Msg


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


focusOn : String -> Cmd Msg
focusOn id =
    Task.attempt
        (\_ -> FocusOn id)
        (Dom.focus id)


scrollToBottom : String -> Cmd Msg
scrollToBottom =
    scrollTo
        (\{ height } ->
            ( 0, height )
        )


scrollToRight : String -> Cmd Msg
scrollToRight =
    scrollTo
        (\{ width } ->
            ( width, 0 )
        )



-- -----------------------------------------------------------------


scrollTo :
    ({ width : Float, height : Float } -> ( Float, Float ))
    -> String
    -> Cmd Msg
scrollTo locator scrollableElementId =
    -- https://github.com/ursi/elm-scroll/blob/master/src/Scroll.elm#L288
    Dom.getViewportOf scrollableElementId
        |> Task.andThen
            (\{ scene } ->
                let
                    ( x, y ) =
                        locator scene
                in
                Dom.setViewportOf
                    scrollableElementId
                    x
                    y
            )
        |> Task.attempt (\_ -> ScrollTo scrollableElementId)
