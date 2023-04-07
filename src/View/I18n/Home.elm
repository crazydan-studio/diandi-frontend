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
        , ok
        )
import View.I18n.Default as Default


buttonText : String
buttonText =
    "Home/Button"


labelText : String
labelText =
    "Home/Label"


text : Lang -> List String -> Element msg
text lang =
    I18n.Element.text lang translate


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
            ok En_US
                "Have any amazing ideas? Get it down right now :)"
                :: default

        [ "请输入关键字查询 ..." ] ->
            ok En_US
                "Please input the keyword for searching ..."
                :: default

        [ "可以在这里添加一个醒目的标题哦 ..." ] ->
            ok En_US
                "You can add a conspicuous title here ..."
                :: default

        _ ->
            default


buttonTranslator : List String -> List ( Lang, TranslateResult )
buttonTranslator texts =
    case texts of
        [ "语言" ] ->
            ok En_US "Language"
                :: default

        [ "记下来！" ] ->
            ok En_US "Got it!"
                :: default

        [ "设置" ] ->
            ok En_US "Settings"
                :: default

        [ "新增" ] ->
            ok En_US "New"
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
        [ "标签：" ] ->
            ok En_US "Tags: "
                :: default

        _ ->
            default
