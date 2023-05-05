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


module View.Topic.Layer.NewTopic exposing (create)

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
            { isNew = True
            , topic = app.newTopic
            , onTitleChange =
                \text ->
                    Msg.fromApp <|
                        AppMsg.NewTopicMsg <|
                            EditTopic.TitleChanged text
            , onContentChange =
                \text ->
                    Msg.fromApp <|
                        AppMsg.NewTopicMsg <|
                            EditTopic.ContentChanged text
            , onTagDeleted =
                \tag ->
                    Msg.fromApp <|
                        AppMsg.NewTopicMsg <|
                            EditTopic.TagDeleted tag
            , onTagDone =
                Msg.fromApp <|
                    AppMsg.NewTopicMsg <|
                        EditTopic.TagDone
            , onTagChange =
                \text ->
                    Msg.fromApp <|
                        AppMsg.NewTopicMsg <|
                            EditTopic.TagChanged text
            , onEditDone =
                Msg.step
                    (Msg.fromApp <|
                        AppMsg.NewTopicSaving
                    )
                    (Msg.batch
                        [ Msg.fromApp <|
                            AppMsg.NewTopicCleaned
                        , Msg.pageLayerClose pagerId
                        ]
                    )
            , onEditDoneAndContinue =
                Msg.fromApp <|
                    AppMsg.NewTopicSaving
            , onEditCanceled =
                Msg.batch
                    [ Msg.fromApp <|
                        AppMsg.NewTopicCleaned
                    , Msg.pageLayerClose pagerId
                    ]
            }
