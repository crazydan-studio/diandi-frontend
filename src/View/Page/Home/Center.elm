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

import App.Msg as AppMsg
import App.Operation.CleanTopics as CleanTopics
import App.State as AppState
import Html exposing (Html, div, span)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Material.Icons.Round as Round
import Material.Icons.Types exposing (Coloring(..))
import Msg exposing (Msg)
import View.Topic.Layer.CleanTopics as CleanTopicsLayer
import View.Topic.Layer.NewTopic as NewTopicLayer
import View.Topic.List as TopicList


view : Bool -> AppState.State -> Html Msg
view trashed app =
    div
        [ class "w-full h-full"
        , class "flex"
        , class "overflow-hidden"
        ]
        [ div
            [ class "w-full h-full"
            , class "overflow-y-auto"
            , class "px-6 md:px-20 pt-8 pb-4"
            ]
            [ TopicList.view app ]
        , tools trashed app
        ]


tools : Bool -> AppState.State -> Html Msg
tools trashed state =
    div
        [ class "absolute right-0"
        , class "h-full w-14 md:w-20"
        , class "flex flex-col gap-2"
        , class "items-center justify-center"
        , class "pointer-events-none"
        ]
        (if trashed then
            [ span
                ([ class "tw-float-icon-btn"
                 , class "w-12 h-12 md:w-14 md:h-14"
                 , class "bg-red-600 hover:bg-red-500"
                 ]
                    ++ (if AppState.isEmptyTopicCards state then
                            [ class "hover:bg-red-600 disabled" ]

                        else
                            [ onClick
                                (Msg.batch
                                    [ Msg.fromApp <|
                                        AppMsg.CleanTopicsMsg
                                            CleanTopics.CleanPending
                                    , Msg.pageLayerOpen
                                        CleanTopicsLayer.create
                                    ]
                                )
                            ]
                       )
                )
                [ Round.delete_outline 40 Inherit
                ]
            ]

         else
            [ span
                [ class "tw-float-icon-btn"
                , class "w-10 h-10 md:w-12 md:h-12"
                , class "bg-sky-700 hover:bg-sky-600"
                , onClick
                    (Msg.fromApp <|
                        AppMsg.ShowTashedTopics
                    )
                ]
                [ Round.recycling 32 Inherit
                ]
            , span
                [ class "tw-float-icon-btn"
                , class "w-12 h-12 md:w-14 md:h-14"
                , class "bg-blue-600 hover:bg-blue-500"
                , onClick
                    (Msg.batch
                        [ Msg.fromApp <|
                            AppMsg.NewTopicPending
                        , Msg.pageLayerOpen
                            NewTopicLayer.create
                        ]
                    )
                ]
                [ Round.add 48 Inherit
                ]
            ]
        )
