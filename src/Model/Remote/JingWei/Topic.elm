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


module Model.Remote.JingWei.Topic exposing
    ( deleteMyTopic
    , getMyAllTopics
    , queryMyTopics
    , saveMyEditTopic
    , saveMyNewTopic
    )

import GraphQl
import GraphQl.Http
import Json.Decode as Decode
import Json.Encode as Encode
import Model.Remote.Msg exposing (Msg(..))
import Model.Topic exposing (Topic, topicDecoder, topicListDecoder)


getMyAllTopics : Cmd Msg
getMyAllTopics =
    queryMyTopics
        { keywords = Nothing
        }


queryMyTopics :
    { keywords : Maybe String
    }
    -> Cmd Msg
queryMyTopics { keywords } =
    -- https://package.elm-lang.org/packages/ghivert/elm-graphql/5.0.0/GraphQl
    GraphQl.query
        (GraphQl.named "TopicsQuery"
            [ GraphQl.field "topics"
                |> GraphQl.withArgument "keywords" (GraphQl.variable "keywords")
                |> GraphQl.withSelectors
                    [ GraphQl.field "id"
                    , GraphQl.field "title"
                    , GraphQl.field "content"
                    , GraphQl.field "tags"
                    ]
            ]
            |> GraphQl.withVariables [ ( "keywords", "String" ) ]
        )
        |> GraphQl.addVariables
            [ ( "keywords"
              , keywords
                    |> Maybe.map Encode.string
                    |> Maybe.withDefault Encode.null
              )
            ]
        |> GraphQl.Http.send { url = "/api/graphql", headers = [] }
            QueryMyTopics
            (Decode.field "topics" topicListDecoder)


{-| 保存新增主题
-}
saveMyNewTopic :
    Topic
    -> Cmd Msg
saveMyNewTopic topic =
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
            SaveMyNewTopic
            (Decode.field "createTopic" topicDecoder)


{-| 保存编辑主题
-}
saveMyEditTopic :
    Topic
    -> Cmd Msg
saveMyEditTopic topic =
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
            SaveMyEditTopic
            (Decode.field "updateTopic" topicDecoder)


{-| 删除主题
-}
deleteMyTopic :
    String
    -> Cmd Msg
deleteMyTopic id =
    -- https://package.elm-lang.org/packages/ghivert/elm-graphql/5.0.0/GraphQl
    GraphQl.mutation
        (GraphQl.named "TopicDelete"
            [ GraphQl.field "deleteTopic"
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
            DeleteMyTopic
            (Decode.at [ "deleteTopic", "id" ] Decode.string)



-- ----------------------------------------------
