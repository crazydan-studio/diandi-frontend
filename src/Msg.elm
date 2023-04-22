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
    , fromModelCmd
    , fromModelSub
    , model
    , pageLayerClose
    , pageLayerOpen
    )

import Model exposing (Model)
import Widget.PageLayer as PageLayer


type Msg
    = BatchMsg (List Msg)
    | PageLayerMsg (PageLayer.Msg Model Msg)
    | ModelMsg Model.Msg


model : Model.Msg -> Msg
model =
    ModelMsg


fromModelCmd : Cmd Model.Msg -> Cmd Msg
fromModelCmd =
    Cmd.map model


fromModelSub : Sub Model.Msg -> Sub Msg
fromModelSub =
    Sub.map model


pageLayerOpen : PageLayer.Pager Model Msg -> Msg
pageLayerOpen =
    PageLayer.open PageLayerMsg


pageLayerClose : PageLayer.PagerId -> Msg
pageLayerClose =
    PageLayer.close PageLayerMsg


batch : List Msg -> Msg
batch =
    BatchMsg
