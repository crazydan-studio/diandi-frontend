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
    , htmlAttr
    , htmlText
    , labelText
    , translate
    )

import Html exposing (Attribute, Html)
import I18n.Html
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


htmlText : Lang -> List String -> Html msg
htmlText lang =
    I18n.Html.text lang translate


htmlAttr :
    Lang
    -> (String -> Attribute msg)
    -> List String
    -> List (Attribute msg)
htmlAttr lang attr_ =
    I18n.Html.attr lang translate attr_


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
                "Searching ..."
                :: default

        [ "可以在这里添加一个醒目的标题哦 ..." ] ->
            ok En_US
                "You can add a conspicuous title here ..."
                :: default

        [ "数据正在移除中，请稍等片刻 ..." ] ->
            ok En_US
                "The data is removing, please wait a minute ..."
                :: default

        [ "数据正在保存中，请稍等片刻 ..." ] ->
            ok En_US
                "The data is saving, please wait a minute ..."
                :: default

        [ "无标题" ] ->
            ok En_US
                "No Title"
                :: default

        [ "* 删除失败 - " ] ->
            ok En_US
                "* Removing failed - "
                :: default

        _ ->
            default


buttonTranslator : List String -> List ( Lang, TranslateResult )
buttonTranslator texts =
    case texts of
        [ "语言" ] ->
            ok En_US "Language"
                :: default

        [ "保存" ] ->
            ok En_US "Save"
                :: default

        [ "保存并继续" ] ->
            ok En_US "Save & Continue"
                :: default

        [ "设置" ] ->
            ok En_US "Settings"
                :: default

        [ "新增" ] ->
            ok En_US "Add"
                :: default

        [ "新增并继续" ] ->
            ok En_US "Add & Continue"
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
