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


module View.Topic.Layer.TopicEditor exposing (create)

import Html exposing (Html, button, div, input, span, text)
import Html.Attributes exposing (class, id, placeholder, value)
import Html.Events exposing (onBlur, onClick, onInput)
import I18n.Html exposing (textWith)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Model
import Model.Error as Error
import Model.Operation.EditTopic exposing (EditTopic)
import Msg
import View.I18n.Home as I18n
import Widget.Bytemd as Markdown
import Widget.Html exposing (onEnter)
import Widget.Loading as Loading
import Widget.Mask as Mask
import Widget.Util.Basic exposing (fromMaybe)


type alias Config msg =
    { isNew : Bool
    , topic : Maybe EditTopic
    , onTitleChange : String -> msg
    , onContentChange : String -> msg
    , onTagDeleted : String -> msg
    , onTagDone : msg
    , onTagChange : String -> msg
    , onEditDone : msg
    , onEditCanceled : msg
    }


create : Config Msg.Msg -> Model.State -> Html Msg.Msg
create config { app, withI18nHtml } =
    let
        i18nText =
            withI18nHtml I18n.htmlText

        i18nAttr =
            I18n.htmlAttr app.lang

        title =
            config.topic |> fromMaybe "" .title

        content =
            config.topic |> fromMaybe "" .content

        tags =
            config.topic |> fromMaybe [] .tags

        taging =
            config.topic |> fromMaybe "" .taging

        updating =
            config.topic |> fromMaybe False .updating

        error =
            config.topic |> fromMaybe Error.none .error
    in
    div
        [ class "mt-8"
        , class "flex flex-col w-3/4 h-3/4 px-3 py-3"
        , class "rounded-md"
        , class "bg-white dark:bg-gray-800"
        , class "gap-2"
        ]
        [ Mask.create
            { show = updating
            , styles = [ "top-0", "left-0" ]
            , content =
                [ Loading.ripple { width = 64, height = 64 }
                , span
                    []
                    [ [ "数据正在保存中，请稍等片刻 ..." ]
                        |> i18nText
                    ]
                ]
            }
        , input
            ([ class "tw-text-input"
             , value title
             , onInput config.onTitleChange
             ]
                ++ i18nAttr
                    placeholder
                    [ "可以在这里添加一个醒目的标题哦 ..." ]
            )
            []
        , Markdown.editor
            { value = content
            , styles =
                [ "rounded-md"
                , "border"
                , "dark:border-gray-600"
                ]
            , mode = Markdown.Auto
            , lang = app.lang
            , placeholder = "又有什么奇妙的想法呢？赶紧记下来吧 :)"
            , onChange = Just config.onContentChange
            }
        , div
            [ class "flex flex-col"
            , class "gap-2"
            ]
            [ div
                [ class "flex flex-wrap"
                , class "items-center gap-2"
                ]
                (tags
                    |> List.map
                        (\tag ->
                            div
                                [ class "flex gap-1 px-2 py-0.5 items-center"
                                , class "rounded-full"
                                , class "text-sm font-bold"
                                , class "text-gray-600 hover:text-gray-500 dark:text-gray-400 dark:hover:text-gray-300"
                                , class "bg-slate-200 hover:bg-slate-300 dark:bg-slate-700 dark:hover:bg-slate-600"
                                , class "transition-colors duration-300"
                                ]
                                [ span [] [ text ("#" ++ tag) ]
                                , span
                                    [ class "cursor-pointer"
                                    , onClick (config.onTagDeleted tag)
                                    ]
                                    [ Outlined.highlight_off 16 Inherit ]
                                ]
                        )
                )
            , input
                ([ id app.topicTagEditInputId
                 , class "tw-text-input"
                 , value taging
                 , onInput config.onTagChange
                 , onEnter config.onTagDone
                 , onBlur config.onTagDone
                 ]
                    ++ i18nAttr
                        placeholder
                        [ "请输入标签名称，并按回车确认" ]
                )
                []
            ]
        , case error of
            Error.Error e ->
                div
                    [ class "text-sm"
                    , class "whitespace-pre-wrap"
                    , class "text-red-500 dark:text-red-600"
                    ]
                    [ text "* "
                    , textWith e
                    ]

            Error.Info e ->
                div
                    [ class "text-sm"
                    , class "whitespace-pre-wrap"
                    , class "text-green-600 dark:text-green-500"
                    ]
                    [ text "* "
                    , textWith e
                    ]

            _ ->
                div [] []
        , div
            [ class "mt-4 flex"
            , class "gap-4 justify-end"
            ]
            [ button
                [ class "tw-primary-btn"
                , class "w-full"
                , onClick config.onEditDone
                ]
                [ [ I18n.buttonText
                  , if config.isNew then
                        "记下来！"

                    else
                        "保存"
                  ]
                    |> i18nText
                ]
            , button
                [ class "tw-secondary-btn"
                , class "w-full"
                , onClick config.onEditCanceled
                ]
                [ [ I18n.buttonText
                  , "取消"
                  ]
                    |> i18nText
                ]
            ]
        ]
