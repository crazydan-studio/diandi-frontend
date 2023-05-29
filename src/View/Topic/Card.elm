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


module View.Topic.Card exposing (view)

import App.Msg as AppMsg
import App.Operation as Operation
import App.State as AppState
import App.TopicCard as TopicCard
    exposing
        ( TopicCard
        , TopicCardOp(..)
        , getOpStatus
        )
import Html
    exposing
        ( Html
        , div
        , h1
        , h2
        , span
        , text
        )
import Html.Attributes exposing (class, tabindex)
import Html.Events exposing (on, onClick)
import I18n.Html exposing (textWith)
import Json.Decode as Decode
import Material.Icons.Round as Round
import Material.Icons.Types exposing (Coloring(..))
import Msg exposing (Msg)
import View.I18n.Home as I18n
import View.Topic.Layer.EditTopic
import Widget.Bytemd as Markdown
import Widget.Loading as Loading
import Widget.Mask as Mask
import Widget.Util.DateTime as DateTime


view :
    AppState.State
    -> TopicCard
    -> Html Msg
view { lang, timeZone } { config, topic, op } =
    let
        i18nText =
            I18n.htmlText lang

        opStatus =
            getOpStatus op
    in
    div
        ((case opStatus of
            Operation.Done ->
                [ class "animate-zoom-in"
                , on "animationend"
                    (Decode.succeed
                        (Msg.fromApp <|
                            AppMsg.RemoveTopicCard topic.id
                        )
                    )
                ]

            _ ->
                []
         )
            ++ [ class "w-full h-fit"
               , class "p-2"
               , class
                    (if config.expanded then
                        "basis-auto lg:basis-1/2"

                     else
                        "basis-auto md:basis-1/2 xl:basis-1/4"
                    )
               ]
        )
        [ div
            [ class "relative"
            , class "w-full"
            , class "rounded-md"
            , class "bg-white dark:bg-gray-800"
            , class "shadow-md hover:shadow-lg"
            , class "transition-shadow duration-300"
            ]
            [ Mask.create
                { show =
                    case opStatus of
                        Operation.Doing ->
                            True

                        _ ->
                            False
                , styles = []
                , content =
                    [ Loading.ripple { width = 64, height = 64 }
                    , span
                        []
                        [ [ case op of
                                TrashOp _ ->
                                    "数据正在移除中，请稍等片刻 ..."

                                DeleteOp _ ->
                                    "数据正在删除中，请稍等片刻 ..."

                                RestoreOp _ ->
                                    "数据正在恢复中，请稍等片刻 ..."

                                _ ->
                                    ""
                          ]
                            |> i18nText
                        ]
                    ]
                }
            , div
                [ class "px-4 py-3"
                , class "divide-y divide-gray-100 dark:divide-gray-700"
                ]
                [ div
                    [ class "relative"
                    ]
                    [ span
                        [ class "cursor-pointer"
                        , class "absolute -top-2.5 -right-3.5"
                        , class "dark:text-white hover:text-blue-400"
                        , class "hidden"
                        , class
                            (if config.selected then
                                "text-blue-400"

                             else
                                "text-gray-300"
                            )
                        , onClick
                            (Msg.fromApp <|
                                AppMsg.TopicCardMsg
                                    topic.id
                                    (TopicCard.Select (not config.selected))
                            )
                        ]
                        [ if config.selected then
                            Round.check_circle 20 Inherit

                          else
                            Round.radio_button_unchecked 20 Inherit
                        ]
                    , h1
                        [ class "flex-1"
                        , class "text-lg font-semibold"
                        , class "whitespace-pre-wrap break-all"
                        , class
                            (topic.title
                                |> Maybe.map (\_ -> "text-blue-400 dark:text-white")
                                |> Maybe.withDefault "text-gray-400 dark:text-gray-300"
                            )
                        ]
                        [ topic.title
                            |> Maybe.map
                                (\t ->
                                    text t
                                )
                            |> Maybe.withDefault
                                ([ "无标题" ]
                                    |> i18nText
                                )
                        ]
                    , h2
                        [ class "text-sm"
                        , class "text-gray-600 dark:text-gray-400"
                        ]
                        [ text
                            ("@"
                                ++ (topic.updatedAt
                                        |> Maybe.map
                                            (DateTime.format
                                                "yyyy-MM-dd HH:mm:ss"
                                                timeZone
                                            )
                                        |> Maybe.withDefault ""
                                   )
                            )
                        ]
                    ]
                , div
                    [ class "mt-2 p-4"
                    , class "text-sm whitespace-pre-wrap break-words"
                    , class "text-gray-600 dark:text-gray-300"
                    , class "overflow-y-auto"
                    , class
                        (if config.expanded then
                            "max-h-96"

                         else
                            "max-h-48"
                        )
                    ]
                    [ Markdown.viewer
                        { value = topic.content
                        , styles = []
                        , lang = lang
                        }
                    ]
                , div
                    []
                    [ if not (List.isEmpty topic.tags) then
                        div
                            [ class "mt-2 flex"
                            , class "flex-wrap items-center gap-2"
                            ]
                            (topic.tags
                                |> List.map
                                    (\tag ->
                                        span
                                            [ class "topic-tag"
                                            , tabindex 0
                                            , onClick
                                                (Msg.fromApp <|
                                                    AppMsg.FilterTopicTagSelected
                                                        tag
                                                )
                                            ]
                                            [ text ("#" ++ tag) ]
                                    )
                            )

                      else
                        div [] []
                    , case opStatus of
                        Operation.Error e ->
                            div
                                [ class "mt-2"
                                , class "text-sm"
                                , class "whitespace-pre-wrap"
                                , class "text-red-500 dark:text-red-600"
                                ]
                                [ [ case op of
                                        TrashOp _ ->
                                            "* 移除失败 - "

                                        DeleteOp _ ->
                                            "* 删除失败 - "

                                        RestoreOp _ ->
                                            "* 恢复失败 - "

                                        _ ->
                                            ""
                                  ]
                                    |> i18nText
                                , textWith e
                                ]

                        _ ->
                            div [] []
                    , div
                        [ class "mt-2 flex"
                        , class "items-center justify-end gap-1"
                        ]
                        [ span
                            [ class "tw-icon-btn"
                            , tabindex 0
                            , onClick
                                (Msg.fromApp <|
                                    AppMsg.TopicCardMsg
                                        topic.id
                                        (if topic.trashed then
                                            TopicCard.Delete Operation.Doing

                                         else
                                            TopicCard.Trash Operation.Doing
                                        )
                                )
                            ]
                            [ (if topic.trashed then
                                Round.delete_forever

                               else
                                Round.delete
                              )
                                20
                                Inherit
                            ]
                        , if topic.trashed then
                            span
                                [ class "tw-icon-btn"
                                , tabindex 0
                                , onClick
                                    (Msg.fromApp <|
                                        AppMsg.TopicCardMsg
                                            topic.id
                                            (TopicCard.Restore Operation.Doing)
                                    )
                                ]
                                [ Round.undo 20 Inherit ]

                          else
                            span
                                [ class "tw-icon-btn"
                                , tabindex 0
                                , onClick
                                    (Msg.batch
                                        [ Msg.fromApp <|
                                            AppMsg.EditTopicPending topic.id
                                        , Msg.pageLayerOpen
                                            View.Topic.Layer.EditTopic.create
                                        ]
                                    )
                                ]
                                [ Round.edit 20 Inherit ]
                        , span
                            [ class "tw-icon-btn"
                            , tabindex 0
                            , onClick
                                (Msg.fromApp <|
                                    AppMsg.TopicCardMsg topic.id
                                        (TopicCard.Expand
                                            (not config.expanded)
                                        )
                                )
                            ]
                            (if config.expanded then
                                [ Round.close_fullscreen 20 Inherit ]

                             else
                                [ Round.open_in_full 20 Inherit ]
                            )
                        ]
                    ]
                ]
            ]
        ]
