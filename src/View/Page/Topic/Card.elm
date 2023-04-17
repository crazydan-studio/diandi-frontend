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


module View.Page.Topic.Card exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Events exposing (..)
import Element.Font as Font
import Html
import Html.Attributes as HtmlAttr
import Html.Events as HtmlEvent
import I18n.Element exposing (textWith)
import I18n.I18n exposing (langTextEnd)
import Json.Decode as Json
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Model
import Model.Operation.Deletion as Deletion
import Model.TopicCard as TopicCard exposing (TopicCard)
import Msg
import View.I18n.Home as I18n
import View.Page as Page
import Widget.Loading as Loading


view :
    Model.State
    -> TopicCard
    -> Element Msg.Msg
view { theme, widgets, withI18nElement } { config, topic, deletion } =
    let
        i18nText =
            withI18nElement I18n.text
    in
    column
        ([ class "topic-card"
         , class "size-fit"
         , alignTop
         ]
            ++ (case deletion of
                    Deletion.DeleteDoing ->
                        [ inFront
                            (el
                                [ width fill
                                , height fill
                                , Background.color theme.layerBackgroundColor
                                ]
                                (row
                                    [ centerX
                                    , centerY
                                    , Font.size 16
                                    , Font.color theme.primaryWhiteBackgroundColor
                                    ]
                                    [ Loading.ball { width = 64, height = 64 }
                                    , paragraph []
                                        [ ("数据正在删除中，请稍等片刻 ..." :: langTextEnd)
                                            |> i18nText
                                        ]
                                    ]
                                )
                            )
                        ]

                    Deletion.DeleteDone ->
                        [ class "delete-zoom"

                        -- 动画结束后从列表中移除
                        , on "animationend"
                            (Json.succeed
                                (Msg.TopicCardMsg
                                    topic.id
                                    (TopicCard.Delete Deletion.DeleteDone)
                                )
                            )
                        ]

                    _ ->
                        []
               )
        )
        [ html <|
            Html.div
                [ HtmlAttr.class "w-full px-4 py-3 bg-white rounded-md shadow-md dark:bg-gray-800"
                ]
                [ Html.div []
                    [ Html.h1
                        [ HtmlAttr.class "mt-2 text-lg whitespace-pre-wrap font-semibold text-blue-400 dark:text-white"
                        ]
                        [ Html.text (topic.title |> Maybe.withDefault "无标题")
                        ]
                    , Html.h2
                        [ HtmlAttr.class "text-sm text-gray-600 dark:text-gray-400"
                        ]
                        [ Html.text "@2023-04-12 12:23:21"
                        ]
                    , Html.p
                        [ HtmlAttr.class "mt-2 text-sm whitespace-pre-wrap overflow-y-auto text-gray-600 dark:text-gray-300"
                        , HtmlAttr.class
                            (if config.expanded then
                                "max-h-full"

                             else
                                "max-h-36"
                            )
                        ]
                        [ Html.text topic.content ]
                    ]
                , Html.div
                    []
                    [ Html.div
                        [ HtmlAttr.class "flex flex-wrap items-center mt-2"
                        ]
                        (topic.tags
                            |> List.map
                                (\tag ->
                                    Html.a
                                        [ HtmlAttr.class "mr-4 my-1.5 cursor-pointer text-blue-800 uppercase dark:text-blue-900 hover:underline hover:text-blue-700 dark:hover:text-blue-800 transition-colors duration-300"
                                        , HtmlAttr.tabindex 0
                                        ]
                                        [ Html.text ("#" ++ tag) ]
                                )
                        )
                    , case deletion of
                        Deletion.DeleteError e ->
                            Html.div
                                [ HtmlAttr.class "mt-2 text-sm whitespace-pre-wrap text-red-500 dark:text-red-600"
                                ]
                                [ Html.text ("* " ++ "删除失败 - ")
                                , Html.span [] [ Html.text "Bad Gateway" ]
                                ]

                        _ ->
                            Html.div [] []
                    , Html.div
                        [ HtmlAttr.class "flex items-center justify-center mt-2"
                        ]
                        [ Html.a
                            [ HtmlAttr.class "flex items-center mr-4 cursor-pointer text-gray-500 dark:text-gray-400 hover:text-gray-400 dark:hover:text-gray-300 transition-colors duration-300"
                            , HtmlAttr.tabindex 0
                            , HtmlEvent.onClick
                                (Msg.TopicCardMsg
                                    topic.id
                                    (TopicCard.Delete Deletion.DeleteDoing)
                                )
                            ]
                            [ Outlined.delete 24 Inherit, Html.text "删除" ]
                        , Html.a
                            [ HtmlAttr.class "flex items-center mr-4 cursor-pointer text-gray-500 dark:text-gray-400 hover:text-gray-400 dark:hover:text-gray-300 transition-colors duration-300"
                            , HtmlAttr.tabindex 0
                            , HtmlEvent.onClick
                                (Msg.batch
                                    [ Msg.EditTopicPending topic.id
                                    , Msg.ShowPageLayer Page.EditTopicLayer
                                    ]
                                )
                            ]
                            [ Outlined.edit 24 Inherit, Html.text "编辑" ]
                        , Html.a
                            [ HtmlAttr.class "flex items-center mr-0 cursor-pointer text-gray-500 dark:text-gray-400 hover:text-gray-400 dark:hover:text-gray-300 transition-colors duration-300"
                            , HtmlAttr.tabindex 0
                            , HtmlEvent.onClick
                                (Msg.TopicCardMsg topic.id
                                    (TopicCard.Expand
                                        (not config.expanded)
                                    )
                                )
                            ]
                            (if config.expanded then
                                [ Outlined.expand_less 24 Inherit, Html.text "收起" ]

                             else
                                [ Outlined.expand_more 24 Inherit, Html.text "展开" ]
                            )
                        ]
                    ]
                ]
        ]
