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


module I18n.Html exposing (attr, text, textWith)

import Html exposing (Attribute, Html)
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
    -> Html msg
text lang translate texts =
    translate lang texts
        |> textWith


attr :
    Lang
    -> (Lang -> List String -> TranslateResult)
    -> (String -> Attribute msg)
    -> List String
    -> List (Attribute msg)
attr lang translate attr_ texts =
    case translate lang texts of
        Translated r ->
            [ attr_ r ]

        WaitingToTranslate r ->
            attr_ (textsToString r.texts)
                :: noTransAttrs r.lang r.modules


textWith : TranslateResult -> Html msg
textWith result =
    case result of
        Translated r ->
            Html.text r

        WaitingToTranslate r ->
            -- 记录未做国际化的内容信息，便于通过js做统一展示处理
            Html.span
                (noTransAttrs r.lang r.modules)
                [ Html.text (textsToString r.texts) ]


noTransAttrs : Lang -> List String -> List (Attribute msg)
noTransAttrs lang modules =
    [ HtmlAttr.attribute "i18n-not-translated" "true"
    , HtmlAttr.attribute
        "i18n-not-translated-lang"
        (Lang.toString lang)
    , HtmlAttr.attribute
        "i18n-not-translated-modules"
        (modulesToString modules)
    ]
