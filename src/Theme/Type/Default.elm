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


module Theme.Type.Default exposing (theme)

import Element exposing (rgba255)
import Theme.Theme exposing (Theme)
import Widget.Color


theme : Theme
theme =
    { primaryFontSize = 14
    , primaryFontColor = Widget.Color.Blue600
    , secondaryFontSize = 12
    , primaryBtnColor = Widget.Color.Blue800
    , secondaryBtnColor = Widget.Color.Purple800
    , placeholderFontColor = Widget.Color.Grey500
    , primaryBorderColor = rgba255 0 0 0 0.12
    , primaryGreyBackgroundColor = rgba255 0 0 0 0.08
    }
