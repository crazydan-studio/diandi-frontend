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


module View.Page.RemoteData exposing
    ( noDataView
    , noDataViewWith
    , view
    )

import Element exposing (..)
import Element.Font as Font
import I18n.Lang exposing (Lang, langEnd)
import Model.Remote.Data as RemoteData
import Theme.Theme exposing (Theme)
import View.I18n.RemoteData as I18n


view :
    { theme : Theme msg
    , lang : Lang
    }
    -> (a -> Element msg)
    -> RemoteData.Status a
    -> Element msg
view { theme, lang } dataView dataStatus =
    case dataStatus of
        RemoteData.LoadWaiting ->
            errorView theme
                ("数据未加载" :: langEnd |> I18n.text lang)

        RemoteData.Loading ->
            errorView theme
                ("数据加载中，请稍候..." :: langEnd |> I18n.text lang)

        RemoteData.Loaded data ->
            dataView data

        RemoteData.LoadingError error ->
            errorView theme (error |> I18n.textWithResult)


noDataView :
    { theme : Theme msg
    , lang : Lang
    }
    -> Element msg
noDataView { theme, lang } =
    errorView theme
        ("数据已加载，但结果为空" :: langEnd |> I18n.text lang)


noDataViewWith :
    Theme msg
    -> String
    -> Element msg
noDataViewWith theme error =
    errorView theme (text error)



-- -------------------------------------------------


errorView :
    Theme msg
    -> Element msg
    -> Element msg
errorView theme errorText =
    column
        [ width fill
        , height fill
        , paddingXY 8 16
        ]
        [ paragraph
            ([ centerX
             , Font.center
             ]
                ++ theme.placeholderFont
            )
            [ errorText ]
        ]
