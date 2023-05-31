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


module View.Page.DataLoading exposing
    ( noDataView
    , noDataViewWith
    , view
    )

import App.Store.Data as StoreData
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import I18n.Html exposing (textWith)
import I18n.Lang exposing (Lang)
import I18n.Translator exposing (TranslateResult)
import View.I18n.DataLoading as I18n


view :
    { lang : Lang
    }
    -> (a -> Html msg)
    -> StoreData.Status a
    -> Html msg
view { lang } dataView dataStatus =
    case dataStatus of
        StoreData.LoadWaiting ->
            errorView
                ([ "数据未加载" ] |> I18n.htmlText lang)

        StoreData.Loading ->
            errorView
                ([ "数据加载中，请稍候..." ] |> I18n.htmlText lang)

        StoreData.Loaded data ->
            dataView data

        StoreData.LoadingError error ->
            errorView (error |> textWith)


noDataView :
    TranslateResult
    -> Html msg
noDataView info =
    errorView (info |> textWith)


noDataViewWith :
    String
    -> Html msg
noDataViewWith info =
    errorView (text info)



-- -------------------------------------------------


errorView :
    Html msg
    -> Html msg
errorView errorText =
    div
        [ class "pt-4 w-full"
        , class "flex"
        , class "items-center justify-center"
        , class "text-gray-500 dark:text-gray-300"
        ]
        [ errorText ]
