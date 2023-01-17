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


module Widget.Msg exposing (Msg(..), WidgetUpdateConfig)

import Widget.Model.Button as Button


type Msg
    = -- TODO 数据删除消息需包装一次，携带组件id和业务消息，并先移除组件状态，
      -- 再触发业务消息，同时支持批量删除消息
      UpdateButtonState (WidgetUpdateConfig Button.State)


type alias WidgetUpdateConfig widgetState =
    { -- 组件唯一标识，同类型的不同组件不允许相同，否则组件状态会被相互覆盖
      id : String

    -- 组件状态初始化函数，其在首次触发组件更新时调用
    , init : () -> widgetState

    -- 组件状态更新函数，若返回Nothing，则表示需移除该状态
    , update : widgetState -> Maybe widgetState
    }
