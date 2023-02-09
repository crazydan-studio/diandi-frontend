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


module Widget.Widget exposing
    ( Builder
    , Msg
    , State
    , Updater
    , WithContext
    , init
    , update
    )

import Dict exposing (Dict)
import Element exposing (Element)
import Widget.Internal.Widget.Button as Button
import Widget.Internal.Widget.FixedImage as FixedImage
import Widget.Internal.Widget.TextEditor as TextEditor


type State msg
    = State (Config msg) WidgetStates


type alias Builder msg =
    Context msg -> Element msg


type alias Updater msg =
    State msg -> ( State msg, WithContext msg )


type alias WithContext msg =
    Builder msg -> Element msg


type alias Config msg =
    { toAppMsg : Msg -> msg
    }


type alias WidgetStateStore state =
    -- <widget id>: <widget state>
    Dict String state


type alias WidgetStates =
    { button : WidgetStateStore Button.State
    , fixedImage : WidgetStateStore FixedImage.State
    , textEditor : WidgetStateStore TextEditor.State
    }


type alias Context msg =
    { buttonContext : Button.Context msg
    , fixedImageContext : FixedImage.Context msg
    , textEditorContext : TextEditor.Context msg
    }


type Msg
    = -- TODO 数据删除消息需包装一次，携带组件id和业务消息，并先移除组件状态，
      -- 再触发业务消息，同时支持批量删除消息。或者，采用js监听节点移除消息，再通过组件id和类型做清理？
      UpdateButtonMsg String (Maybe Button.State)
    | UpdateFixedImageMsg String (Maybe FixedImage.State)
    | UpdateTextEditorMsg String (Maybe TextEditor.State)


update : Msg -> State appMsg -> ( State appMsg, WithContext appMsg )
update msg (State config widgets) =
    toResult <|
        State config (updateByMsg msg widgets)


init : Config appMsg -> ( State appMsg, WithContext appMsg )
init config =
    toResult <|
        State config
            { button = Dict.empty
            , fixedImage = Dict.empty
            , textEditor = Dict.empty
            }


createContext : Config appMsg -> WidgetStates -> Context appMsg
createContext { toAppMsg } widgets =
    let
        getState getter id =
            widgets |> getter |> Dict.get id

        onUpdate getter initer toMsg id updater =
            getState getter id
                |> Maybe.withDefault initer
                |> updater
                |> toMsg id
                |> toAppMsg

        contextWith getter initer toMsg =
            { getState = getState getter
            , onUpdate = onUpdate getter initer toMsg
            }
    in
    { buttonContext =
        contextWith .button Button.init UpdateButtonMsg
    , fixedImageContext =
        contextWith .fixedImage FixedImage.init UpdateFixedImageMsg
    , textEditorContext =
        contextWith .textEditor TextEditor.init UpdateTextEditorMsg
    }


updateByMsg : Msg -> WidgetStates -> WidgetStates
updateByMsg msg widgets =
    let
        update_ getter id state =
            getter widgets
                |> (state
                        -- 更新状态
                        |> Maybe.map (Dict.insert id)
                        -- 删除状态
                        |> Maybe.withDefault (Dict.remove id)
                   )
    in
    case msg of
        UpdateButtonMsg id state ->
            { widgets | button = update_ .button id state }

        UpdateFixedImageMsg id state ->
            { widgets | fixedImage = update_ .fixedImage id state }

        UpdateTextEditorMsg id state ->
            { widgets | textEditor = update_ .textEditor id state }



-- -------------------------------------------------------------


withContext : State appMsg -> Builder appMsg -> Element appMsg
withContext (State config widgets) widgetor =
    widgets |> createContext config |> widgetor


toResult : State appMsg -> ( State appMsg, WithContext appMsg )
toResult state =
    ( state, withContext state )
