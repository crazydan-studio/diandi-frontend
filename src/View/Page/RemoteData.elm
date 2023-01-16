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

module View.Page.RemoteData exposing (view)

import Element exposing (..)
import Element.Font as Font
import Model.Remote.Data as RemoteData
import Theme.Theme


view : Theme.Theme.Theme -> (a -> Element msg) -> RemoteData.Status a -> Element msg
view theme dataView dataStatus =
    case dataStatus of
        RemoteData.LoadWaiting ->
            errorView theme "数据未加载"

        RemoteData.Loading ->
            errorView theme "数据加载中，请稍候..."

        RemoteData.Loaded data ->
            dataView data

        RemoteData.LoadingError error ->
            errorView theme error



-- -------------------------------------------------


errorView : Theme.Theme.Theme -> String -> Element msg
errorView theme error =
    column
        [ width fill
        , height fill
        , paddingXY 8 16
        ]
        [ paragraph
            ([ centerX
             , Font.center
             ]
                ++ Theme.Theme.placeholderFont theme
            )
            [ text error ]
        ]
