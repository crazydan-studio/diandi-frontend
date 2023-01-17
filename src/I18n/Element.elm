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


module I18n.Element exposing (text, textWithResult)

{-| Elm UI国际化支持

主要目的是将国际化结果直接转换为Elm UI元素，
并对未国际化的内容在元素的属性上做标记，
以便于统一展示未国际化内容

-}

import Element exposing (Attribute, Element)
import Html.Attributes as HtmlAttr
import I18n.Helper exposing (joinI18nModules, joinI18nTexts)
import I18n.Lang
    exposing
        ( Lang
        , TranslateResult(..)
        )


text :
    (Lang -> List String -> TranslateResult)
    -> Lang
    -> List String
    -> Element msg
text translator langType texts =
    translator langType texts
        |> textWithResult


textWithResult : TranslateResult -> Element msg
textWithResult translateResult =
    case translateResult of
        Translated result ->
            Element.text result

        NoNeedsToTranslate result ->
            Element.text (joinI18nTexts result)

        WaitingToTranslate result ->
            -- 记录未做国际化的内容信息，便于通过js做统一展示处理
            Element.el
                (noTransAttrs result.modules)
                (Element.text (joinI18nTexts result.texts))


noTransAttrs : List String -> List (Attribute msg)
noTransAttrs modules =
    [ HtmlAttr.attribute "i18n-not-translated" "true"
        |> Element.htmlAttribute
    , HtmlAttr.attribute
        "i18n-not-translated-modules"
        (joinI18nModules modules)
        |> Element.htmlAttribute
    ]
