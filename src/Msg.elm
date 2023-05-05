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
    , fromApp
    , fromAppCmd
    , fromAppSub
    , onUrlChange
    , onUrlRequest
    , pageLayerClose
    , pageLayerOpen
    , step
    )

import App.Msg as AppMsg
import App.State as AppState
import Browser exposing (UrlRequest)
import Url
import Widget.PageLayer as PageLayer


type Msg
    = -- 批量消息
      BatchMsg (List Msg)
      -- 依次执行前后两个消息，且前一个需执行成功才能继续执行下一个消息
    | StepMsg Msg Msg
      -- 遮罩侧消息
    | PageLayerMsg (PageLayer.Msg AppState.State Msg)
      -- 应用侧消息
    | AppMsg AppMsg.Msg


batch : List Msg -> Msg
batch =
    BatchMsg


step : Msg -> Msg -> Msg
step =
    StepMsg


onUrlChange : Url.Url -> Msg
onUrlChange url =
    fromApp (AppMsg.UrlChanged url)


onUrlRequest : UrlRequest -> Msg
onUrlRequest req =
    fromApp (AppMsg.LinkClicked req)


fromApp : AppMsg.Msg -> Msg
fromApp =
    AppMsg


fromAppCmd : Cmd AppMsg.Msg -> Cmd Msg
fromAppCmd =
    Cmd.map fromApp


fromAppSub : Sub AppMsg.Msg -> Sub Msg
fromAppSub =
    Sub.map fromApp


pageLayerOpen : PageLayer.Pager AppState.State Msg -> Msg
pageLayerOpen =
    PageLayer.open PageLayerMsg


pageLayerClose : PageLayer.PagerId -> Msg
pageLayerClose =
    PageLayer.close PageLayerMsg
