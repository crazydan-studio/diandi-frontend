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


module Data.TreeStore exposing
    ( TreeConfig
    , TreeSorter
    , TreeStore
    , TreeTraveller
    , add
    , create
    , empty
    , get
    , remove
    , traverse
    , traverseDepth
    , traverseWithSingleRoot
    )

{-| -}

import Dict exposing (Dict)


type TreeStore dataType
    = Tree (TreeConfig dataType) (TreeData dataType)


{-| 树的配置

用于设置获取节点id、父节点id、子节点排序的函数等配置

-}
type alias TreeConfig dataType =
    { idGetter : dataType -> String
    , parentGetter : dataType -> Maybe String
    , sorter : Maybe (TreeSorter dataType)
    }


type alias TreeSorter dataType =
    dataType -> dataType -> Order


type alias TreeTraveller dataType resultType =
    { depth : Int, index : Int }
    -> dataType
    -> List resultType
    -> resultType


type alias TreeData dataType =
    { -- 节点id与数据自身的映射集合
      data : Dict String dataType

    -- root节点的id列表，即，无parent的数据id
    , roots : List String

    -- 父节点id与子节点id列表的映射集合，子节点id为排序后的结果
    , nodes : Dict String (List String)
    }


empty : TreeConfig dataType -> TreeStore dataType
empty config =
    Tree config
        { data = Dict.empty
        , roots = []
        , nodes = Dict.empty
        }


create :
    TreeConfig dataType
    -> List dataType
    -> TreeStore dataType
create config =
    empty config
        |> List.foldl add


get : String -> TreeStore dataType -> Maybe dataType
get id (Tree _ treeData) =
    treeData.data |> Dict.get id


add : dataType -> TreeStore dataType -> TreeStore dataType
add data ((Tree { idGetter, sorter } treeData) as tree) =
    let
        treeDataDictUpdater id =
            Dict.insert id data

        nodeIdListUpdater dataId =
            addNewIdToSortedIdListHelper sorter dataId
    in
    treeData.data
        |> Dict.get (idGetter data)
        |> Maybe.andThen
            (\oldData ->
                if oldData == data then
                    Just tree

                else
                    Nothing
            )
        |> Maybe.withDefault
            (updateHelper data treeDataDictUpdater nodeIdListUpdater tree)


remove : dataType -> TreeStore dataType -> TreeStore dataType
remove data tree =
    let
        treeDataDictUpdater =
            Dict.remove

        nodeIdListUpdater dataId _ =
            List.filter (\id -> id /= dataId)
    in
    updateHelper data treeDataDictUpdater nodeIdListUpdater tree


{-| 遍历有多个root节点的树并构造结果集
-}
traverse :
    TreeTraveller dataType resultType
    -> TreeStore dataType
    -> List resultType
traverse traverler tree =
    traverseDepth -1 traverler tree


{-| 遍历有多个root节点的树并构造结果集（指定遍历深度）
-}
traverseDepth :
    Int
    -> TreeTraveller dataType resultType
    -> TreeStore dataType
    -> List resultType
traverseDepth maxDepth traverler ((Tree _ { roots }) as tree) =
    traverseHelper
        traverler
        { depth = 1
        , maxDepth = maxDepth
        , nodesIndex = -1
        }
        roots
        tree


{-| 遍历仅有单个root节点的树并构造结果
-}
traverseWithSingleRoot :
    TreeTraveller dataType resultType
    -> TreeStore dataType
    -> Maybe resultType
traverseWithSingleRoot traverler tree =
    tree
        |> traverse traverler
        |> List.head



-- -------------------------------------------------------------


updateHelper :
    dataType
    -> (String -> Dict String dataType -> Dict String dataType)
    -> (String -> Dict String dataType -> List String -> List String)
    -> TreeStore dataType
    -> TreeStore dataType
updateHelper data treeDataDictUpdater nodeIdListUpdater tree =
    let
        (Tree ({ idGetter, parentGetter } as treeConfig) treeData) =
            tree

        dataId =
            idGetter data

        dataParentMaybe =
            parentGetter data

        newDataDict =
            treeData.data |> treeDataDictUpdater dataId

        updateNodeIdList =
            nodeIdListUpdater dataId newDataDict
    in
    case dataParentMaybe of
        Nothing ->
            Tree treeConfig
                { treeData
                    | data = newDataDict
                    , roots =
                        updateNodeIdList treeData.roots
                }

        Just dataParent ->
            let
                childIdList =
                    treeData.nodes
                        |> Dict.get dataParent
                        |> Maybe.withDefault []

                newChildIdList =
                    updateNodeIdList childIdList
            in
            Tree treeConfig
                { treeData
                    | data = newDataDict
                    , nodes =
                        treeData.nodes
                            |> Dict.insert dataParent newChildIdList
                }


addNewIdToSortedIdListHelper :
    Maybe (TreeSorter dataType)
    -> String
    -> Dict String dataType
    -> List String
    -> List String
addNewIdToSortedIdListHelper sorterMaybe newId dataDict sortedIdList =
    case sorterMaybe of
        Nothing ->
            sortedIdList ++ [ newId ]

        Just sorter ->
            -- 注：由调用方确定新增数据是否已存在，以及是否发生变更，
            -- 对已存在的未变更数据，则不调用该函数
            sortedIdList
                ++ [ newId ]
                |> List.sortWith
                    (\id1 id2 ->
                        -- 注意入参顺序与id顺序保持一致
                        (Dict.get id2 dataDict
                            |> (Dict.get id1 dataDict
                                    |> Maybe.map2 sorter
                               )
                        )
                            |> Maybe.withDefault EQ
                    )


traverseHelper :
    TreeTraveller dataType resultType
    -> { depth : Int, maxDepth : Int, nodesIndex : Int }
    -> List String
    -> TreeStore dataType
    -> List resultType
traverseHelper traverler opts nodeIds ((Tree _ { data, nodes }) as tree) =
    let
        { depth, maxDepth, nodesIndex } =
            opts
    in
    (if depth > maxDepth && maxDepth >= 0 then
        []

     else
        nodeIds
    )
        |> List.foldl
            (\nodeId results ->
                Dict.get nodeId data
                    |> Maybe.map
                        (\nodeData ->
                            [ -- 构造父结果
                              (Dict.get nodeId nodes
                                |> Maybe.withDefault []
                                |> List.foldl
                                    -- 遍历子节点并构造结果，再返回子结果集
                                    (\childNodeId childResults ->
                                        traverseHelper
                                            traverler
                                            { depth = depth + 1
                                            , maxDepth = maxDepth
                                            , nodesIndex = List.length childResults
                                            }
                                            [ childNodeId ]
                                            tree
                                            |> (++) childResults
                                    )
                                    []
                              )
                                |> traverler
                                    { depth = depth
                                    , index =
                                        -- Note: 遍历深度为1时，所处节点为根节点，
                                        -- 故，根节点序号为结果集长度
                                        if depth == 1 then
                                            List.length results

                                        else
                                            nodesIndex
                                    }
                                    nodeData
                            ]
                                |> (++) results
                        )
                    |> Maybe.withDefault results
            )
            []
