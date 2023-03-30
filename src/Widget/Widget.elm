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
    ( Msg
    , Updater
    , Widgets
    , init
    , sub
    , update
    )

import Dict exposing (Dict)
import Element exposing (Element)
import Widget.Internal.Widget.Button as Button
import Widget.Internal.Widget.FixedImage as FixedImage
import Widget.Internal.Widget.PageLayer as PageLayer
import Widget.Internal.Widget.TextEditor as TextEditor


type alias Widgets msg =
    { -- 组件库配置及组件集状态
      state : State msg

    -- 向组件构造器传递 Context
    , with : WithWidget msg

    -- 发送组件消息
    , on : WithMsg msg
    }


type alias Updater msg =
    Widgets msg -> UpdateResult msg


type Msg msg
    = -- TODO 数据删除消息需包装一次，携带组件id和业务消息，并先移除组件状态，
      -- 再触发业务消息，同时支持批量删除消息。或者，采用js监听节点移除消息，再通过组件id和类型做清理？
      UpdateButtonMsg String (Maybe Button.State)
    | UpdateFixedImageMsg String (Maybe FixedImage.State)
    | UpdateTextEditorMsg String (Maybe TextEditor.State)
    | TextEditorFocusOnMsg String
    | UpdatePageLayerMsg String (Maybe (PageLayer.State msg))


type alias WidgetStates msg =
    { button : WidgetStateStore Button.State
    , fixedImage : WidgetStateStore FixedImage.State
    , textEditor : WidgetStateStore TextEditor.State
    , pageLayer : WidgetStateStore (PageLayer.State msg)
    }


type alias WidgetContext msg =
    { buttonContext : Button.Context msg
    , fixedImageContext : FixedImage.Context msg
    , textEditorContext : TextEditor.Context msg
    , pageLayerContext : PageLayer.Context msg
    }


type State msg
    = State (Config msg) (WidgetStates msg)


type alias Config msg =
    { toAppMsg : Msg msg -> msg
    }


type alias WidgetBuilder msg =
    WidgetContext msg -> Element msg


type alias MsgBuilder msg =
    WidgetContext msg -> msg


type alias UpdateResult msg =
    ( Widgets msg, Cmd msg )


type alias WithWidget msg =
    WidgetBuilder msg -> Element msg


type alias WithMsg msg =
    MsgBuilder msg -> msg


type alias WidgetStateStore state =
    -- <widget id>: <widget state>
    Dict String state


update :
    Msg appMsg
    -> Widgets appMsg
    -> UpdateResult appMsg
update msg { state } =
    let
        (State config _) =
            state

        ( widgetStates, cmd ) =
            updateByMsg msg state
    in
    toResult <|
        ( State config widgetStates, cmd )


sub : Widgets appMsg -> Sub appMsg
sub { state } =
    Sub.batch
        []


init :
    Config appMsg
    -> UpdateResult appMsg
init config =
    toResult <|
        ( State config
            { button = Dict.empty
            , fixedImage = Dict.empty
            , textEditor = Dict.empty
            , pageLayer = Dict.empty
            }
        , Cmd.none
        )



-- -----------------------------------------------------


createContext :
    Config appMsg
    -> WidgetStates appMsg
    -> WidgetContext appMsg
createContext { toAppMsg } widgetStates =
    let
        getState getter id =
            widgetStates |> getter |> Dict.get id

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
    , pageLayerContext =
        contextWith .pageLayer PageLayer.init UpdatePageLayerMsg
    }


updateByMsg :
    Msg appMsg
    -> State appMsg
    -> ( WidgetStates appMsg, Cmd appMsg )
updateByMsg msg (State { toAppMsg } widgetStates) =
    let
        update_ getter id widgetState =
            getter widgetStates
                |> (widgetState
                        -- 更新状态
                        |> Maybe.map (Dict.insert id)
                        -- 删除状态
                        |> Maybe.withDefault (Dict.remove id)
                   )
    in
    case msg of
        UpdateButtonMsg id state ->
            ( { widgetStates | button = update_ .button id state }
            , Cmd.none
            )

        UpdateFixedImageMsg id state ->
            ( { widgetStates | fixedImage = update_ .fixedImage id state }
            , Cmd.none
            )

        UpdateTextEditorMsg id state ->
            ( { widgetStates | textEditor = update_ .textEditor id state }
            , TextEditor.focuseOn id
                (\input ->
                    toAppMsg (TextEditorFocusOnMsg input)
                )
                state
            )

        TextEditorFocusOnMsg _ ->
            ( widgetStates, Cmd.none )

        UpdatePageLayerMsg id state ->
            ( { widgetStates | pageLayer = update_ .pageLayer id state }
            , Cmd.none
            )



-- -------------------------------------------------------------


withWidget :
    WidgetContext appMsg
    -> WidgetBuilder appMsg
    -> Element appMsg
withWidget ctx widgetor =
    ctx |> widgetor


withMsg :
    WidgetContext appMsg
    -> MsgBuilder appMsg
    -> appMsg
withMsg ctx toAppMsg =
    ctx |> toAppMsg


toContext : State appMsg -> WidgetContext appMsg
toContext (State config widgetStates) =
    widgetStates |> createContext config


toResult :
    ( State appMsg, Cmd appMsg )
    -> UpdateResult appMsg
toResult ( state, cmd ) =
    let
        ctx =
            toContext state
    in
    ( { state = state
      , with = withWidget ctx
      , on = withMsg ctx
      }
    , cmd
    )
