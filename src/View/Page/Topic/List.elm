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


module View.Page.Topic.List exposing (view)

import Data.TreeStore as TreeStore exposing (TreeStore)
import Element exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttr
import Html.Keyed
import Html.Lazy
import Model
import Model.TopicCard exposing (TopicCard)
import Msg
import View.Page.RemoteData as RemoteDataPage
import View.Page.Topic.Card as TopicCardView


view : Model.State -> Element Msg.Msg
view ({ app, theme } as state) =
    app.topicCards
        |> RemoteDataPage.view
            { theme = theme
            , lang = app.lang
            }
            (topicListView state)



-- ---------------------------------------------------------------


topicListView :
    Model.State
    -> TreeStore TopicCard
    -> Element Msg.Msg
topicListView ({ app, theme } as state) topicCards =
    if TreeStore.isEmpty topicCards then
        RemoteDataPage.noDataView
            { theme = theme
            , lang = app.lang
            }

    else
        -- 列表增删改性能提升方案，同时lazy可确保在刷新页面时，有滚动条的列表的滚动位置可被浏览器记录，刷新后能够自动恢复浏览位置
        -- https://guide.elm-lang.org/optimization/keyed.html
        html <|
            Html.Keyed.node "div"
                [ HtmlAttr.class "flex flex-col md:flex-row"
                , HtmlAttr.class "flex-wrap min-h-fit content-start"
                ]
                (topicCards
                    |> TreeStore.traverseDepth 1
                        (\_ topicCard _ ->
                            ( topicCard.topic.id
                            , Html.Lazy.lazy2
                                TopicCardView.view
                                state
                                topicCard
                            )
                        )
                )
