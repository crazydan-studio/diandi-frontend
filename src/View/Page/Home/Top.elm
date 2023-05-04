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


module View.Page.Home.Top exposing (..)

import App.Msg as AppMsg
import App.State as AppState
import Html
    exposing
        ( Html
        , a
        , div
        , img
        , input
        , nav
        , node
        , span
        )
import Html.Attributes
    exposing
        ( attribute
        , class
        , href
        , placeholder
        , src
        , type_
        , value
        )
import Html.Events exposing (onClick, onInput)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Msg exposing (Msg)
import View.I18n.Home as I18n
import Widget.Html exposing (onEnter)


view : AppState.State -> Html Msg
view ({ lang, themeDark } as app) =
    let
        i18nAttr =
            I18n.htmlAttr lang
    in
    nav
        [ class "z-10 w-full min-h-fit shadow-md"
        , class "flex px-4 py-2"
        , class "items-center"
        , class "bg-white dark:bg-gray-800"
        ]
        [ a
            [ href "/"
            ]
            [ img
                [ class "h-10 md:hidden"
                , src "/icon.svg"
                ]
                []
            , img
                [ class "h-10 hidden md:inline"
                , src "/logo.svg"
                ]
                []
            ]
        , div
            [ class "grow"
            , class "flex justify-center"
            , class "capitalize"
            , class "text-gray-600 dark:text-gray-300"
            ]
            [ div
                [ class "relative w-2/5"
                ]
                [ span
                    [ class "absolute inset-y-0 left-0"
                    , class "flex items-center pl-3"
                    , class "text-gray-500 dark:text-gray-300"
                    ]
                    [ Outlined.search 24 Inherit
                    ]
                , input
                    ([ class "w-full"
                     , class "py-1 pl-10 pr-4"
                     , class "text-gray-500 dark:text-gray-300"
                     , class "bg-white dark:bg-gray-800"
                     , class "border-transparent border-b border-gray-600"
                     , class "placeholder-gray-600 dark:placeholder-gray-300"
                     , class "focus:outline-none focus:border-gray-600 dark:focus:border-gray-300"
                     , class "transition duration-300 ease-in-out"
                     , type_ "text"
                     , value (app.topicSearchingText |> Maybe.withDefault "")
                     , onInput
                        (\t ->
                            Msg.fromApp (AppMsg.SearchTopicInputing t)
                        )
                     , onEnter (Msg.fromApp AppMsg.SearchTopic)
                     ]
                        ++ i18nAttr
                            placeholder
                            [ "请输入关键字查询 ..." ]
                    )
                    []
                ]
            ]
        , div
            [ class "flex gap-2"
            ]
            [ node "theme-switcher"
                [ class "tw-icon-btn"
                , attribute "mode"
                    (if themeDark then
                        "dark"

                     else
                        ""
                    )
                , onClick
                    (Msg.fromApp
                        (AppMsg.SwitchToDarkTheme (not themeDark))
                    )
                ]
                [ if themeDark then
                    Outlined.dark_mode 24 Inherit

                  else
                    Outlined.light_mode 24 Inherit
                ]
            , span
                [ class "tw-icon-btn"
                ]
                [ Outlined.menu 24 Inherit ]
            ]
        ]
