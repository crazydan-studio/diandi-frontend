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
import Widget.Bytemd as Makedown
import Widget.Loading as Loading
import Widget.Util.DateTime as DateTime
import Html exposing (p)


view :
    Model.State
    -> TopicCard
    -> Html Msg.Msg
view { timeZone, withI18nHtml } { config, topic, trashOp } =
    let
        i18nText =
            withI18nHtml I18n.htmlText
    in
    div
        ((case trashOp of
            Operation.Done ->
                [ class "animate-zoom-in"
                , on "animationend"
                    (Decode.succeed
                        (Msg.RemoveTopicCard topic.id)
                    )
                ]

            _ ->
                []
         )
            ++ [ class "w-full h-fit p-2 basis-auto md:basis-1/2 xl:basis-1/4"
               ]
        )
        [ div
            [ class "relative w-full rounded-md shadow-md bg-white dark:bg-gray-800 hover:shadow-lg transition-shadow duration-300"
            ]
            [ div
                [ class "absolute w-full h-full z-10 p-8 rounded-md flex flex-row items-center justify-center bg-black/50"
                , class
                    (case trashOp of
                        Operation.Doing ->
                            ""

                        _ ->
                            "hidden"
                    )
                ]
                [ Loading.ripple { width = 64, height = 64 }
                , span
                    [ class "whitespace-pre-wrap break-all text-white text-base"
                    ]
                    [ "数据正在移除中，请稍等片刻 ..."
                        :: langTextEnd
                        |> i18nText
                    ]
                ]
            , div
                [ class "px-4 py-3 divide-y divide-gray-100 dark:divide-gray-700"
                ]
                [ div
                    [ class "relative"
                    ]
                    [ span
                        [ class "hidden absolute -top-2.5 -right-3.5 cursor-pointer dark:text-white hover:text-blue-400"
                        , class
                            (if config.selected then
                                "text-blue-400"

                             else
                                "text-gray-300"
                            )
                        , onClick
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
                    , h1
                        [ class "flex-1 text-lg whitespace-pre-wrap break-all font-semibold"
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
                                ("无标题"
                                    :: langTextEnd
                                    |> i18nText
                                )
                        ]
                    , h2
                        [ class "text-sm text-gray-600 dark:text-gray-400"
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
                    [ class "mt-2 py-2 text-sm whitespace-pre-wrap break-words overflow-y-auto text-gray-600 dark:text-gray-300"
                    , class
                        (if config.expanded then
                            "max-h-full"

                         else
                            "max-h-48"
                        )
                    ]
                    [ topic.content
                        |> Makedown.viewer
                            []
                    ]
                , div
                    []
                    [ if not (List.isEmpty topic.tags) then
                        div
                            [ class "flex flex-wrap items-center gap-2 mt-2"
                            ]
                            (topic.tags
                                |> List.map
                                    (\tag ->
                                        span
                                            [ class "topic-tag"
                                            , tabindex 0
                                            ]
                                            [ text ("#" ++ tag) ]
                                    )
                            )

                      else
                        div [] []
                    , case trashOp of
                        Operation.Error e ->
                            div
                                [ class "mt-2 text-sm whitespace-pre-wrap text-red-500 dark:text-red-600"
                                ]
                                [ "* 删除失败 - "
                                    :: langTextEnd
                                    |> i18nText
                                , textWith e
                                ]

                        _ ->
                            div [] []
                    , div
                        [ class "flex items-center justify-end gap-1 mt-2"
                        ]
                        [ span
                            [ class "icon-button"
                            , tabindex 0
                            , onClick
                                (Msg.TopicCardMsg
                                    topic.id
                                    (TopicCard.Trash Operation.Doing)
                                )
                            ]
                            [ Outlined.delete 20 Inherit ]
                        , span
                            [ class "icon-button"
                            , tabindex 0
                            , onClick
                                (Msg.batch
                                    [ Msg.EditTopicPending topic.id
                                    , Msg.ShowPageLayer Page.EditTopicLayer
                                    ]
                                )
                            ]
                            [ Outlined.edit 20 Inherit ]
                        , span
                            [ class "icon-button"
                            , tabindex 0
                            , onClick
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
