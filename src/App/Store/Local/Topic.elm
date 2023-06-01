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


module App.Store.Local.Topic exposing
    ( countMyTopics
    , deleteMyTopic
    , deleteMyTopics
    , queryMyTopics
    , restoreMyTrashedTopic
    , saveMyEditTopic
    , saveMyNewTopic
    , trashMyTopic
    )

import App.Store.Msg
    exposing
        ( Msg(..)
        , opResultDecoder
        , statsResultDecoder
        )
import App.Topic
    exposing
        ( Topic
        , topicDecoder
        , topicEncoder
        , topicListDecoder
        )
import App.TopicFilter exposing (TopicFilter)
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Native.Local.Store as LocalStore


queryMyTopics :
    TopicFilter
    -> Cmd Msg
queryMyTopics topicFilter =
    LocalStore.execute
        { path = "queryTopics"
        , args = topicFilterArgs topicFilter
        }
        QueryMyTopics
        topicListDecoder


countMyTopics :
    TopicFilter
    -> Cmd Msg
countMyTopics topicFilter =
    LocalStore.execute
        { path = "countTopics"
        , args = topicFilterArgs topicFilter
        }
        (CountMyTopics topicFilter.trashed)
        statsResultDecoder


deleteMyTopics :
    Int
    -> TopicFilter
    -> Cmd Msg
deleteMyTopics nextMsgId topicFilter =
    LocalStore.execute
        { path = "deleteTopics"
        , args = topicFilterArgs topicFilter
        }
        (DeleteMyTopics nextMsgId)
        opResultDecoder


{-| 保存新增主题
-}
saveMyNewTopic :
    Int
    -> Topic
    -> Cmd Msg
saveMyNewTopic nextMsgId topic =
    LocalStore.execute
        { path = "createTopic"
        , args = topicEncoder topic
        }
        (SaveMyNewTopic nextMsgId)
        topicDecoder


{-| 保存编辑主题
-}
saveMyEditTopic :
    Int
    -> Topic
    -> Cmd Msg
saveMyEditTopic nextMsgId topic =
    LocalStore.execute
        { path = "updateTopic"
        , args = topicEncoder topic
        }
        (SaveMyEditTopic nextMsgId)
        topicDecoder


{-| 主题放入垃圾箱
-}
trashMyTopic :
    String
    -> Cmd Msg
trashMyTopic =
    doWithId
        "trashTopic"
        TrashMyTopic


{-| 彻底删除主题
-}
deleteMyTopic :
    String
    -> Cmd Msg
deleteMyTopic =
    doWithId
        "deleteTopic"
        DeleteMyTopic


{-| 恢复放入垃圾箱的主题
-}
restoreMyTrashedTopic :
    String
    -> Cmd Msg
restoreMyTrashedTopic =
    doWithId
        "restoreTrashedTopic"
        RestoreMyTrashedTopic



-- ----------------------------------------------


doWithId :
    String
    -> (String -> (Result Http.Error String -> Msg))
    -> String
    -> Cmd Msg
doWithId path toMsg id =
    LocalStore.execute
        { path = path
        , args = Encode.string id
        }
        (toMsg id)
        (Decode.at [ "id" ] Decode.string)


topicFilterArgs :
    TopicFilter
    -> Encode.Value
topicFilterArgs { trashed, keyword, tags } =
    Encode.object
        [ ( "keyword"
          , keyword
                |> Maybe.map Encode.string
                |> Maybe.withDefault Encode.null
          )
        , ( "tags", Encode.list Encode.string tags )
        , ( "trashed", Encode.bool trashed )
        ]
