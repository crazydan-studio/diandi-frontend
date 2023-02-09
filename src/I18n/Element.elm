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


module I18n.Element exposing (text, textWith)

{-| Elm UI国际化支持

主要目的是将国际化结果直接转换为Elm UI元素，
并对未国际化的内容在元素的属性上做标记，
以便于统一展示未国际化内容

-}

import Element exposing (Attribute, Element)
import Html.Attributes as HtmlAttr
import I18n.Lang as Lang exposing (Lang)
import I18n.Translator
    exposing
        ( TranslateResult(..)
        , modulesToString
        , textsToString
        )


text :
    Lang
    -> (Lang -> List String -> TranslateResult)
    -> List String
    -> Element msg
text lang translate texts =
    translate lang texts
        |> textWith


textWith : TranslateResult -> Element msg
textWith result =
    case result of
        Translated r ->
            Element.text r

        WaitingToTranslate r ->
            -- 记录未做国际化的内容信息，便于通过js做统一展示处理
            Element.el
                (noTransAttrs r.lang r.modules)
                (Element.text (textsToString r.texts))


noTransAttrs : Lang -> List String -> List (Attribute msg)
noTransAttrs lang modules =
    [ HtmlAttr.attribute "i18n-not-translated" "true"
        |> Element.htmlAttribute
    , HtmlAttr.attribute
        "i18n-not-translated-lang"
        (Lang.toString lang)
        |> Element.htmlAttribute
    , HtmlAttr.attribute
        "i18n-not-translated-modules"
        (modulesToString modules)
        |> Element.htmlAttribute
    ]
