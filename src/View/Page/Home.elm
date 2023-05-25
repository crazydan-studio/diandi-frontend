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


module View.Page.Home exposing (view)

import App.State as AppState
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Msg exposing (Msg)
import View.Page
import View.Page.Home.Center as Center
import View.Page.Home.Top as Top
import View.Page.Home.TopicTags as Tags


view : Bool -> AppState.State -> Html Msg
view trashed app =
    div
        [ class "w-full h-full"
        , class "flex flex-col"
        ]
        [ Top.view app
        , Tags.view app
        , Center.view trashed app
        ]
