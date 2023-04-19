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

import Html
    exposing
        ( Html
        , a
        , div
        , img
        , input
        , nav
        , span
        )
import Html.Attributes
    exposing
        ( class
        , href
        , placeholder
        , src
        , type_
        , value
        )
import Html.Events exposing (onClick, onInput)
import I18n.I18n exposing (langTextEnd)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Model
import Msg
import View.I18n.Home as I18n
import Widget.Html exposing (onEnter)


view : Model.State -> Html Msg.Msg
view ({ app, themeDark, withI18nHtml } as state) =
    let
        i18nAttr =
            I18n.htmlAttr app.lang
    in
    nav
        [ class "z-10 w-full shadow-md bg-white dark:bg-gray-800"
        ]
        [ div
            [ class "flex items-center px-4 py-2"
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
                [ class "flex-1 flex flex-row justify-center text-gray-600 capitalize dark:text-gray-300"
                ]
                [ div
                    [ class "relative"
                    ]
                    [ span
                        [ class "absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500 dark:text-gray-300"
                        ]
                        [ Outlined.search 24 Inherit
                        ]
                    , input
                        ([ class "w-48 py-1 pl-10 pr-4 transition duration-300 ease-in-out text-gray-500 placeholder-gray-600 bg-white border-transparent border-b border-gray-600 dark:placeholder-gray-300 dark:focus:border-gray-300 dark:bg-gray-800 dark:text-gray-300 focus:outline-none focus:border-gray-600"
                         , type_ "text"
                         , value (app.topicSearchingText |> Maybe.withDefault "")
                         , onInput Msg.SearchTopicInputing
                         , onEnter Msg.SearchTopic
                         ]
                            ++ i18nAttr
                                placeholder
                                ("请输入关键字查询 ..." :: langTextEnd)
                        )
                        []
                    ]
                ]
            , div
                [ class "flex gap-2"
                ]
                [ span
                    [ class "icon-button"
                    , onClick (Msg.SwitchToDarkTheme (not themeDark))
                    ]
                    [ if themeDark then
                        Outlined.light_mode 24 Inherit

                      else
                        Outlined.dark_mode 24 Inherit
                    ]
                , span
                    [ class "icon-button"
                    ]
                    [ Outlined.menu 24 Inherit ]
                ]
            ]
        ]
