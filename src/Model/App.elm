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
    , init
    , loadTopicCategories
    , loadTopics
    , loading
    , updateNewTopic
    )

import Browser.Navigation as Nav
import Data.TreeStore
import Dict exposing (Dict)
import Http
import I18n.Lang
    exposing
        ( Lang
        , TextsNeedToBeTranslated
        , TranslateResult
        )
import Model.Operation.NewTopic exposing (NewTopic)
import Model.Remote.Data as RemoteData
import Model.Topic exposing (Topic)
import Model.Topic.Category exposing (Category)
import Model.User as User
import Theme.Theme as Theme exposing (Theme)
import Theme.Type.Default
import Url
import Util exposing (hash)
import View.I18n.Default
import View.Page


type alias State =
    { title : String
    , description : String

    -- 国际化
    , lang : Lang
    , textsWithoutI18n : List TextsNeedToBeTranslated
    , theme : Theme

    -- 路由
    , navKey : Nav.Key
    , navUrl : Url.Url

    -- 当前用户信息
    , me : User.User

    -- 远程请求错误信息
    , remoteError : Maybe TranslateResult
    , currentPage : View.Page.Type

    -- 业务数据
    , topics : RemoteTopics
    , categories : RemoteCategories

    -- 操作数据
    , selectedTopicCategory : Maybe String
    , newTopics : Dict String NewTopic
    }


type alias Config =
    { title : String
    , description : String
    , lang : String
    , navKey : Nav.Key
    , navUrl : Url.Url
    }


type alias RemoteTopics =
    RemoteData.Status (Data.TreeStore.Tree Topic)


type alias RemoteCategories =
    RemoteData.Status (Data.TreeStore.Tree Category)


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
    , theme = Theme.Type.Default.theme

    --
    , navKey = config.navKey
    , navUrl = config.navUrl

    --
    , me = User.None
    , remoteError = Nothing
    , currentPage = View.Page.Loading

    --
    , topics = RemoteData.LoadWaiting
    , categories = RemoteData.LoadWaiting

    --
    , selectedTopicCategory = Nothing
    , newTopics = Dict.empty
    }


loading : RemoteData.Status a
loading =
    RemoteData.Loading


loadTopics : Result Http.Error (List Topic) -> State -> State
loadTopics result state =
    { state
        | topics =
            result
                |> RemoteData.from state.lang createTopicTree
    }


loadTopicCategories : Result Http.Error (List Category) -> State -> State
loadTopicCategories result state =
    { state
        | categories =
            result
                |> RemoteData.from state.lang createTopicCategoryTree
        , selectedTopicCategory = Just "1-1"
    }


getSelectedTopicCategory : State -> Maybe Category
getSelectedTopicCategory { selectedTopicCategory, categories } =
    selectedTopicCategory
        |> Maybe.andThen
            (\id ->
                categories
                    |> RemoteData.andThen
                        (Data.TreeStore.get id)
            )


getNewTopicWithInit : String -> State -> NewTopic
getNewTopicWithInit inputId { newTopics } =
    newTopics
        |> Dict.get inputId
        |> Maybe.withDefault Model.Operation.NewTopic.init


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
                    { state
                        | newTopics = newTopics |> Dict.remove inputId
                    }
                        |> updateTopics
                            (RemoteData.update
                                (Data.TreeStore.add
                                    { topic
                                        | id = hash newContent
                                        , content = newContent
                                    }
                                )
                            )
            )
        |> Maybe.withDefault state



-- --------------------------------------------------------------------


updateTopics : (RemoteTopics -> RemoteTopics) -> State -> State
updateTopics updater ({ topics } as state) =
    { state | topics = updater topics }


createTopicTree : List Topic -> Data.TreeStore.Tree Topic
createTopicTree topics =
    Data.TreeStore.create
        { idGetter = .id
        , parentGetter = \_ -> Nothing
        , sorter = Nothing
        }
        topics


createTopicCategoryTree : List Category -> Data.TreeStore.Tree Category
createTopicCategoryTree categories =
    Data.TreeStore.create
        { idGetter = .id
        , parentGetter = .parent
        , sorter = Nothing
        }
        categories
