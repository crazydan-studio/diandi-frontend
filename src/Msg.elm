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
    , batch
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
import Model.Remote.Msg as RemoteMsg
import Model.TopicCard as TopicCard
import Task
import Time
import Url
import View.Page as Page


type Msg
    = NoOp
    | Batch (List Msg)
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | FocusOn String
    | ScrollTo String
    | SwitchToDarkTheme Bool
    | AdjustTimeZone Time.Zone
      -- 远端消息
    | RemoteMsg RemoteMsg.Msg
      -- 国际化Port消息
    | I18nPortMsg I18n.Port.Msg
      -- 遮罩
    | ShowPageLayer Page.Layer
    | ClosePageLayer Page.Layer
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


batch : List Msg -> Msg
batch msgs =
    Batch msgs


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
