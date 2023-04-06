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


module Model.Operation.EditTopic exposing
    ( EditTopic
    , Msg(..)
    , clean
    , error
    , from
    , hasError
    , init
    , patch
    , update
    )

import Model.Topic exposing (Topic)
import Widget.Util.Basic exposing (trim)


type alias EditTopic =
    { id : String
    , content : String
    , title : String
    , tags : List String
    , taging : String
    , previewed : Bool
    , error : String
    }


type Msg
    = TitleChanged String
    | ContentChanged String
    | ContentPreviewed Bool
    | TagChanged String
    | TagDeleted String
    | TagDone


init : EditTopic
init =
    { id = ""
    , content = ""
    , title = ""
    , tags = []
    , taging = ""
    , previewed = False
    , error = ""
    }


from : Topic -> EditTopic
from topic =
    { init
        | id = topic.id
        , content = topic.content
        , title =
            topic.title
                |> Maybe.withDefault ""
        , tags = topic.tags
    }


patch : EditTopic -> Topic -> Topic
patch editTopic topic =
    { topic
        | content = editTopic.content |> String.trim
        , title = editTopic.title |> trim
        , tags = editTopic.tags
    }


clean : EditTopic -> EditTopic
clean editTopic =
    { editTopic
        | content = ""
        , title = ""

        -- Note: 复用上次的标签
        -- , tags = []
        , error = ""
    }


error : String -> EditTopic -> EditTopic
error error_ editTopic =
    { editTopic | error = error_ }


hasError : EditTopic -> Bool
hasError editTopic =
    not (String.isEmpty editTopic.error)


update : Msg -> EditTopic -> EditTopic
update msg editTopic =
    case msg of
        TitleChanged title ->
            { editTopic | title = title }

        ContentChanged content ->
            { editTopic
                | content = content
                , error = ""
            }

        ContentPreviewed enabled ->
            { editTopic
                | previewed = enabled
            }

        TagChanged tag ->
            { editTopic
                | taging = tag
            }

        TagDeleted tag ->
            { editTopic
                | tags =
                    editTopic.tags
                        |> List.filter ((/=) tag)
            }

        TagDone ->
            trim editTopic.taging
                |> Maybe.map
                    (\taging ->
                        { editTopic
                            | tags =
                                (editTopic.tags
                                    |> List.filter ((/=) taging)
                                )
                                    ++ [ taging ]
                            , taging = ""
                        }
                    )
                |> Maybe.withDefault editTopic
