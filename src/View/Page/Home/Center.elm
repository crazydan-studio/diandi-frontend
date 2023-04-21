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


module View.Page.Home.Center exposing (view)

import Html exposing (Html, div, span)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Model
import Msg
import View.Page as Page
import View.Page.Topic.List as TopicList


view : Model.State -> Html Msg.Msg
view state =
    div
        [ class "w-full h-full"
        , class "flex"
        , class "overflow-hidden"
        ]
        [ div
            [ class "w-full h-full"
            , class "overflow-y-auto"
            , class "px-14 md:px-20 pt-8 pb-4"
            ]
            [ TopicList.view state ]
        , tools state
        ]


tools : Model.State -> Html Msg.Msg
tools _ =
    div
        [ class "absolute right-0"
        , class "h-full w-14 md:w-20"
        , class "flex flex-col"
        , class "items-center justify-center"
        ]
        [ span
            [ class "w-10 h-10 md:w-14 md:h-14"
            , class "flex"
            , class "items-center justify-center"
            , class "rounded-full cursor-pointer"
            , class "text-white"
            , class "bg-blue-600 hover:bg-blue-500"
            , class "shadow-md hover:shadow-lg"
            , class "transition-colors duration-300 transform"
            , onClick
                (Msg.batch
                    [ Msg.NewTopicPending
                    , Msg.ShowPageLayer Page.NewTopicLayer
                    ]
                )
            ]
            [ Outlined.add 48 Inherit
            ]
        ]
