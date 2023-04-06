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


module View.Page.Layer.NewTopic exposing (create)

import Element exposing (..)
import Model
import Model.Operation.EditTopic as EditTopic
import Msg
import View.Page as Page
import View.Page.Layer.TopicEditor as TopicEditor


create : Model.State -> Element Msg.Msg
create ({ app } as state) =
    state
        |> TopicEditor.create
            { isNew = True
            , topic = app.newTopic
            , onTitleChange =
                \text ->
                    Msg.NewTopicMsg (EditTopic.TitleChanged text)
            , onContentPreviewedChange =
                \checked ->
                    Msg.NewTopicMsg
                        (EditTopic.ContentPreviewed
                            checked
                        )
            , onContentChange =
                \text ->
                    Msg.NewTopicMsg (EditTopic.ContentChanged text)
            , onTagDeleted = \tag -> Msg.NewTopicMsg (EditTopic.TagDeleted tag)
            , onTagDone = Msg.NewTopicMsg EditTopic.TagDone
            , onTagChange =
                \text ->
                    Msg.NewTopicMsg (EditTopic.TagChanged text)
            , onEditDone = Msg.NewTopicAdding
            , onEditCanceled =
                Msg.batch
                    [ Msg.NewTopicCleaned
                    , Msg.ClosePageLayer Page.NewTopicLayer
                    ]
            }
