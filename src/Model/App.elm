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


module Model.App exposing
    ( Config
    , State
    , addNewTopic
    , addRemoveTopic
    , cleanNewTopic
    , init
    , loadTopics
    , loading
    , removeTopic
    , updateDevice
    , updateEditTopic
    , updateNewTopic
    , updateTopicByEdit
    , updateTopicSearchingText
    )

import Browser.Navigation as Nav
import Data.TreeStore as TreeStore exposing (TreeStore)
import Element exposing (Device)
import Http
import I18n.Lang exposing (Lang)
import I18n.Translator exposing (TextsNeedToBeTranslated, TranslateResult)
import Model.Operation.EditTopic as EditTopic exposing (EditTopic)
import Model.Operation.NewTopic as NewTopic exposing (NewTopic)
import Model.Remote.Data as RemoteData
import Model.Topic as Topic exposing (Topic)
import Svg.Attributes exposing (result)
import Url
import View.I18n.Default
import View.Page
import Widget.Util.Basic exposing (fromMaybe, trim)
import Widget.Util.Hash exposing (hash)


type alias State =
    { title : String
    , description : String
    , device : Device

    -- 国际化
    , lang : Lang
    , textsWithoutI18n : List TextsNeedToBeTranslated

    -- 路由
    , navKey : Nav.Key
    , navUrl : Url.Url

    -- 远程请求错误信息
    , remoteError : Maybe TranslateResult
    , currentPage : View.Page.Type

    -- 业务数据
    , topics : RemoteTopics

    -- 操作数据
    , topicSearchingText : Maybe String
    , removingTopics : List String
    , newTopic : Maybe NewTopic
    , editTopic : Maybe EditTopic
    }


type alias Config =
    { title : String
    , description : String
    , device : Device
    , lang : String
    , navKey : Nav.Key
    , navUrl : Url.Url
    }


type alias RemoteTopics =
    RemoteData.Status (TreeStore Topic)


init : Config -> State
init config =
    { title = config.title
    , description = config.description
    , device = config.device

    --
    , lang =
        I18n.Lang.fromStringWithDefault
            View.I18n.Default.lang
            config.lang
    , textsWithoutI18n = []

    --
    , navKey = config.navKey
    , navUrl = config.navUrl

    --
    , remoteError = Nothing
    , currentPage = View.Page.Loading

    --
    , topics = RemoteData.LoadWaiting

    --
    , topicSearchingText = Nothing
    , removingTopics = []
    , newTopic = Nothing
    , editTopic = Nothing
    }


loading : RemoteData.Status a
loading =
    RemoteData.Loading


loadTopics :
    Result Http.Error (List Topic)
    -> State
    -> State
loadTopics result state =
    { state
        | topics =
            result
                |> RemoteData.from state.lang createTopicTree
    }


updateDevice : Device -> State -> State
updateDevice device state =
    { state | device = device }


updateTopicSearchingText : Maybe String -> State -> State
updateTopicSearchingText keywords state =
    { state | topicSearchingText = keywords }


removeTopic : String -> State -> State
removeTopic topicId ({ topics } as state) =
    { state
        | topics =
            topics
                |> RemoteData.update
                    (TreeStore.removeById topicId)
        , removingTopics =
            state.removingTopics
                |> List.filter ((/=) topicId)
    }


addRemoveTopic : String -> State -> State
addRemoveTopic topicId state =
    { state
        | removingTopics = topicId :: state.removingTopics
    }


updateNewTopic :
    (NewTopic -> NewTopic)
    -> State
    -> State
updateNewTopic updater ({ newTopic } as state) =
    { state
        | newTopic =
            Just
                (newTopic
                    |> Maybe.withDefault NewTopic.init
                    |> updater
                )
    }


cleanNewTopic :
    State
    -> State
cleanNewTopic state =
    { state
        | newTopic = Nothing
    }


addNewTopic : State -> State
addNewTopic ({ newTopic } as state) =
    let
        content =
            trim (newTopic |> fromMaybe "" .content)

        title =
            trim (newTopic |> fromMaybe "" .title)

        tags =
            newTopic |> fromMaybe [] .tags
    in
    case content of
        Nothing ->
            state
                |> updateNewTopic
                    (\t ->
                        { t | error = "主题内容是空白的，请先输入点什么" }
                    )

        Just c ->
            state
                |> updateNewTopic
                    (\t ->
                        { t
                            | content = ""
                            , title = ""
                            , tags = []
                            , error = ""
                        }
                    )
                |> updateTopics
                    (RemoteData.update
                        (let
                            topic =
                                Topic.init
                         in
                         TreeStore.add
                            { topic
                                | id = hash c
                                , content = c
                                , title = title
                                , tags = tags
                            }
                        )
                    )


updateEditTopic :
    String
    -> (EditTopic -> EditTopic)
    -> State
    -> State
updateEditTopic topicId updater ({ topics, editTopic } as state) =
    let
        initEditTopic id =
            topics
                |> RemoteData.andThen
                    (\store ->
                        store
                            |> TreeStore.get id
                            |> Maybe.map
                                EditTopic.init
                    )

        newEditTopic =
            (case editTopic of
                Nothing ->
                    initEditTopic topicId

                Just t ->
                    if t.id /= topicId then
                        initEditTopic topicId

                    else
                        editTopic
            )
                |> Maybe.map updater
    in
    { state | editTopic = newEditTopic }


updateTopicByEdit : String -> State -> State
updateTopicByEdit topicId ({ topics, editTopic } as state) =
    editTopic
        |> Maybe.andThen
            (\edit ->
                let
                    newContent =
                        edit.content
                            |> String.trim
                in
                if String.length newContent == 0 then
                    Nothing

                else
                    topics
                        |> RemoteData.andThen
                            (TreeStore.get topicId)
                        |> Maybe.map
                            (\t ->
                                { state | editTopic = Nothing }
                                    |> updateTopics
                                        (RemoteData.update
                                            (TreeStore.add
                                                { t
                                                    | content = newContent
                                                }
                                            )
                                        )
                            )
            )
        |> Maybe.withDefault state



-- --------------------------------------------------------------------


updateTopics :
    (RemoteTopics -> RemoteTopics)
    -> State
    -> State
updateTopics updater ({ topics } as state) =
    { state | topics = updater topics }


createTopicTree : List Topic -> TreeStore Topic
createTopicTree topics =
    TreeStore.create
        { idGetter = .id
        , parentGetter = \_ -> Nothing
        , sorter = Nothing
        }
        topics
