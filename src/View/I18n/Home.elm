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
    ( btnModule
    , labelModule
    , text
    )

import Element exposing (Element)
import I18n.Element
import I18n.Helper exposing (translateWaiting)
import I18n.Lang
    exposing
        ( Lang(..)
        , TranslateResult(..)
        )
import View.I18n.Default


text : Lang -> List String -> Element msg
text =
    I18n.Element.text translator


rootModule : String
rootModule =
    "Home"


btnModule : String
btnModule =
    "Btn"


labelModule : String
labelModule =
    "Label"


getTranslatorBySubModule :
    String
    -> List ( String, t )
    -> Maybe t
getTranslatorBySubModule subModule translators =
    translators
        |> List.foldl
            (\( m, t ) r ->
                if r == Nothing && m == subModule then
                    Just t

                else
                    r
            )
            Nothing


translator : Lang -> List String -> TranslateResult
translator langType texts =
    let
        translateDefault subModules =
            View.I18n.Default.translator
                langType
                (rootModule :: subModules)
    in
    case texts of
        [ "又有什么奇妙的想法呢？赶紧记下来吧 :)" ] ->
            case langType of
                En_US ->
                    Translated
                        "Have any amazing ideas? Git it down right now :)"

                _ ->
                    translateDefault [] texts

        [ "这里是类别描述信息" ] ->
            case langType of
                En_US ->
                    Translated
                        "Here is the description for the category"

                _ ->
                    translateDefault [] texts

        [ "这里是主题详情展示页，默认显示当前分类的信息" ] ->
            case langType of
                En_US ->
                    Translated
                        "Here is the details page for the topic, it will default show the information of the category"

                _ ->
                    translateDefault [] texts

        [ "待办" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("TODO (" ++ n ++ ")")

                _ ->
                    translateDefault [] [ t, " (", n, ")" ]

        [ "知识" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("Knowledge (" ++ n ++ ")")

                _ ->
                    translateDefault [] [ t, " (", n, ")" ]

        [ "疑问" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("Question (" ++ n ++ ")")

                _ ->
                    translateDefault [] [ t, " (", n, ")" ]

        -- 处理子模块的国际化
        i18nSubModule :: actualTexts ->
            let
                translatorMaybe =
                    [ ( btnModule, btnTranslator )
                    , ( labelModule, labelTranslator )
                    ]
                        |> getTranslatorBySubModule i18nSubModule
            in
            case translatorMaybe of
                Just t ->
                    t langType
                        translateDefault
                        [ rootModule, i18nSubModule ]
                        actualTexts

                Nothing ->
                    translateWaiting [ rootModule ] texts

        _ ->
            translateWaiting [ rootModule ] texts


btnTranslator :
    Lang
    -> (List String -> List String -> TranslateResult)
    -> List String
    -> List String
    -> TranslateResult
btnTranslator langType i18nDefault modules texts =
    case texts of
        [ "实时预览" ] ->
            case langType of
                En_US ->
                    Translated
                        "Live Preview"

                _ ->
                    i18nDefault [] texts

        [ "语言" ] ->
            case langType of
                En_US ->
                    Translated
                        "Language"

                _ ->
                    i18nDefault [] texts

        [ "记下来!" ] ->
            case langType of
                En_US ->
                    Translated
                        "Got it!"

                _ ->
                    i18nDefault [] texts

        [ "设置" ] ->
            case langType of
                En_US ->
                    Translated
                        "Settings"

                _ ->
                    i18nDefault [] texts

        _ ->
            translateWaiting modules texts


labelTranslator :
    Lang
    -> (List String -> List String -> TranslateResult)
    -> List String
    -> List String
    -> TranslateResult
labelTranslator langType i18nDefault modules texts =
    case texts of
        [ "分类：" ] ->
            case langType of
                En_US ->
                    Translated
                        "Category: "

                _ ->
                    i18nDefault [] texts

        [ "标签：" ] ->
            case langType of
                En_US ->
                    Translated
                        "Tags: "

                _ ->
                    i18nDefault [] texts

        _ ->
            translateWaiting modules texts
