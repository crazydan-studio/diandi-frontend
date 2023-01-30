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

import Base64
import Data.TreeStore exposing (TreeStore)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Keyed
import Element.Lazy
import Model
import Model.Topic exposing (Topic)
import Msg
import Theme.Theme as Theme exposing (Theme)
import View.Page.RemoteData as RemoteDataPage
import View.Style.Base as BaseStyle
import Widget.Color
import Widget.Html
import Widget.Part.Markdown as Markdown


view : Model.State -> Element Msg.Msg
view ({ app } as state) =
    app.topics
        |> RemoteDataPage.view
            { theme = app.theme
            , lang = app.lang
            }
            (topicListView state)



-- ---------------------------------------------------------------


bgColor : Theme -> Color
bgColor =
    Theme.primaryGreyBackgroundColor


topicListView :
    Model.State
    -> TreeStore Topic
    -> Element Msg.Msg
topicListView state topics =
    -- 列表增删改性能提升方案，同时lazy可确保在刷新页面时，有滚动条的列表的滚动位置可被浏览器记录，刷新后能够自动恢复浏览位置
    -- https://guide.elm-lang.org/optimization/keyed.html
    -- https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/Element-Keyed
    -- https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/Element-Lazy
    Element.Keyed.column
        [ width fill
        , height fill
        , spacing BaseStyle.spacing
        , centerX
        ]
        (topics
            |> Data.TreeStore.traverseDepth 1
                (\_ topic _ ->
                    ( topic.id, Element.Lazy.lazy2 topicView state topic )
                )
        )


topicView :
    Model.State
    -> Topic
    -> Element Msg.Msg
topicView { app, widgets } topic =
    let
        -- 空洞宽度
        cardHoleWidth =
            gridLineSpacing

        -- 孔洞左侧留白大小
        cardHolePaddingLeft =
            4

        -- 打孔区域宽度
        cardHolePaneWidth =
            cardHoleWidth
                + cardHolePaddingLeft
                + (gridLineMoveLeft + 1)
                + cardHolePaneSeparatorWidth

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
            gridLineSpacing // 2

        contentFontSize =
            app.theme.primaryFontSize

        gridLineColor =
            "#91d1d3"

        gridLineSize =
            1

        gridLineSpacing =
            32
    in
    -- TODO 提取组件样式，避免重复计算
    column
        [ id topic.id
        , width fill
        , Background.color (rgb255 255 255 255)
        , Border.rounded 4
        , paddingEach
            { top = 0
            , right = 0
            , left = cardHolePaneDisplayWidth
            , bottom = 0
            }

        -- box-shadow: 0px 2px 1px -1px rgba(0,0,0,0.2),0px 1px 1px 0px rgba(0,0,0,0.14),0px 1px 3px 0px rgba(0,0,0,0.12);
        , Border.shadows
            [ { inset = False
              , offset = ( 0, 2 )
              , blur = 1
              , size = -1
              , color = rgba255 0 0 0 0.2
              }
            , { inset = False
              , offset = ( 0, 1 )
              , blur = 1
              , size = 0
              , color = rgba255 0 0 0 0.14
              }
            , { inset = False
              , offset = ( 0, 1 )
              , blur = 3
              , size = 0
              , color = rgba255 0 0 0 0.12
              }
            ]
        ]
        [ row
            [ width fill
            , height fill
            , Background.color (rgba255 0 0 0 0)
            , Widget.Html.styles
                [ ( "background-image"
                  , "linear-gradient("
                        ++ gridLineColor
                        ++ " "
                        ++ String.fromInt gridLineSize
                        ++ "px, transparent 0)"
                  )
                , ( "background-size"
                  , "100% "
                        ++ String.fromInt gridLineSpacing
                        ++ "px"
                  )
                , ( "background-position"
                  , "0 "
                        ++ String.fromInt contentPaddingY
                        ++ "px"
                  )
                ]
            , inFront
                (el
                    [ width (px cardHolePaneWidth)
                    , height fill
                    , moveLeft cardHolePaneDisplayWidth
                    , paddingEach
                        { top = contentPaddingY
                        , left = 0
                        , right = 0
                        , bottom = contentPaddingY
                        }
                    , Border.widthEach
                        { top = 0
                        , left = 0
                        , right = cardHolePaneSeparatorWidth
                        , bottom = 0
                        }
                    , Border.solid
                    , Border.color
                        (Widget.Color.toRgbColor
                            Widget.Color.Orange900
                        )
                    ]
                    (el
                        [ width fill
                        , height fill
                        , Widget.Html.styles
                            [ ( "background-image"
                              , "url(\"" ++ holeSvgImg app.theme ++ "\")"
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
            [ el
                [ width fill
                , paddingXY contentPaddingX contentPaddingY
                , alignTop
                ]
                (el
                    [ width fill
                    , height fill
                    , Font.size contentFontSize
                    ]
                    (paragraph
                        [ height shrink
                        , centerY

                        -- Note: 默认会设置为5，需显式归零
                        , spacing 0
                        ]
                        [ Markdown.render widgets
                            { lineHeight = gridLineSpacing
                            }
                            topic.content
                        ]
                    )
                )
            ]
        ]


holeSvgImg : Theme -> String
holeSvgImg theme =
    -- https://stackoverflow.com/questions/62539360/svg-how-to-drop-an-inset-shadow-on-a-path-that-has-an-rgba-fill#answer-62627106
    -- Note: 保持尺寸和阴影设定，但背景可按需增减图片尺寸
    """
<svg xmlns="http://www.w3.org/2000/svg"
xmlns:xlink="http://www.w3.org/1999/xlink" width="96px" height="96px" viewBox="0 0 96 96">
<defs>
    <filter id="inset-shadow">
        <feColorMatrix in="SourceGraphic" type="matrix" values="0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 100 0" result="opaque-source"/>
        <feGaussianBlur stdDeviation="2"/>
        <!-- 阴影偏移 -->
        <feOffset dy="4"/>
        <feComposite operator="xor" in2="opaque-source"/>
        <feComposite operator="in" in2="opaque-source"/>
        <feComposite operator="over" in2="SourceGraphic"/>
    </filter>
</defs>
<circle filter="url(#inset-shadow)" cx="48" cy="50" r="32" fill="
"""
        ++ Widget.Html.toRgba (bgColor theme)
        ++ """
" />
</svg>
"""
        |> Base64.encode
        |> (++) "data:image/svg+xml;base64,"
