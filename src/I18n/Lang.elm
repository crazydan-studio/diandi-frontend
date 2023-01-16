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

module I18n.Lang exposing
    ( Lang(..)
    , TextsNeedToBeTranslated
    , TranslateResult(..)
    , all
    , fromString
    , fromStringWithDefault
    , langEnd
    , toString
    )


type Lang
    = Zh_CN
    | En_US
    | Unknown


type TranslateResult
    = Translated String
    | NoNeedsToTranslate (List String)
    | WaitingToTranslate TextsNeedToBeTranslated


type alias TextsNeedToBeTranslated =
    { modules : List String, texts : List String }



-- TODO 支持用户修改、添加国际化


langEnd : List String
langEnd =
    []


all : List ( Lang, String )
all =
    [ ( Zh_CN, "简体中文" )
    , ( En_US, "English" )
    ]


fromString : String -> Lang
fromString str =
    case String.toLower str of
        "zh_cn" ->
            Zh_CN

        "en_us" ->
            En_US

        _ ->
            Unknown


fromStringWithDefault : Lang -> String -> Lang
fromStringWithDefault defaultLang str =
    let
        lng =
            fromString str
    in
    case lng of
        Unknown ->
            defaultLang

        _ ->
            lng


toString : Lang -> String
toString l =
    case l of
        Zh_CN ->
            "zh_CN"

        En_US ->
            "en_US"

        _ ->
            ""
