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


module View.Page.Layer.TopicEditor exposing (create)

import Html exposing (Html, button, div, input, span, text)
import Html.Attributes exposing (class, id, placeholder, value)
import Html.Events exposing (onBlur, onClick, onInput)
import I18n.I18n exposing (langTextEnd)
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
        [ class "self-center mt-8"
        , class "flex flex-col w-3/4 px-3 py-3"
        , class "rounded-md bg-white dark:bg-gray-800"
        , class "gap-2"
        ]
        [ input
            ([ class "px-4 py-2 text-gray-700 bg-white border rounded-md dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 focus:border-blue-400 dark:focus:border-blue-300 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-40"
             , value title
             , onInput config.onTitleChange
             ]
                ++ i18nAttr
                    placeholder
                    ("可以在这里添加一个醒目的标题哦 ..." :: langTextEnd)
            )
            []
        , Markdown.editor
            { value = content
            , styles = [ "rounded-md", "border", "dark:border-gray-600" ]
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
                                [ class "flex gap-1 px-2 py-1"
                                , class "rounded-full font-bold"
                                , class "text-white dark:text-gray-300 dark:hover:text-gray-200"
                                , class "bg-sky-700 hover:bg-sky-600"
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
                 , class "px-4 py-2 text-gray-700 bg-white border rounded-md dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 focus:border-blue-400 dark:focus:border-blue-300 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-40"
                 , value taging
                 , onInput config.onTagChange
                 , onEnter config.onTagDone
                 , onBlur config.onTagDone
                 ]
                    ++ i18nAttr
                        placeholder
                        ("请输入标签名称，并按回车确认" :: langTextEnd)
                )
                []
            ]
        , div
            [ class "mt-4 flex"
            , class "gap-4 justify-end"
            ]
            [ button
                [ class "px-4 w-full py-2.5 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-blue-600 rounded-md hover:bg-blue-500 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-40"
                , onClick config.onEditDone
                ]
                [ I18n.buttonText
                    :: (if config.isNew then
                            "记下来！"

                        else
                            "保存"
                       )
                    :: langTextEnd
                    |> i18nText
                ]
            , button
                [ class "px-4 w-full py-2.5 text-sm font-medium dark:text-gray-200 dark:border-gray-700 dark:hover:bg-gray-800 tracking-wide text-gray-700 capitalize transition-colors duration-300 transform border border-gray-200 rounded-md hover:bg-gray-100 focus:outline-none focus:ring focus:ring-gray-300 focus:ring-opacity-40"
                , onClick config.onEditCanceled
                ]
                [ I18n.buttonText
                    :: "取消"
                    :: langTextEnd
                    |> i18nText
                ]
            ]
        ]
