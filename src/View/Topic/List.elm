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


module View.Topic.List exposing (view)

import App.State as AppState
import App.TopicCard exposing (TopicCard)
import Data.Tree as Tree exposing (Tree)
import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Keyed
import Html.Lazy
import Msg exposing (Msg)
import View.I18n.Home as I18n
import View.Page.DataLoading as DataLoadingPage
import View.Topic.Card as TopicCardView


view : AppState.State -> Html Msg
view app =
    app.topicCards
        |> DataLoadingPage.view
            { lang = app.lang
            }
            (topicListView app)



-- ---------------------------------------------------------------


topicListView :
    AppState.State
    -> Tree TopicCard
    -> Html Msg
topicListView ({ lang, topicFilter } as app) topicCards =
    if Tree.isEmpty topicCards then
        DataLoadingPage.noDataView
            (if topicFilter.trashed then
                [ "回收站还是空空如也的哟～～" ] |> I18n.translate lang

             else
                [ "还未添加主题，请点击添加按钮创建 ..." ] |> I18n.translate lang
            )

    else
        -- 列表增删改性能提升方案，同时lazy可确保在刷新页面时，有滚动条的列表的滚动位置可被浏览器记录，刷新后能够自动恢复浏览位置
        -- https://guide.elm-lang.org/optimization/keyed.html
        Html.Keyed.node "div"
            [ class "flex flex-col md:flex-row"
            , class "flex-wrap min-h-fit content-start"
            ]
            (topicCards
                |> Tree.traverseDepth 1
                    (\_ topicCard _ ->
                        ( topicCard.topic.id
                        , Html.Lazy.lazy2
                            TopicCardView.view
                            app
                            topicCard
                        )
                    )
            )
