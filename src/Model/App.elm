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
    , getNewTopicWithInit
    , getSelectedTopicCategory
    , getTopicCategoriesByParentPath
    , init
    , loadTopicCategories
    , loadTopics
    , loading
    , mapTopicCategories
    , updateEditTopic
    , updateNewTopic
    , updateTopicByEdit
    )

import Browser.Navigation as Nav
import Data.TreeStore as TreeStore exposing (TreeStore)
import Dict exposing (Dict)
import Http
import I18n.Lang
    exposing
        ( Lang
        , TextsNeedToBeTranslated
        , TranslateResult
        )
import Model.Operation.EditTopic as EditTopic exposing (EditTopic)
import Model.Operation.NewTopic as NewTopic exposing (NewTopic)
import Model.Remote.Data as RemoteData
import Model.Topic exposing (Topic)
import Model.Topic.Category exposing (Category)
import Model.User as User
import Svg.Attributes exposing (result)
import Url
import View.I18n.Default
import View.Page
import Widget.Util.Hash exposing (hash)


type alias State =
    { title : String
    , description : String

    -- 国际化
    , lang : Lang
    , textsWithoutI18n : List TextsNeedToBeTranslated

    -- 路由
    , navKey : Nav.Key
    , navUrl : Url.Url

    -- 当前用户信息
    , me : User.User

    -- 远程请求错误信息
    , remoteError : Maybe TranslateResult
    , currentPage : View.Page.Type
    , topicListViewId : String
    , newTopicInputId : String

    -- 业务数据
    , topics : RemoteTopics
    , categories : RemoteCategories

    -- 操作数据
    , selectedTopicCategory : Maybe String
    , newTopics : Dict String NewTopic
    , editTopic : Maybe EditTopic
    }


type alias Config =
    { title : String
    , description : String
    , lang : String
    , navKey : Nav.Key
    , navUrl : Url.Url
    }


type alias RemoteTopics =
    RemoteData.Status (TreeStore Topic)


type alias RemoteCategories =
    RemoteData.Status (TreeStore Category)


init : Config -> State
init config =
    { title = config.title
    , description = config.description

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
    , me = User.None
    , remoteError = Nothing
    , currentPage = View.Page.Loading
    , topicListViewId = "topic-list-view"
    , newTopicInputId = "new-topic-input"

    --
    , topics = RemoteData.LoadWaiting
    , categories = RemoteData.LoadWaiting

    --
    , selectedTopicCategory = Nothing
    , newTopics = Dict.empty
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


loadTopicCategories :
    Result Http.Error (List Category)
    -> State
    -> State
loadTopicCategories result state =
    { state
        | categories =
            result
                |> RemoteData.from state.lang createTopicCategoryTree
    }


getSelectedTopicCategory : State -> Maybe Category
getSelectedTopicCategory { selectedTopicCategory, categories } =
    selectedTopicCategory
        |> Maybe.andThen
            (\id ->
                categories
                    |> RemoteData.andThen
                        (TreeStore.get id)
            )


getNewTopicWithInit : String -> State -> NewTopic
getNewTopicWithInit inputId { newTopics } =
    newTopics
        |> Dict.get inputId
        |> Maybe.withDefault NewTopic.init


updateNewTopic :
    String
    -> (NewTopic -> NewTopic)
    -> State
    -> State
updateNewTopic inputId updater ({ newTopics } as state) =
    let
        newTopic =
            getNewTopicWithInit inputId state
    in
    { state
        | newTopics =
            newTopics
                |> Dict.insert inputId (updater newTopic)
    }


addNewTopic : String -> State -> State
addNewTopic inputId ({ newTopics } as state) =
    newTopics
        |> Dict.get inputId
        |> Maybe.map
            (\newTopic ->
                let
                    newContent =
                        newTopic.content
                            |> String.trim

                    topic =
                        Model.Topic.init
                in
                if String.length newContent == 0 then
                    state
                        |> updateNewTopic inputId
                            (\t ->
                                { t | error = Just "主题内容是空白的，请先输入点什么" }
                            )

                else
                    state
                        |> updateNewTopic inputId
                            (\t ->
                                { t
                                    | content = ""
                                    , selection = Nothing
                                    , error = Nothing
                                }
                            )
                        |> updateTopics
                            (RemoteData.update
                                (TreeStore.add
                                    { topic
                                        | id = hash newContent
                                        , content = newContent
                                    }
                                )
                            )
            )
        |> Maybe.withDefault state


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


mapTopicCategories :
    (TreeStore Category -> Maybe a)
    -> State
    -> Maybe a
mapTopicCategories mapper state =
    state.categories
        |> RemoteData.andThen mapper


getTopicCategoriesByParentPath :
    String
    -> State
    -> Maybe (List Category)
getTopicCategoriesByParentPath categoryId state =
    state
        |> mapTopicCategories
            (\categories ->
                Just
                    (TreeStore.getAllByParentPath
                        categoryId
                        categories
                    )
            )



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
        , sorter =
            Just
                (\t1 t2 ->
                    Maybe.map2
                        (\c1 c2 ->
                            let
                                result =
                                    compare
                                        (String.length c1)
                                        (String.length c2)
                            in
                            case result of
                                EQ ->
                                    compare c1 c2

                                _ ->
                                    result
                        )
                        t1.category
                        t2.category
                        |> Maybe.withDefault EQ
                )
        }
        topics


createTopicCategoryTree : List Category -> TreeStore Category
createTopicCategoryTree categories =
    TreeStore.create
        { idGetter = .id
        , parentGetter = .parent
        , sorter = Nothing
        }
        categories
