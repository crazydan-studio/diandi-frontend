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


module View.Topic.Layer.EditTopic exposing (create)

import App.Msg as AppMsg
import App.Operation.EditTopic as EditTopic
import App.State as AppState
import Html exposing (Html)
import Msg exposing (Msg)
import View.Topic.Layer.TopicEditor as TopicEditor
import Widget.PageLayer as PageLayer


create : PageLayer.PagerId -> AppState.State -> Html Msg
create pagerId app =
    app
        |> TopicEditor.create
            { isNew = False
            , topic = app.editTopic
            , onTitleChange =
                \text ->
                    Msg.fromApp <|
                        AppMsg.EditTopicMsg <|
                            EditTopic.TitleChanged text
            , onContentChange =
                \text ->
                    Msg.fromApp <|
                        AppMsg.EditTopicMsg <|
                            EditTopic.ContentChanged text
            , onTagDeleted =
                \tag ->
                    Msg.fromApp <|
                        AppMsg.EditTopicMsg <|
                            EditTopic.TagDeleted tag
            , onTagDone =
                Msg.fromApp <|
                    AppMsg.EditTopicMsg <|
                        EditTopic.TagDone
            , onTagChange =
                \text ->
                    Msg.fromApp <|
                        AppMsg.EditTopicMsg <|
                            EditTopic.TagChanged text
            , onEditDone =
                Msg.step
                    (Msg.fromApp <|
                        AppMsg.EditTopicSaving
                    )
                    (Msg.batch
                        [ Msg.fromApp <|
                            AppMsg.EditTopicCleaned
                        , Msg.pageLayerClose pagerId
                        ]
                    )
            , onEditDoneAndContinue =
                Msg.fromApp <|
                    AppMsg.EditTopicSaving
            , onEditCanceled =
                Msg.batch
                    [ Msg.fromApp <|
                        AppMsg.EditTopicCleaned
                    , Msg.pageLayerClose pagerId
                    ]
            }
