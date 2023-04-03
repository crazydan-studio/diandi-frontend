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


module Model.Operation.NewTopic exposing
    ( Msg(..)
    , NewTopic
    , init
    , update
    )


type alias NewTopic =
    { content : String
    , title : String
    , tags : List String
    , taging : String
    , error : String
    }


type Msg
    = TitleChanged String
    | ContentChanged String
    | TagChanged String
    | TagDone


init : NewTopic
init =
    { content = ""
    , title = ""
    , tags = []
    , taging = ""
    , error = ""
    }


update : Msg -> NewTopic -> NewTopic
update msg newTopic =
    case msg of
        TitleChanged title ->
            { newTopic | title = title }

        ContentChanged content ->
            { newTopic
                | content = content
                , error = ""
            }

        TagChanged tag ->
            { newTopic
                | taging = tag
            }

        TagDone ->
            { newTopic
                | tags = newTopic.tags ++ [ newTopic.taging ]
                , taging = ""
            }
