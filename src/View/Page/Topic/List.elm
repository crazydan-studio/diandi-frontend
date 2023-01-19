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
import Element.Background as Background
import Element.Border as Border
import Element.Keyed
import Element.Lazy
import Model
import Model.Topic exposing (Topic)
import Msg
import Style.Topic
import Theme.Color
import Theme.Color.Element
import View.Page.RemoteData
import Widget.Html
import Widget.Markdown


view : Model.State -> Element Msg.Msg
view { app } =
    View.Page.RemoteData.view
        { theme = app.theme
        , lang = app.lang
        }
        topicListView
        app.topics



-- ---------------------------------------------------------------


toRgbColorWithDefault :
    Maybe Theme.Color.Color
    -> Theme.Color.Color
    -> Color
toRgbColorWithDefault color defaultColor =
    color
        |> Maybe.withDefault defaultColor
        |> Theme.Color.Element.toRgbColor


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
    let
        -- 空洞宽度
        cardHoleWidth =
            32

        -- 孔洞左侧留白大小
        cardHolePaddingLeft =
            4

        -- 打孔区域宽度
        cardHolePaneWidth =
            48

        -- 打孔区域分隔线宽度
        cardHolePaneSeparatorWidth =
            3

        -- 打孔区域可见区域宽度
        cardHolePaneDisplayWidth =
            cardHolePaneWidth - gridLineMoveLeft - cardHolePaneSeparatorWidth

        -- 格线左移位置
        gridLineMoveLeft =
            8

        -- 主题内容的横向留白大小
        contentPaddingX =
            16 + gridLineMoveLeft + cardHolePaneSeparatorWidth

        contentPaddingY =
            16
    in
    column
        (Style.Topic.topic
            ++ [ paddingEach
                    { top = 0
                    , right = 0
                    , left = cardHolePaneDisplayWidth
                    , bottom = 0
                    }
               ]
        )
        [ row
            (Style.Topic.topicBody
                ++ [ inFront
                        (el
                            [ width (px cardHolePaneWidth)
                            , height fill
                            , moveLeft cardHolePaneDisplayWidth
                            , paddingEach
                                { top = contentPaddingY - 1
                                , left = 0
                                , right = 0
                                , bottom = 0
                                }
                            , Widget.Html.noPointerEvents
                            , Border.widthEach
                                { top = 0
                                , left = 0
                                , right = cardHolePaneSeparatorWidth
                                , bottom = 0
                                }
                            , Border.solid
                            , Border.color
                                (toRgbColorWithDefault
                                    topic.color
                                    Style.Topic.topicDefaultColor
                                )
                            ]
                            (el
                                [ width fill
                                , height fill
                                , Widget.Html.styles
                                    [ ( "background-image"
                                      , "url(/img/hole.svg)"
                                      )
                                    , ( "background-repeat"
                                      , "repeat-y"
                                      )
                                    , ( "background-size"
                                      , String.fromInt cardHoleWidth ++ "px"
                                      )
                                    , ( "background-position"
                                      , String.fromInt cardHolePaddingLeft ++ "px 0"
                                      )
                                    ]
                                ]
                                none
                            )
                        )
                   ]
            )
            [ el
                [ width fill
                , paddingXY contentPaddingX contentPaddingY
                , alignTop
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
