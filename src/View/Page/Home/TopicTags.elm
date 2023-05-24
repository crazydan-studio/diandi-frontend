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


module View.Page.Home.TopicTags exposing (view)

import App.Msg as AppMsg
import App.State as AppState
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Msg exposing (Msg)


view : AppState.State -> Html Msg
view { topicFilter } =
    div
        [ class "z-[1] absolute top-14"
        , class "w-full px-8"
        , class "flex flex-wrap items-center justify-center gap-2"
        , class "bg-transparent"
        , class
            (if topicFilter.tags |> List.isEmpty then
                ""

             else
                "h-10 py-2"
            )
        ]
        (topicFilter.tags
            |> List.map
                (\tag ->
                    div
                        [ class "flex gap-1 px-2 py-0.5 items-center"
                        , class "rounded-full"
                        , class "text-sm font-bold"
                        , class "text-gray-600 hover:text-gray-500 dark:text-gray-400 dark:hover:text-gray-300"
                        , class "bg-slate-200 hover:bg-slate-300 dark:bg-slate-700 dark:hover:bg-slate-600"
                        , class "transition-colors duration-300"
                        ]
                        [ span [] [ text ("#" ++ tag) ]
                        , span
                            [ class "cursor-pointer"
                            , onClick
                                (Msg.fromApp <|
                                    AppMsg.FilterTopicTagDeleted
                                        tag
                                )
                            ]
                            [ Outlined.highlight_off 16 Inherit ]
                        ]
                )
        )
