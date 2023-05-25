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


module App.Store.Demo.Topic exposing
    ( deleteMyTopic
    , getMyAllTopics
    , queryMyTopics
    , saveMyEditTopic
    , saveMyNewTopic
    )

import App.Store.Msg exposing (Msg(..))
import App.Topic exposing (Topic, topicListDecoder)
import Http
import Json.Decode as Decode
import Widget.Util.Hash exposing (hash)


getMyAllTopics : Cmd Msg
getMyAllTopics =
    queryMyTopics
        { keyword = Nothing
        , tags = []
        }


queryMyTopics :
    { keyword : Maybe String
    , tags : List String
    }
    -> Cmd Msg
queryMyTopics { keyword, tags } =
    Http.get
        { url = "/demo/topics.json"
        , expect =
            Http.expectJson QueryMyTopics
                (decoderWithFilterTopics keyword)
        }


{-| 保存新增主题
-}
saveMyNewTopic :
    Int
    -> Topic
    -> Cmd Msg
saveMyNewTopic nextMsgId topic =
    -- Note: 模拟请求，并返回数据
    Http.get
        { url = "/demo/topics.json"
        , expect =
            Http.expectJson (SaveMyNewTopic nextMsgId)
                (Decode.succeed
                    (if String.isEmpty topic.id then
                        { topic | id = hash topic.content }

                     else
                        topic
                    )
                )
        }


{-| 保存编辑主题
-}
saveMyEditTopic :
    Int
    -> Topic
    -> Cmd Msg
saveMyEditTopic nextMsgId topic =
    -- Note: 模拟请求，并返回数据
    Http.get
        { url = "/demo/topics.json"
        , expect =
            Http.expectJson (SaveMyEditTopic nextMsgId)
                (Decode.succeed topic)
        }


{-| 删除主题
-}
deleteMyTopic :
    String
    -> Cmd Msg
deleteMyTopic id =
    -- Note: 模拟请求，并返回数据
    Http.get
        { url = "/demo/topics.json"
        , expect =
            Http.expectJson (TrashMyTopic id)
                (Decode.succeed id)
        }



-- ----------------------------------------------


decoderWithFilterTopics :
    Maybe String
    -> Decode.Decoder (List Topic)
decoderWithFilterTopics keywordsMaybe =
    let
        listFilter keywords =
            List.filter
                (\topic ->
                    (topic.content
                        |> String.contains keywords
                    )
                        || (topic.title
                                |> Maybe.withDefault ""
                                |> String.contains keywords
                           )
                        || (topic.tags
                                |> List.foldl
                                    (\tag r ->
                                        r || (tag |> String.contains keywords)
                                    )
                                    False
                           )
                )
    in
    keywordsMaybe
        |> Maybe.map
            (\keywords ->
                topicListDecoder
                    |> Decode.map (listFilter keywords)
            )
        |> Maybe.withDefault topicListDecoder
