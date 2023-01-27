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
    , addTopic
    , getSelectedTopicCategory
    , init
    , loadTopicCategories
    , loadTopics
    , loading
    )

import Browser.Navigation as Nav
import Data.TreeStore
import Element.Input
import Hex
import Http
import I18n.Lang
    exposing
        ( Lang
        , TextsNeedToBeTranslated
        , TranslateResult
        )
import Model.Remote.Data as RemoteData
import Model.Topic exposing (Topic)
import Model.Topic.Category exposing (Category)
import Model.User as User
import Murmur3
import Theme.Theme as Theme exposing (Theme)
import Theme.Type.Default
import Url
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
    , topics : RemoteData.Status (Data.TreeStore.Tree Topic)
    , categories : RemoteData.Status (Data.TreeStore.Tree Category)

    -- 操作数据
    , selectedTopicCategory : Maybe String
    , topicNewInputFocused : Bool
    , topicNewInputContent : String
    , topicNewInputSelection : Maybe Element.Input.Selection
    }


type alias Config =
    { title : String
    , description : String
    , lang : String
    , navKey : Nav.Key
    , navUrl : Url.Url
    }


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
    , topicNewInputFocused = False
    , topicNewInputContent = ""
    , topicNewInputSelection = Nothing
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
    case categories of
        RemoteData.Loaded data ->
            selectedTopicCategory
                |> Maybe.andThen
                    (\id ->
                        data |> Data.TreeStore.get id
                    )

        _ ->
            Nothing


addTopic : String -> State -> State
addTopic content ({ topics } as state) =
    let
        newContent =
            content |> String.trim
    in
    if String.length newContent == 0 then
        state

    else
        case topics of
            RemoteData.Loaded data ->
                { state
                    | topics =
                        data
                            |> Data.TreeStore.add
                                { id =
                                    content
                                        |> Murmur3.hashString 2003012722
                                        |> Hex.toString
                                , superior = Nothing
                                , content = content
                                , category = Nothing
                                , tags = []
                                , color = Nothing
                                , createdAt = ""
                                }
                            |> RemoteData.Loaded
                }

            _ ->
                state



-- --------------------------------------------------------------------


createTopicTree : List Topic -> Data.TreeStore.Tree Topic
createTopicTree topics =
    Data.TreeStore.create
        { idGetter = .id
        , parentGetter = .superior
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
