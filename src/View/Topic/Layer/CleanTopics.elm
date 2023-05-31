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


module View.Topic.Layer.CleanTopics exposing (create)

import App.Msg as AppMsg
import App.Operation as Operation
import App.Operation.CleanTopics as CleanTopics exposing (TopicsCleaner)
import App.State as AppState
import Html exposing (Html, button, div, span)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import I18n.Html exposing (textWith)
import I18n.Lang exposing (Lang)
import I18n.Translator exposing (TranslateResult)
import Msg exposing (Msg)
import View.I18n.Home as I18n
import Widget.Loading as Loading
import Widget.Mask as Mask
import Widget.PageLayer as PageLayer


create : PageLayer.PagerId -> AppState.State -> Html Msg
create pagerId { topicsCleaner, lang } =
    topicsCleaner
        |> Maybe.map (doCreate pagerId lang)
        |> Maybe.withDefault blank



-- ------------------------------------------------------------------


blank : Html Msg
blank =
    div [] []


doCreate :
    PageLayer.PagerId
    -> Lang
    -> TopicsCleaner
    -> Html Msg
doCreate pagerId lang { status } =
    let
        i18nText =
            I18n.htmlText lang
    in
    case status of
        Operation.Done ->
            blank

        Operation.Doing ->
            Mask.create
                { show = True
                , styles = [ "top-0", "left-0" ]
                , content =
                    [ Loading.ripple { width = 64, height = 64 }
                    , span
                        []
                        [ [ "正在删除当前查询结果，请稍等片刻 ..." ]
                            |> i18nText
                        ]
                    ]
                }

        Operation.NoOp ->
            confirm pagerId
                lang
                [ [ "当前查询结果将被永久删除，无法恢复，是否继续？" ]
                    |> I18n.translate lang
                ]

        Operation.Error error ->
            confirm pagerId
                lang
                [ [ "操作异常 - " ]
                    |> I18n.translate lang
                , error
                ]


confirm :
    PageLayer.PagerId
    -> Lang
    -> List TranslateResult
    -> Html Msg
confirm pagerId lang tips =
    let
        i18nText =
            I18n.htmlText lang
    in
    div
        [ class "mt-12 p-6"
        , class "w-1/3 h-fit"
        , class "flex flex-col items-stretch justify-center gap-8"
        , class "rounded-md"
        , class "bg-white dark:bg-gray-800"
        ]
        [ span
            [ class "text-center dark:text-white"
            ]
            (tips |> List.map textWith)
        , div
            [ class "flex"
            , class "gap-4 justify-center"
            ]
            [ button
                [ class "tw-primary-btn warning"
                , class "w-full"
                , onClick
                    (Msg.step
                        (Msg.fromApp <|
                            AppMsg.CleanTopicsMsg
                                CleanTopics.CleanDoing
                        )
                        (Msg.batch
                            [ Msg.fromApp <|
                                AppMsg.CleanTopicsMsg
                                    CleanTopics.CleanDone
                            , Msg.pageLayerClose pagerId
                            ]
                        )
                    )
                ]
                [ [ I18n.buttonText
                  , "继续"
                  ]
                    |> i18nText
                ]
            , button
                [ class "tw-normal-btn"
                , class "w-full"
                , onClick
                    (Msg.batch
                        [ Msg.fromApp <|
                            AppMsg.CleanTopicsMsg
                                CleanTopics.CleanCancel
                        , Msg.pageLayerClose pagerId
                        ]
                    )
                ]
                [ [ I18n.buttonText
                  , "取消"
                  ]
                    |> i18nText
                ]
            ]
        ]
