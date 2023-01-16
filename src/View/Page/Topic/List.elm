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

import Data.TreeStore
import Element exposing (..)
import Element.Keyed
import Element.Lazy
import Model
import Model.Topic exposing (Topic)
import Msg
import Style.Topic
import Theme.Color
import Theme.Color.Element
import View.Page.RemoteData
import Widget.Markdown


view : Model.State -> Element Msg.Msg
view { app } =
    View.Page.RemoteData.view
        app.theme
        topicListView
        app.topics



-- ---------------------------------------------------------------


getPaletteWithDefault :
    Maybe Theme.Color.Color
    -> List (Attribute msg)
    -> List (Attribute msg)
getPaletteWithDefault bgColor defaultPalette =
    case bgColor of
        Just color ->
            Theme.Color.Element.defaultPalette color

        Nothing ->
            defaultPalette


topicListView : Data.TreeStore.Tree Topic -> Element Msg.Msg
topicListView topics =
    -- 列表增删改性能提升方案，同时lazy可确保在刷新页面时，有滚动条的列表的滚动位置可被浏览器记录，刷新后能够自动恢复浏览位置
    -- https://guide.elm-lang.org/optimization/keyed.html
    -- https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/Element-Keyed
    -- https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/Element-Lazy
    Element.Keyed.column
        Style.Topic.topicList
        (topics
            |> Data.TreeStore.traverseDepth 1
                (\_ topic _ ->
                    ( topic.id, Element.Lazy.lazy topicView topic )
                )
        )


topicView : Topic -> Element Msg.Msg
topicView topic =
    column
        Style.Topic.topic
        [ row
            (Style.Topic.topicBody
                ++ getPaletteWithDefault topic.color
                    Style.Topic.topicBodyDefaultPalette
            )
            [ el
                [ width fill
                , padding 8
                ]
                (el
                    Style.Topic.contentInTopicBody
                    (paragraph
                        [ height shrink
                        , centerY
                        ]
                        [ Widget.Markdown.render topic.content
                        ]
                    )
                )
            ]
        ]
