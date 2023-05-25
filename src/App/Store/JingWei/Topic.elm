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


module App.Store.JingWei.Topic exposing
    ( deleteMyTopic
    , getMyAllTopics
    , queryMyTopics
    , restoreMyTrashedTopic
    , saveMyEditTopic
    , saveMyNewTopic
    , trashMyTopic
    )

import App.Store.Msg exposing (Msg(..))
import App.Topic
    exposing
        ( Topic
        , topicDecoder
        , topicListDecoder
        )
import App.TopicFilter as TopicFilter exposing (TopicFilter)
import GraphQl
import GraphQl.Http
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Widget.Util.Basic exposing (trim)


getMyAllTopics : Cmd Msg
getMyAllTopics =
    queryMyTopics
        TopicFilter.all


queryMyTopics :
    TopicFilter
    -> Cmd Msg
queryMyTopics { trashed, keyword, tags } =
    -- https://package.elm-lang.org/packages/ghivert/elm-graphql/5.0.0/GraphQl
    GraphQl.query
        (GraphQl.named "TopicsQuery"
            [ GraphQl.field "topics"
                |> GraphQl.withArgument "filter"
                    (GraphQl.input
                        [ ( "tags"
                          , GraphQl.input
                                [ ( "has_all_members_in", GraphQl.variable "tags" )
                                ]
                          )
                        , ( "trashed"
                          , GraphQl.input
                                [ ( "equal", GraphQl.variable "trashed" )
                                ]
                          )
                        , ( "or"
                          , GraphQl.nestedInput
                                [ [ ( "title"
                                    , GraphQl.input
                                        [ ( "contains_any_in", GraphQl.variable "keywords" )
                                        ]
                                    )
                                  ]
                                , [ ( "content"
                                    , GraphQl.input
                                        [ ( "contains_any_in", GraphQl.variable "keywords" )
                                        ]
                                    )
                                  ]
                                , [ ( "tags"
                                    , GraphQl.input
                                        [ ( "contains_any_in", GraphQl.variable "keywords" )
                                        ]
                                    )
                                  ]
                                ]
                          )
                        ]
                    )
                |> GraphQl.withSelectors
                    [ GraphQl.field "id"
                    , GraphQl.field "title"
                    , GraphQl.field "content"
                    , GraphQl.field "tags"
                    , GraphQl.field "trashed"
                    , GraphQl.field "updated_at"
                    ]
            ]
            |> GraphQl.withVariables
                [ ( "keywords", "[String!]" )
                , ( "tags", "[String!]" )
                , ( "trashed", "String!" )
                ]
        )
        |> GraphQl.addVariables
            [ ( "trashed"
              , Encode.string
                    (if trashed then
                        "true"

                     else
                        "false"
                    )
              )
            , ( "keywords"
              , keyword
                    |> Maybe.andThen trim
                    |> Maybe.map
                        (\s ->
                            Encode.list Encode.string
                                (s
                                    |> String.split " "
                                    |> List.filter ((/=) "")
                                )
                        )
                    |> Maybe.withDefault Encode.null
              )
            , ( "tags"
              , if tags |> List.isEmpty then
                    Encode.null

                else
                    tags
                        |> Encode.list Encode.string
              )
            ]
        |> GraphQl.Http.send { url = "/api/graphql", headers = [] }
            QueryMyTopics
            (Decode.field "topics" topicListDecoder)


{-| 保存新增主题
-}
saveMyNewTopic :
    Int
    -> Topic
    -> Cmd Msg
saveMyNewTopic nextMsgId topic =
    -- https://package.elm-lang.org/packages/ghivert/elm-graphql/5.0.0/GraphQl
    GraphQl.mutation
        (GraphQl.named "TopicCreate"
            [ GraphQl.field "createTopic"
                |> GraphQl.withArgument "title" (GraphQl.variable "title")
                |> GraphQl.withArgument "content" (GraphQl.variable "content")
                |> GraphQl.withArgument "tags" (GraphQl.variable "tags")
                |> GraphQl.withSelectors
                    [ GraphQl.field "id"
                    , GraphQl.field "title"
                    , GraphQl.field "content"
                    , GraphQl.field "tags"
                    , GraphQl.field "updated_at"
                    ]
            ]
            |> GraphQl.withVariables
                [ ( "title", "String" )
                , ( "content", "String!" )
                , ( "tags", "[String!]" )
                ]
        )
        |> GraphQl.addVariables
            [ ( "title"
              , topic.title
                    |> Maybe.map Encode.string
                    |> Maybe.withDefault Encode.null
              )
            , ( "content"
              , Encode.string topic.content
              )
            , ( "tags"
              , Encode.list Encode.string topic.tags
              )
            ]
        |> GraphQl.Http.send { url = "/api/graphql", headers = [] }
            (SaveMyNewTopic nextMsgId)
            (Decode.field "createTopic" topicDecoder)


{-| 保存编辑主题
-}
saveMyEditTopic :
    Int
    -> Topic
    -> Cmd Msg
saveMyEditTopic nextMsgId topic =
    -- https://package.elm-lang.org/packages/ghivert/elm-graphql/5.0.0/GraphQl
    GraphQl.mutation
        (GraphQl.named "TopicUpdate"
            [ GraphQl.field "updateTopic"
                |> GraphQl.withArgument "id" (GraphQl.variable "id")
                |> GraphQl.withArgument "title" (GraphQl.variable "title")
                |> GraphQl.withArgument "content" (GraphQl.variable "content")
                |> GraphQl.withArgument "tags" (GraphQl.variable "tags")
                |> GraphQl.withSelectors
                    [ GraphQl.field "id"
                    , GraphQl.field "title"
                    , GraphQl.field "content"
                    , GraphQl.field "tags"
                    , GraphQl.field "updated_at"
                    ]
            ]
            |> GraphQl.withVariables
                [ ( "id", "ID!" )
                , ( "title", "String" )
                , ( "content", "String!" )
                , ( "tags", "[String!]" )
                ]
        )
        |> GraphQl.addVariables
            [ ( "id"
              , Encode.string topic.id
              )
            , ( "title"
              , topic.title
                    |> Maybe.map Encode.string
                    |> Maybe.withDefault Encode.null
              )
            , ( "content"
              , Encode.string topic.content
              )
            , ( "tags"
              , Encode.list Encode.string topic.tags
              )
            ]
        |> GraphQl.Http.send { url = "/api/graphql", headers = [] }
            (SaveMyEditTopic nextMsgId)
            (Decode.field "updateTopic" topicDecoder)


{-| 主题放入垃圾箱
-}
trashMyTopic :
    String
    -> Cmd Msg
trashMyTopic =
    doWithId
        "TopicTrash"
        "trashTopic"
        TrashMyTopic


{-| 彻底删除主题
-}
deleteMyTopic :
    String
    -> Cmd Msg
deleteMyTopic =
    doWithId
        "TopicDelete"
        "deleteTopic"
        DeleteMyTopic


{-| 恢复放入垃圾箱的主题
-}
restoreMyTrashedTopic :
    String
    -> Cmd Msg
restoreMyTrashedTopic =
    doWithId
        "TrashedTopicRestore"
        "restoreTrashedTopic"
        RestoreMyTrashedTopic



-- ----------------------------------------------


doWithId :
    String
    -> String
    -> (String -> (Result Http.Error String -> Msg))
    -> String
    -> Cmd Msg
doWithId name field toMsg id =
    -- https://package.elm-lang.org/packages/ghivert/elm-graphql/5.0.0/GraphQl
    GraphQl.mutation
        (GraphQl.named name
            [ GraphQl.field field
                |> GraphQl.withArgument "id" (GraphQl.variable "id")
                |> GraphQl.withSelectors
                    [ GraphQl.field "id"
                    ]
            ]
            |> GraphQl.withVariables
                [ ( "id", "ID!" )
                ]
        )
        |> GraphQl.addVariables
            [ ( "id"
              , Encode.string id
              )
            ]
        |> GraphQl.Http.send { url = "/api/graphql", headers = [] }
            (toMsg id)
            (Decode.at [ field, "id" ] Decode.string)
