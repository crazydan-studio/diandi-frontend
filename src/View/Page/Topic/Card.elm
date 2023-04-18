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
import Element.Events exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttr
import Html.Events as HtmlEvent
import I18n.Element exposing (textWith)
import I18n.I18n exposing (langTextEnd)
import Json.Decode as Decode
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Model
import Model.Operation as Operation
import Model.TopicCard as TopicCard exposing (TopicCard)
import Msg
import View.I18n.Home as I18n
import View.Page as Page
import Widget.Loading as Loading


view :
    Model.State
    -> TopicCard
    -> Html Msg.Msg
view { theme, widgets, withI18nElement } { config, topic, trashOp } =
    let
        i18nText =
            withI18nElement I18n.text
    in
    Html.div
        ((case trashOp of
            Operation.Done ->
                [ HtmlAttr.class "animate-zoom-in"
                , HtmlEvent.on "animationend"
                    (Decode.succeed
                        (Msg.RemoveTopicCard topic.id)
                    )
                ]

            _ ->
                []
         )
            ++ [ HtmlAttr.class "w-full h-fit p-2 basis-auto md:basis-1/2 lg:basis-1/3 xl:basis-1/4 2xl:basis-1/5"
               ]
        )
        [ Html.div
            [ HtmlAttr.class "relative w-full rounded-md shadow-md bg-white dark:bg-gray-800 hover:shadow-lg transition-shadow duration-300"
            ]
            [ Html.div
                [ HtmlAttr.class "absolute w-full h-full z-10 p-8 rounded-md flex flex-row items-center justify-center bg-black/50"
                , HtmlAttr.class
                    (case trashOp of
                        Operation.Doing ->
                            ""

                        _ ->
                            "hidden"
                    )
                ]
                [ Loading.ripple { width = 64, height = 64 }
                , Html.span
                    [ HtmlAttr.class "whitespace-pre-wrap break-all text-white text-base"
                    ]
                    [ Html.text "数据正在移除中，请稍等片刻 ..."
                    ]
                ]
            , Html.div
                [ HtmlAttr.class "px-4 py-3"
                ]
                [ Html.div
                    [ HtmlAttr.class "relative"
                    ]
                    [ Html.span
                        [ HtmlAttr.class "hidden absolute -top-2.5 -right-3.5 cursor-pointer dark:text-white hover:text-blue-400"
                        , HtmlAttr.class
                            (if config.selected then
                                "text-blue-400"

                             else
                                "text-gray-300"
                            )
                        , HtmlEvent.onClick
                            (Msg.TopicCardMsg
                                topic.id
                                (TopicCard.Select (not config.selected))
                            )
                        ]
                        [ if config.selected then
                            Outlined.check_circle 20 Inherit

                          else
                            Outlined.radio_button_unchecked 20 Inherit
                        ]
                    , Html.h1
                        [ HtmlAttr.class "flex-1 text-lg whitespace-pre-wrap break-all font-semibold"
                        , HtmlAttr.class
                            (topic.title
                                |> Maybe.map (\_ -> "text-blue-400 dark:text-white")
                                |> Maybe.withDefault "text-gray-400 dark:text-gray-300"
                            )
                        ]
                        [ Html.text (topic.title |> Maybe.withDefault "无标题")
                        ]
                    , Html.h2
                        [ HtmlAttr.class "text-sm text-gray-600 dark:text-gray-400"
                        ]
                        [ Html.text "@2023-04-12 12:23:21"
                        ]
                    , Html.p
                        [ HtmlAttr.class "mt-2 text-sm whitespace-pre-wrap break-all overflow-y-auto text-gray-600 dark:text-gray-300"
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
                    [ if not (List.isEmpty topic.tags) then
                        Html.div
                            [ HtmlAttr.class "flex flex-wrap items-center gap-2 mt-2"
                            ]
                            (topic.tags
                                |> List.map
                                    (\tag ->
                                        Html.span
                                            [ HtmlAttr.class "topic-tag"
                                            , HtmlAttr.tabindex 0
                                            ]
                                            [ Html.text ("#" ++ tag) ]
                                    )
                            )

                      else
                        Html.div [] []
                    , case trashOp of
                        Operation.Error e ->
                            Html.div
                                [ HtmlAttr.class "mt-2 text-sm whitespace-pre-wrap text-red-500 dark:text-red-600"
                                ]
                                [ Html.text ("* " ++ "删除失败 - ")
                                , Html.span [] [ Html.text "Bad Gateway" ]
                                ]

                        _ ->
                            Html.div [] []
                    , Html.div
                        [ HtmlAttr.class "flex items-center justify-end gap-1 mt-2"
                        ]
                        [ Html.span
                            [ HtmlAttr.class "icon-button"
                            , HtmlAttr.tabindex 0
                            , HtmlEvent.onClick
                                (Msg.TopicCardMsg
                                    topic.id
                                    (TopicCard.Trash Operation.Doing)
                                )
                            ]
                            [ Outlined.delete 20 Inherit ]
                        , Html.span
                            [ HtmlAttr.class "icon-button"
                            , HtmlAttr.tabindex 0
                            , HtmlEvent.onClick
                                (Msg.batch
                                    [ Msg.EditTopicPending topic.id
                                    , Msg.ShowPageLayer Page.EditTopicLayer
                                    ]
                                )
                            ]
                            [ Outlined.edit 20 Inherit ]
                        , Html.span
                            [ HtmlAttr.class "icon-button"
                            , HtmlAttr.tabindex 0
                            , HtmlEvent.onClick
                                (Msg.TopicCardMsg topic.id
                                    (TopicCard.Expand
                                        (not config.expanded)
                                    )
                                )
                            ]
                            (if config.expanded then
                                [ Outlined.expand_less 20 Inherit ]

                             else
                                [ Outlined.expand_more 20 Inherit ]
                            )
                        ]
                    ]
                ]
            ]
        ]
