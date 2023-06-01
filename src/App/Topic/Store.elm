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


module App.Topic.Store exposing
    ( Store
    , store
    )

import App.Store.JingWei.Topic as JingWeiStore
import App.Store.Local.Topic as LocalStore
import App.Store.Mode exposing (Mode(..))
import App.Store.Msg exposing (Msg)
import App.Topic exposing (Topic)
import App.TopicFilter exposing (TopicFilter)


type alias Store =
    { query : TopicFilter -> Cmd Msg
    , count : TopicFilter -> Cmd Msg
    , add : Int -> Topic -> Cmd Msg
    , update : Int -> Topic -> Cmd Msg
    , trash : String -> Cmd Msg
    , delete : String -> Cmd Msg
    , trashRestore : String -> Cmd Msg
    , deleteFiltered : Int -> TopicFilter -> Cmd Msg
    }


store : Mode -> Store
store mode =
    case mode of
        Local ->
            { query = LocalStore.queryMyTopics
            , count = LocalStore.countMyTopics
            , add = LocalStore.saveMyNewTopic
            , update = LocalStore.saveMyEditTopic
            , trash = LocalStore.trashMyTopic
            , delete = LocalStore.deleteMyTopic
            , trashRestore = LocalStore.restoreMyTrashedTopic
            , deleteFiltered = LocalStore.deleteMyTopics
            }

        _ ->
            { query = JingWeiStore.queryMyTopics
            , count = JingWeiStore.countMyTopics
            , add = JingWeiStore.saveMyNewTopic
            , update = JingWeiStore.saveMyEditTopic
            , trash = JingWeiStore.trashMyTopic
            , delete = JingWeiStore.deleteMyTopic
            , trashRestore = JingWeiStore.restoreMyTrashedTopic
            , deleteFiltered = JingWeiStore.deleteMyTopics
            }
