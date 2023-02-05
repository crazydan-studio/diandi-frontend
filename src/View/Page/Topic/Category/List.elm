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


module View.Page.Topic.Category.List exposing (view)

import Data.TreeStore exposing (TreeStore)
import Element exposing (..)
import Element.Background as Background
import Element.Events exposing (onClick)
import Element.Keyed
import Element.Lazy
import Element.Transition as Transition
import Model
import Model.Topic.Category exposing (Category)
import Msg exposing (Msg(..))
import Theme.Theme exposing (Theme)
import View.Page.RemoteData as RemoteDataPage
import View.Style.Base as BaseStyle
import Widget.Dimension as Dimension


view : Model.State -> Element Msg.Msg
view { app, theme } =
    app.categories
        |> RemoteDataPage.view
            { theme = theme
            , lang = app.lang
            }
            (categoryListView
                { selected = app.selectedTopicCategory
                , theme = theme
                }
            )



-- ---------------------------------------------------


categoryListView :
    { selected : Maybe String
    , theme : Theme Msg.Msg
    }
    -> TreeStore Category
    -> Element Msg.Msg
categoryListView { selected, theme } categories =
    Element.Keyed.column
        [ width fill
        , height fill
        , paddingEach
            (Dimension.bottom BaseStyle.spacing2x)
        ]
        (categories
            |> Data.TreeStore.traverse
                (\{ depth } category childElements ->
                    ( category.id
                    , Element.Lazy.lazy2 categoryView
                        { depth = depth
                        , category = category
                        , selected =
                            selected
                                |> Maybe.map (\id -> id == category.id)
                                |> Maybe.withDefault False
                        , theme = theme
                        }
                        childElements
                    )
                )
        )


categoryView :
    { depth : Int
    , category : Category
    , selected : Bool
    , theme : Theme Msg.Msg
    }
    -> List ( String, Element Msg.Msg )
    -> Element Msg.Msg
categoryView { depth, category, selected, theme } childElements =
    let
        categoryHeight =
            32

        cagegoryPaddingY =
            8

        cagegoryPaddingX =
            16
    in
    column
        [ width fill
        ]
        [ row
            -- https://v4.mui.com/components/lists/#simple-list
            ([ width fill
             , height (px (categoryHeight + cagegoryPaddingY * 2))
             , paddingEach
                { top = cagegoryPaddingY
                , left = depth * cagegoryPaddingX
                , right = cagegoryPaddingX
                , bottom = cagegoryPaddingY
                }
             , pointer
             , Transition.with
                [ Transition.property "background-color"
                    [ Transition.duration 0.15
                    , Transition.delay 0
                    , Transition.cubic 0.4 0 0.2 1
                    ]
                ]
             , mouseOver
                [ Background.color (rgba255 0 0 0 0.04)
                ]
             , onClick (ShowTopicsList category.id)
             ]
                ++ (if selected then
                        theme.primaryGreyBackground

                    else
                        []
                   )
            )
            [ el [ alignLeft ] (text category.name)
            ]

        -- 子分类
        -- TODO 在父分类右侧放置展开按钮，点击后，显示其下子分类
        , Element.Keyed.column
            [ width fill ]
            childElements
        ]
