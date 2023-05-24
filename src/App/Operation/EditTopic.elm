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


module App.Operation.EditTopic exposing
    ( EditTopic
    , Msg(..)
    , clean
    , error
    , from
    , hasError
    , info
    , init
    , patch
    , to
    , update
    )

import App.Error as Error exposing (Error)
import App.Topic as Topic exposing (Topic)
import I18n.Translator exposing (TranslateResult)
import Widget.Util.Basic exposing (appendToUniqueList, removeFromList, trim)


type alias EditTopic =
    { id : String
    , content : String
    , title : String
    , tags : List String
    , taging : String
    , updating : Bool
    , error : Error
    }


type Msg
    = TitleChanged String
    | ContentChanged String
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
    , updating = False
    , error = Error.none
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


to : EditTopic -> Topic
to editTopic =
    let
        topic =
            Topic.init
    in
    { topic
        | content = editTopic.content |> String.trim
        , title = editTopic.title |> trim
        , tags = editTopic.tags
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
        , updating = False
        , error = Error.none
    }


error : TranslateResult -> EditTopic -> EditTopic
error error_ editTopic =
    { editTopic | error = Error.error error_ }


info : TranslateResult -> EditTopic -> EditTopic
info info_ editTopic =
    { editTopic | error = Error.info info_ }


hasError : EditTopic -> Bool
hasError editTopic =
    Error.isError editTopic.error


update : Msg -> EditTopic -> EditTopic
update msg editTopic =
    case msg of
        TitleChanged title ->
            { editTopic
                | title = title
                , error = Error.none
            }

        ContentChanged content ->
            { editTopic
                | content = content
                , error = Error.none
            }

        TagChanged tag ->
            { editTopic
                | taging = tag
                , error = Error.none
            }

        TagDeleted tag ->
            { editTopic
                | tags =
                    editTopic.tags
                        |> removeFromList tag
                , error = Error.none
            }

        TagDone ->
            trim editTopic.taging
                |> Maybe.map
                    (\taging ->
                        { editTopic
                            | tags =
                                editTopic.tags
                                    |> appendToUniqueList taging
                            , taging = ""
                        }
                    )
                |> Maybe.withDefault editTopic
