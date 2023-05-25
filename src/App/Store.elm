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


module App.Store exposing (parseError)

import Http
import I18n.Lang exposing (Lang)
import I18n.Translator exposing (TranslateResult)
import App.I18n.Remote as I18n


parseError : Lang -> Http.Error -> TranslateResult
parseError lang error =
    case error of
        Http.BadStatus status ->
            (case status of
                400 ->
                    [ "Bad Request" ]

                401 ->
                    [ "用户未登录" ]

                403 ->
                    [ "请求未授权" ]

                404 ->
                    [ "请求URL不存在" ]

                405 ->
                    [ "Method Not Allowed" ]

                413 ->
                    [ "Payload Too Large" ]

                500 ->
                    [ "Internal Server Error" ]

                502 ->
                    [ "Bad Gateway" ]

                503 ->
                    [ "Service Unavailable" ]

                504 ->
                    [ "Gateway Timeout" ]

                _ ->
                    [ "[", String.fromInt status, "] 请求异常" ]
            )
                |> I18n.translate lang

        Http.Timeout ->
            [ "网络请求超时，请稍后再试" ] |> I18n.translate lang

        Http.NetworkError ->
            [ "网络连接异常，请稍后再试" ] |> I18n.translate lang

        Http.BadBody msg ->
            [ msg ] |> I18n.translate lang

        _ ->
            [ "未知异常" ] |> I18n.translate lang
