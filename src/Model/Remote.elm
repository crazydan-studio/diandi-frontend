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


module Model.Remote exposing (parseError)

import Http
import I18n.I18n exposing (textEnd)
import I18n.Lang exposing (Lang)
import I18n.Translator exposing (TranslateResult)
import Model.I18n.Remote as I18n


parseError : Lang -> Http.Error -> TranslateResult
parseError lang error =
    case error of
        Http.BadStatus status ->
            if status == 401 then
                "用户未登录" :: textEnd |> I18n.translate lang

            else if status == 403 then
                "请求未授权" :: textEnd |> I18n.translate lang

            else if status == 404 then
                "请求URL不存在" :: textEnd |> I18n.translate lang

            else
                ("异常请求状态码：" :: String.fromInt status :: textEnd)
                    |> I18n.translate lang

        Http.Timeout ->
            "网络请求超时，请稍后再试" :: textEnd |> I18n.translate lang

        Http.NetworkError ->
            "网络连接异常，请稍后再试" :: textEnd |> I18n.translate lang

        _ ->
            "未知异常" :: textEnd |> I18n.translate lang
