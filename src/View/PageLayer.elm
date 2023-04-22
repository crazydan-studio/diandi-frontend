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

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model
import Msg
import View.Page exposing (Layer(..))
import View.Topic.Layer.EditTopic
import View.Topic.Layer.NewTopic


create : Model.State -> Html Msg.Msg
create ({ layers } as state) =
    case layers of
        [] ->
            div [] []

        layer :: _ ->
            div
                [ class "absolute z-50"
                , class "flex"
                , class "justify-center"
                , class "w-full h-full"
                , class "bg-black/60 dark:bg-black/50"
                ]
                [ createHelper layer state ]



-- -----------------------------------------------------------


createHelper : Layer -> Model.State -> Html Msg.Msg
createHelper type_ state =
    case type_ of
        NewTopicLayer ->
            View.Topic.Layer.NewTopic.create state

        EditTopicLayer ->
            View.Topic.Layer.EditTopic.create state

        _ ->
            div [] []
