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


module View.App exposing (view)

import App.State as AppState
import Browser
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Msg exposing (Msg)
import View.Page as Page
import View.Page.Blank
import View.Page.Forbidden
import View.Page.Home
import View.Page.Loading
import View.Page.NotFound
import View.StyleSheet
import Widget.PageLayer as PageLayer


view :
    PageLayer.State AppState.State Msg
    -> AppState.State
    -> Browser.Document Msg
view pageLayer app =
    { title = createTitle app
    , body =
        [ div
            [ class "w-full h-full"
            , class "flex flex-col"
            ]
            [ div
                [ class "w-full h-full"
                , class "flex"
                , class "bg-gray-100 dark:bg-gray-900"
                ]
                [ createPage app ]
            , PageLayer.create pageLayer app
            ]
        , View.StyleSheet.create app
        ]
    }


createTitle : AppState.State -> String
createTitle { currentPage, title, description } =
    case currentPage of
        Page.NotFound ->
            title ++ " - " ++ "页面不存在"

        Page.Forbidden ->
            title ++ " - " ++ "无操作权限"

        Page.Loading ->
            title ++ " - " ++ "页面加载中..."

        _ ->
            description


createPage : AppState.State -> Html Msg
createPage app =
    case app.currentPage of
        Page.NotFound ->
            View.Page.NotFound.view app

        Page.Forbidden ->
            View.Page.Forbidden.view app

        Page.Loading ->
            View.Page.Loading.view app

        Page.Blank ->
            View.Page.Blank.view app

        Page.Home ->
            View.Page.Home.view app
