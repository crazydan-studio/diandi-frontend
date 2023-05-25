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


module App.TopicCard exposing
    ( Msg(..)
    , TopicCard
    , TopicCardOp(..)
    , create
    , getOpStatus
    , update
    )

import App.Operation as Operation
import App.Topic exposing (Topic)


type alias TopicCard =
    { topic : Topic
    , config : Config
    , op : TopicCardOp
    }


type Msg
    = Expand Bool
    | Select Bool
    | Trash Operation.Status
    | Delete Operation.Status
    | Restore Operation.Status


type alias Config =
    { expanded : Bool
    , selected : Bool
    }


type TopicCardOp
    = TrashOp Operation.Status
    | DeleteOp Operation.Status
    | RestoreOp Operation.Status
    | None


create : Topic -> TopicCard
create topic =
    { topic = topic
    , config =
        { expanded = False
        , selected = False
        }
    , op = None
    }


update : Msg -> TopicCard -> TopicCard
update msg ({ config } as topicCard) =
    case msg of
        Expand expanded ->
            { topicCard
                | config =
                    { config
                        | expanded = expanded
                    }
            }

        Select selected ->
            { topicCard
                | config =
                    { config
                        | selected = selected
                    }
            }

        Trash op ->
            { topicCard | op = TrashOp op }

        Delete op ->
            { topicCard | op = DeleteOp op }

        Restore op ->
            { topicCard | op = RestoreOp op }


getOpStatus : TopicCardOp -> Operation.Status
getOpStatus op =
    case op of
        TrashOp o ->
            o

        DeleteOp o ->
            o

        RestoreOp o ->
            o

        _ ->
            Operation.NoOp
