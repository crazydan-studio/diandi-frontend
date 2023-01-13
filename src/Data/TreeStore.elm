module Data.TreeStore exposing
    ( Tree
    , TreeConfig
    , TreeSorter
    , TreeTraveller
    , add
    , create
    , empty
    , remove
    , traverse
    , traverseDepth
    , traverseWithSingleRoot
    )

{-| -}

import Dict exposing (Dict)


type Tree dataType
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
    Int -> dataType -> List resultType -> resultType


type alias TreeData dataType =
    { -- 节点id与数据自身的映射集合
      data : Dict String dataType

    -- root节点的id列表，即，无parent的数据id
    , roots : List String

    -- 父节点id与子节点id列表的映射集合，子节点id为排序后的结果
    , nodes : Dict String (List String)
    }


empty : TreeConfig dataType -> Tree dataType
empty config =
    Tree config
        { data = Dict.empty
        , roots = []
        , nodes = Dict.empty
        }


create : TreeConfig dataType -> List dataType -> Tree dataType
create config =
    empty config
        |> List.foldl add


add : dataType -> Tree dataType -> Tree dataType
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


remove : dataType -> Tree dataType -> Tree dataType
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
    -> Tree dataType
    -> List resultType
traverse traverler ((Tree _ { roots }) as tree) =
    traverseHelper traverler 1 -1 roots tree


{-| 遍历有多个root节点的树并构造结果集（指定遍历深度）
-}
traverseDepth :
    Int
    -> TreeTraveller dataType resultType
    -> Tree dataType
    -> List resultType
traverseDepth maxDepth traverler ((Tree _ { roots }) as tree) =
    traverseHelper traverler 1 maxDepth roots tree


{-| 遍历仅有单个root节点的树并构造结果
-}
traverseWithSingleRoot :
    TreeTraveller dataType resultType
    -> Tree dataType
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
    -> Tree dataType
    -> Tree dataType
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
    -> Int
    -> Int
    -> List String
    -> Tree dataType
    -> List resultType
traverseHelper traverler depth maxDepth nodeIds ((Tree _ { data, nodes }) as tree) =
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
                                            (depth + 1)
                                            maxDepth
                                            [ childNodeId ]
                                            tree
                                            |> (++) childResults
                                    )
                                    []
                              )
                                |> traverler depth nodeData
                            ]
                                |> (++) results
                        )
                    |> Maybe.withDefault results
            )
            []
