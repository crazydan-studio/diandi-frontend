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
    , getAllByParentPath
    , isEmpty
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
    -- 子节点的遍历结果集合
    -> List resultType
    -- 当前节点的遍历结果
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


isEmpty : TreeStore dataType -> Bool
isEmpty (Tree _ treeData) =
    treeData.data |> Dict.isEmpty


get : String -> TreeStore dataType -> Maybe dataType
get id (Tree _ treeData) =
    treeData.data |> Dict.get id


{-| 添加数据

已存在的数据将更新其数据值和排序等

-}
add : dataType -> TreeStore dataType -> TreeStore dataType
add data ((Tree { sorter } _) as tree) =
    let
        treeDataDictUpdater id =
            Dict.insert id data

        nodeIdListUpdater dataId =
            addNewIdToSortedIdListHelper sorter dataId
    in
    -- Note: 对于更新，不能先删除再添加，因为在无排序函数时，删除后添加会造成相对位置发生变化
    tree
        |> updateHelper data treeDataDictUpdater nodeIdListUpdater


remove : dataType -> TreeStore dataType -> TreeStore dataType
remove data tree =
    let
        treeDataDictUpdater =
            Dict.remove

        nodeIdListUpdater dataId _ =
            List.filter (\id -> id /= dataId)
    in
    tree
        |> updateHelper data treeDataDictUpdater nodeIdListUpdater


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


{-| 沿父节点路径，从指定位置开始，向上获取全部节点
-}
getAllByParentPath :
    String
    -> TreeStore dataType
    -> List dataType
getAllByParentPath dataId =
    getAllByParentPathHelper dataId []



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

        dataOldParentMaybe =
            treeData.data
                |> Dict.get dataId
                |> Maybe.andThen parentGetter

        newDataDict =
            treeData.data |> treeDataDictUpdater dataId

        updateDataIdList =
            nodeIdListUpdater dataId newDataDict

        removeDataIdFromIdList =
            List.filter
                (\id ->
                    id /= dataId
                )

        removeNodeIdFor parentId td =
            { td
                | nodes =
                    td.nodes
                        |> Dict.get parentId
                        |> Maybe.map
                            (\childIdList ->
                                td.nodes
                                    |> Dict.insert parentId
                                        (childIdList
                                            |> removeDataIdFromIdList
                                        )
                            )
                        |> Maybe.withDefault td.nodes
            }

        newTreeData =
            case dataOldParentMaybe of
                Nothing ->
                    case dataParentMaybe of
                        Nothing ->
                            treeData

                        Just _ ->
                            -- 原来没有但现在有父节点，
                            -- 则从root中移除该节点，
                            -- 以等待添加到新的父节点中
                            { treeData
                                | roots =
                                    treeData.roots
                                        |> removeDataIdFromIdList
                            }

                Just dataOldParent ->
                    case dataParentMaybe of
                        Nothing ->
                            -- 原来有但现在没有父节点，
                            -- 则从原父节点中移除该节点，
                            -- 以等待添加到root节点中
                            treeData
                                |> removeNodeIdFor dataOldParent

                        Just dataParent ->
                            if dataOldParent == dataParent then
                                treeData

                            else
                                -- 原来与现在的父节点不同，
                                -- 则从原父节点中移除该节点，
                                -- 以等待添加到新的父节点中
                                treeData
                                    |> removeNodeIdFor dataOldParent
    in
    case dataParentMaybe of
        Nothing ->
            Tree treeConfig
                { newTreeData
                    | data = newDataDict
                    , roots =
                        updateDataIdList newTreeData.roots
                }

        Just dataParent ->
            let
                childIdList =
                    newTreeData.nodes
                        |> Dict.get dataParent
                        |> Maybe.withDefault []

                newChildIdList =
                    updateDataIdList childIdList
            in
            Tree treeConfig
                { newTreeData
                    | data = newDataDict
                    , nodes =
                        newTreeData.nodes
                            |> Dict.insert dataParent newChildIdList
                }


addNewIdToSortedIdListHelper :
    Maybe (TreeSorter dataType)
    -> String
    -> Dict String dataType
    -> List String
    -> List String
addNewIdToSortedIdListHelper sorterMaybe newId dataDict sortedIdList =
    let
        newSortedIdList =
            if sortedIdList |> List.member newId then
                sortedIdList

            else
                sortedIdList ++ [ newId ]
    in
    case sorterMaybe of
        Nothing ->
            newSortedIdList

        Just sorter ->
            -- 排序条件可能发生变化，故而，始终做一次排序
            newSortedIdList
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


getAllByParentPathHelper :
    String
    -> List dataType
    -> TreeStore dataType
    -> List dataType
getAllByParentPathHelper dataId results ((Tree { parentGetter } _) as tree) =
    case get dataId tree of
        Nothing ->
            results

        Just data ->
            let
                newResults =
                    data :: results
            in
            data
                |> parentGetter
                |> Maybe.map
                    (\parentId ->
                        getAllByParentPathHelper parentId newResults tree
                    )
                |> Maybe.withDefault newResults
