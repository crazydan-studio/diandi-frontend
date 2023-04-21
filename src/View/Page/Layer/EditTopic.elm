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

import Html exposing (Html)
import Model
import Model.Operation.EditTopic as EditTopic
import Msg
import View.Page as Page
import View.Page.Layer.TopicEditor as TopicEditor


create : Model.State -> Html Msg.Msg
create ({ app } as state) =
    state
        |> TopicEditor.create
            { isNew = False
            , topic = app.editTopic
            , onTitleChange =
                \text ->
                    Msg.EditTopicMsg (EditTopic.TitleChanged text)
            , onContentChange =
                \text ->
                    Msg.EditTopicMsg (EditTopic.ContentChanged text)
            , onTagDeleted = \tag -> Msg.EditTopicMsg (EditTopic.TagDeleted tag)
            , onTagDone = Msg.EditTopicMsg EditTopic.TagDone
            , onTagChange =
                \text ->
                    Msg.EditTopicMsg (EditTopic.TagChanged text)
            , onEditDone =
                Msg.EditTopicSaving
            , onEditCanceled =
                Msg.batch
                    [ Msg.EditTopicCleaned
                    , Msg.ClosePageLayer Page.EditTopicLayer
                    ]
            }
