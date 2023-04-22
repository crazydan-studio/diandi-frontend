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

import Browser
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Model.App as App
import Msg exposing (Msg)
import View.Page as PageType
import View.Page.Blank
import View.Page.Forbidden
import View.Page.Home
import View.Page.Loading
import View.Page.NotFound
import View.StyleSheet
import Widget.PageLayer as PageLayer exposing (PageLayer)


view :
    PageLayer Model Msg
    -> Model
    -> Browser.Document Msg
view pageLayer ({ app, themeDark } as model) =
    { title = title app
    , body =
        [ div
            [ class "w-full h-full"
            , class "flex flex-col"
            , class
                (if themeDark then
                    "dark"

                 else
                    ""
                )
            ]
            [ div
                [ class "w-full h-full"
                , class "flex"
                , class "bg-gray-100 dark:bg-gray-900"
                ]
                [ page model ]
            , PageLayer.create pageLayer model
            ]
        , View.StyleSheet.create model
        ]
    }


title : App.State -> String
title app =
    case app.currentPage of
        PageType.NotFound ->
            app.title ++ " - " ++ "页面不存在"

        PageType.Forbidden ->
            app.title ++ " - " ++ "无操作权限"

        PageType.Loading ->
            app.title ++ " - " ++ "页面加载中..."

        _ ->
            app.description


page : Model -> Html Msg
page ({ app } as model) =
    case app.currentPage of
        PageType.NotFound ->
            View.Page.NotFound.view model

        PageType.Forbidden ->
            View.Page.Forbidden.view model

        PageType.Loading ->
            View.Page.Loading.view model

        PageType.Blank ->
            View.Page.Blank.view model

        PageType.Home ->
            View.Page.Home.view model
