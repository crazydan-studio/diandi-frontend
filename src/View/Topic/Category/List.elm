module View.Topic.Category.List exposing (create)

import Data.TreeStore
import Element exposing (..)
import Element.Keyed
import Element.Lazy
import Model.Root exposing (RemoteData(..), RootModel)
import Model.Topic.Category exposing (Category)
import Msg exposing (RootMsg)
import Style.Default


create : RootModel -> Element RootMsg
create model =
    case model.categories of
        DataLoaded categories ->
            categoryListView categories

        DataLoading ->
            text "数据加载中，请稍候..."

        DataLoadingError error ->
            text error



-- ---------------------------------------------------


categoryListView : Data.TreeStore.Tree Category -> Element RootMsg
categoryListView categories =
    Element.Keyed.column
        [ width fill
        , height fill
        , paddingEach { top = 0, left = 0, right = 0, bottom = 16 }
        ]
        (categories
            |> Data.TreeStore.traverse
                (\depth category childElements ->
                    ( category.id
                    , Element.Lazy.lazy3 categoryView depth childElements category
                    )
                )
        )


categoryView :
    Int
    -> List ( String, Element RootMsg )
    -> Category
    -> Element RootMsg
categoryView depth childElements category =
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
                        , left = (depth + 1) * 16
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
