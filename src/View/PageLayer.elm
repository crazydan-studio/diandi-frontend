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


module View.PageLayer exposing (create)

import Element
    exposing
        ( Element
        , column
        , fill
        , height
        , none
        , rgba255
        , width
        )
import Element.Background as Background
import Model
import Msg
import View.Page exposing (Layer(..))
import View.Page.Layer.NewTopic


create : Model.State -> Element Msg.Msg
create ({ layers } as state) =
    case layers of
        [] ->
            none

        layer :: _ ->
            column
                [ width fill
                , height fill
                , Background.color (rgba255 0 0 0 0.5)
                ]
                [ createHelper layer state ]



-- -----------------------------------------------------------


createHelper : Layer -> Model.State -> Element Msg.Msg
createHelper type_ state =
    case type_ of
        NewTopicLayer ->
            View.Page.Layer.NewTopic.create state
