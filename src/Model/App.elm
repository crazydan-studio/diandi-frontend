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
    , addToDeletedTopics
    , addToDeletingTopics
    , cleanEditTopic
    , cleanNewTopic
    , deleteTopic
    , getTopic
    , init
    , initEditTopic
    , initNewTopic
    , loadTopics
    , loading
    , prepareSavingEditTopic
    , prepareSavingNewTopic
    , updateDevice
    , updateEditTopic
    , updateNewTopic
    , updateSavedEditTopic
    , updateSavedNewTopic
    , updateTopicCard
    , updateTopicSearchingText
    )

import Browser.Navigation as Nav
import Data.TreeStore as TreeStore exposing (TreeStore)
import Element exposing (Device)
import Http
import I18n.I18n exposing (langTextEnd)
import I18n.Lang exposing (Lang)
import I18n.Translator exposing (TextsNeedToBeTranslated, TranslateResult)
import Model.I18n.App as I18n
import Model.Operation.EditTopic as EditTopic exposing (EditTopic)
import Model.Remote as Remote
import Model.Remote.Data as RemoteData
import Model.Topic exposing (Topic)
import Model.TopicCard as TopicCard exposing (TopicCard)
import Svg.Attributes exposing (result)
import Url
import View.I18n.Default
import View.Page
import Widget.Util.Basic exposing (trim)


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
    , topicCards : RemoteTopicCards

    -- 操作数据
    , topicSearchingText : Maybe String
    , deletePendingTopics : List String
    , deletedTopics : List ( String, Maybe TranslateResult )
    , newTopic : Maybe EditTopic
    , editTopic : Maybe EditTopic
    , topicEditInputId : String
    , topicTagEditInputId : String
    }


type alias Config =
    { title : String
    , description : String
    , device : Device
    , lang : String
    , navKey : Nav.Key
    , navUrl : Url.Url
    }


type alias RemoteTopicCards =
    RemoteData.Status (TreeStore TopicCard)


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
    , topicCards = RemoteData.LoadWaiting

    --
    , topicSearchingText = Nothing
    , deletePendingTopics = []
    , deletedTopics = []
    , newTopic = Nothing
    , editTopic = Nothing
    , topicEditInputId = "topic-edit-input"
    , topicTagEditInputId = "topic-tag-edit-input"
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
        | topicCards =
            result
                |> RemoteData.from state.lang createTopicCardsHelper
    }


updateDevice : Device -> State -> State
updateDevice device state =
    { state | device = device }


updateTopicSearchingText : Maybe String -> State -> State
updateTopicSearchingText keywords state =
    { state | topicSearchingText = keywords }


getTopic : String -> State -> Maybe Topic
getTopic topicId { topicCards } =
    topicCards
        |> RemoteData.andThen
            (\store ->
                store
                    |> TreeStore.get topicId
            )
        |> Maybe.map .topic


updateTopicCard : String -> TopicCard.Msg -> State -> State
updateTopicCard topicId topicCardMsg state =
    state
        |> updateTopicCardHelper topicId
            (TopicCard.update
                topicCardMsg
            )


deleteTopic : String -> State -> State
deleteTopic topicId ({ topicCards } as state) =
    { state
        | topicCards =
            topicCards
                |> RemoteData.update
                    (TreeStore.removeById topicId)
        , deletedTopics =
            state.deletedTopics
                |> List.filter
                    (\( id, _ ) ->
                        id /= topicId
                    )
    }


addToDeletedTopics :
    String
    -> Result Http.Error String
    -> State
    -> State
addToDeletedTopics topicId result ({ lang } as state) =
    let
        error =
            case result of
                Ok _ ->
                    Nothing

                Err e ->
                    Just (Remote.parseError lang e)
    in
    { state
        | deletedTopics =
            ( topicId, error ) :: state.deletedTopics
        , deletePendingTopics =
            state.deletePendingTopics
                |> List.filter ((/=) topicId)
    }


addToDeletingTopics : String -> State -> State
addToDeletingTopics topicId state =
    { state
        | deletePendingTopics = topicId :: state.deletePendingTopics
    }


initNewTopic :
    State
    -> State
initNewTopic state =
    { state | newTopic = Just EditTopic.init }


updateNewTopic :
    (EditTopic -> EditTopic)
    -> State
    -> State
updateNewTopic updater ({ newTopic } as state) =
    { state | newTopic = newTopic |> Maybe.map updater }


cleanNewTopic :
    State
    -> State
cleanNewTopic state =
    { state
        | newTopic = Nothing
    }


prepareSavingNewTopic : State -> ( Maybe EditTopic, Maybe Topic )
prepareSavingNewTopic { lang, newTopic } =
    newTopic
        |> Maybe.map
            (\newTopic_ ->
                case trim newTopic_.content of
                    Nothing ->
                        ( Just
                            (newTopic_
                                |> EditTopic.error
                                    ("主题内容是空白的，请先输入点什么"
                                        :: langTextEnd
                                        |> I18n.translate lang
                                    )
                            )
                        , Nothing
                        )

                    _ ->
                        ( Just { newTopic_ | updating = True }
                        , Just (EditTopic.to newTopic_)
                        )
            )
        |> Maybe.withDefault ( newTopic, Nothing )


updateSavedNewTopic :
    Result Http.Error Topic
    -> State
    -> State
updateSavedNewTopic result ({ lang } as state) =
    case result of
        Ok topic ->
            state
                |> updateNewTopic
                    EditTopic.clean
                |> updateNewTopic
                    (EditTopic.info
                        ("新增主题已保存成功"
                            :: langTextEnd
                            |> I18n.translate lang
                        )
                    )
                |> addTopicHelper topic

        Err error ->
            state
                |> updateNewTopic
                    (EditTopic.error
                        (Remote.parseError lang error)
                    )
                |> updateNewTopic (\t -> { t | updating = False })


initEditTopic :
    String
    -> State
    -> State
initEditTopic topicId state =
    { state
        | editTopic =
            state
                |> getTopic topicId
                |> Maybe.map EditTopic.from
    }


updateEditTopic :
    (EditTopic -> EditTopic)
    -> State
    -> State
updateEditTopic updater ({ editTopic } as state) =
    { state | editTopic = editTopic |> Maybe.map updater }


cleanEditTopic :
    State
    -> State
cleanEditTopic state =
    { state | editTopic = Nothing }


prepareSavingEditTopic : State -> ( Maybe EditTopic, Maybe Topic )
prepareSavingEditTopic ({ lang, editTopic } as state) =
    editTopic
        |> Maybe.map
            (\editTopic_ ->
                case trim editTopic_.content of
                    Nothing ->
                        ( Just
                            (editTopic_
                                |> EditTopic.error
                                    ("主题内容是空白的，请先输入点什么"
                                        :: langTextEnd
                                        |> I18n.translate lang
                                    )
                            )
                        , Nothing
                        )

                    _ ->
                        ( Just { editTopic_ | updating = True }
                        , state
                            |> getTopic editTopic_.id
                            |> Maybe.map
                                (EditTopic.patch editTopic_)
                        )
            )
        |> Maybe.withDefault ( editTopic, Nothing )


updateSavedEditTopic :
    Result Http.Error Topic
    -> State
    -> State
updateSavedEditTopic result ({ lang } as state) =
    case result of
        Ok topic ->
            state
                |> updateEditTopic
                    (EditTopic.info
                        ("当前主题已更新成功"
                            :: langTextEnd
                            |> I18n.translate lang
                        )
                    )
                |> updateEditTopic (\t -> { t | updating = False })
                |> addTopicHelper topic

        Err error ->
            state
                |> updateEditTopic
                    (EditTopic.error
                        (Remote.parseError lang error)
                    )
                |> updateEditTopic (\t -> { t | updating = False })



-- --------------------------------------------------------------------


addTopicHelper :
    Topic
    -> State
    -> State
addTopicHelper topic ({ topicCards } as state) =
    { state
        | topicCards =
            topicCards
                |> RemoteData.update
                    (\store ->
                        store
                            |> TreeStore.add
                                (store
                                    |> TreeStore.get topic.id
                                    |> Maybe.map
                                        (\topicCard ->
                                            { topicCard | topic = topic }
                                        )
                                    |> Maybe.withDefault (TopicCard.create topic)
                                )
                    )
    }


updateTopicCardHelper :
    String
    -> (TopicCard -> TopicCard)
    -> State
    -> State
updateTopicCardHelper topicId updater ({ topicCards } as state) =
    topicCards
        |> RemoteData.andThen
            (TreeStore.get topicId)
        |> Maybe.map
            (\topicCard ->
                { state
                    | topicCards =
                        topicCards
                            |> RemoteData.update
                                (TreeStore.add
                                    (updater topicCard)
                                )
                }
            )
        |> Maybe.withDefault state


createTopicCardsHelper : List Topic -> TreeStore TopicCard
createTopicCardsHelper topics =
    TreeStore.create
        { idGetter = \{ topic } -> topic.id
        , parentGetter = \_ -> Nothing
        , sorter = Nothing
        }
        (topics |> List.map TopicCard.create)
