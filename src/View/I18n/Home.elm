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


module View.I18n.Home exposing
    ( buttonText
    , labelText
    , text
    , translate
    )

import Element exposing (Element)
import I18n.Element
import I18n.Lang exposing (Lang(..))
import I18n.Translator as Translator
    exposing
        ( TranslateResult
        , default
        , defaultWith
        , ok
        )
import View.I18n.Default as Default


buttonText : String
buttonText =
    "Button"


labelText : String
labelText =
    "Label"


text : Lang -> List String -> Element msg
text =
    I18n.Element.text translate


translate : Lang -> List String -> TranslateResult
translate lang texts =
    Translator.translate Default.lang lang texts <|
        [ ( [ buttonText ], buttonTranslator )
        , ( [ labelText ], labelTranslator )
        , ( [], rootTranslator )
        ]


rootTranslator : List String -> List ( Lang, TranslateResult )
rootTranslator texts =
    case texts of
        [ "又有什么奇妙的想法呢？赶紧记下来吧 :)" ] ->
            ok En_US "Have any amazing ideas? Git it down right now :)"
                :: default

        [ "这里是类别描述信息" ] ->
            ok En_US "Here is the description for the category"
                :: default

        [ "这里是主题详情展示页，默认显示当前分类的信息" ] ->
            ok En_US
                ("Here is the details page for the topic"
                    ++ ", it will default show the information of the category"
                )
                :: default

        [ "点击这里添加描述信息" ] ->
            ok En_US "Click here to add description for the category"
                :: default

        [ "待办" as t, n ] ->
            ok En_US ("TODO (" ++ n ++ ")")
                :: defaultWith [ t, " (", n, ")" ]

        [ "知识" as t, n ] ->
            ok En_US ("Knowledge (" ++ n ++ ")")
                :: defaultWith [ t, " (", n, ")" ]

        [ "疑问" as t, n ] ->
            ok En_US ("Question (" ++ n ++ ")")
                :: defaultWith [ t, " (", n, ")" ]

        _ ->
            default


buttonTranslator : List String -> List ( Lang, TranslateResult )
buttonTranslator texts =
    case texts of
        [ "实时预览" ] ->
            ok En_US "Live Preview"
                :: default

        [ "语言" ] ->
            ok En_US "Language"
                :: default

        [ "记下来!" ] ->
            ok En_US "Got it!"
                :: default

        [ "设置" ] ->
            ok En_US "Settings"
                :: default

        [ "阅读模式" ] ->
            ok En_US "Reading Mode"
                :: default

        [ "搜索" ] ->
            ok En_US "Search"
                :: default

        [ "编辑" ] ->
            ok En_US "Edit"
                :: default

        [ "确定" ] ->
            ok En_US "OK"
                :: default

        [ "取消" ] ->
            ok En_US "Cancel"
                :: default

        _ ->
            default


labelTranslator : List String -> List ( Lang, TranslateResult )
labelTranslator texts =
    case texts of
        [ "分类：" ] ->
            ok En_US "Category: "
                :: default

        [ "标签：" ] ->
            ok En_US "Tags: "
                :: default

        _ ->
            default
