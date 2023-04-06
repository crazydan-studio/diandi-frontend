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


module View.Page.Layer.EditTopic exposing (create)

import Element exposing (..)
import Model
import Model.Operation.EditTopic as EditTopic
import Msg
import View.Page as Page
import View.Page.Layer.TopicEditor as TopicEditor


create : Model.State -> Element Msg.Msg
create ({ app } as state) =
    case app.editTopic of
        Nothing ->
            none

        Just editTopic ->
            let
                msgWith =
                    Msg.EditTopic editTopic.id
            in
            state
                |> TopicEditor.create
                    { isNew = False
                    , topic = app.editTopic
                    , onTitleChange =
                        \text ->
                            msgWith (EditTopic.TitleChanged text)
                    , onContentPreviewedChange =
                        \checked ->
                            msgWith
                                (EditTopic.ContentPreviewed
                                    checked
                                )
                    , onContentChange =
                        \text ->
                            msgWith (EditTopic.ContentChanged text)
                    , onTagDeleted = \tag -> msgWith (EditTopic.TagDeleted tag)
                    , onTagDone = msgWith EditTopic.TagDone
                    , onTagChange =
                        \text ->
                            msgWith (EditTopic.TagChanged text)
                    , onEditDone =
                        Msg.EditTopicUpdated editTopic.id
                    , onEditCanceled =
                        Msg.ClosePageLayer Page.EditTopicLayer
                    }
