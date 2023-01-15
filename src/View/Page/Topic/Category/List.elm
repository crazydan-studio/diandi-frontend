module View.Page.Topic.Category.List exposing (view)

import Data.TreeStore
import Element exposing (..)
import Element.Keyed
import Element.Lazy
import Model
import Model.Topic.Category exposing (Category)
import Msg
import Style.Default
import View.Page.RemoteData


view : Model.State -> Element Msg.Msg
view { app } =
    View.Page.RemoteData.view
        app.theme
        categoryListView
        app.categories



-- ---------------------------------------------------


categoryListView : Data.TreeStore.Tree Category -> Element Msg.Msg
categoryListView categories =
    Element.Keyed.column
        [ width fill
        , height fill
        , paddingEach { top = 0, left = 0, right = 0, bottom = 16 }
        ]
        (categories
            |> Data.TreeStore.traverse
                (\{ depth } category childElements ->
                    ( category.id
                    , Element.Lazy.lazy3 categoryView depth category childElements
                    )
                )
        )


categoryView :
    Int
    -> Category
    -> List ( String, Element Msg.Msg )
    -> Element Msg.Msg
categoryView depth category childElements =
    column
        [ width fill
        ]
        [ row
            (Style.Default.boundaryBorderEach
                { top = 0
                , right = 0
                , bottom = 1
                , left = 0
                }
                ++ [ width fill
                   , height (px 64)
                   , paddingEach
                        { top = 0
                        , left = depth * 16
                        , right = 16
                        , bottom = 0
                        }
                   , pointer
                   ]
            )
            [ el [ alignLeft ] (text category.name)
            ]

        -- 子分类
        -- TODO 在父分类右侧放置展开按钮，点击后，显示其下子分类
        , Element.Keyed.column
            [ width fill ]
            childElements
        ]
