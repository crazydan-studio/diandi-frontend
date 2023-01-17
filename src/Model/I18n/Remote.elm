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


module Model.I18n.Remote exposing (translator)

import I18n.Helper exposing (translateWaiting, translateWaitingByLang)
import I18n.Lang exposing (Lang(..), TranslateResult(..))


translator : Lang -> List String -> TranslateResult
translator langType texts =
    let
        i18nDefault =
            translateWaitingByLang
                { default = Zh_CN
                , current = langType
                }
                []
    in
    case texts of
        [ "用户未登录" ] ->
            case langType of
                En_US ->
                    Translated "The user is not authorized"

                _ ->
                    i18nDefault texts

        [ "请求未授权" ] ->
            case langType of
                En_US ->
                    Translated "The request is not permitted"

                _ ->
                    i18nDefault texts

        [ "请求URL不存在" ] ->
            case langType of
                En_US ->
                    Translated "The URL doesn't exist"

                _ ->
                    i18nDefault texts

        [ "异常请求状态码：", code ] ->
            case langType of
                En_US ->
                    Translated ("Error request code: " ++ code)

                _ ->
                    i18nDefault texts

        [ "网络请求超时，请稍后再试" ] ->
            case langType of
                En_US ->
                    Translated "Request timeout, please try it later"

                _ ->
                    i18nDefault texts

        [ "网络连接异常，请稍后再试" ] ->
            case langType of
                En_US ->
                    Translated "Network connection failed, please try it later"

                _ ->
                    i18nDefault texts

        [ "未知异常" ] ->
            case langType of
                En_US ->
                    Translated "Unknown error"

                _ ->
                    i18nDefault texts

        _ ->
            translateWaiting [] texts
