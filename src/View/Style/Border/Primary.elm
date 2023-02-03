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


module View.Style.Border.Primary exposing
    ( all
    , bottom
    , each
    , left
    , right
    , top
    )

import Element exposing (Attribute)
import Element.Border as Border
import Theme.Theme exposing (Theme)
import Widget.Dimension as Dimension exposing (Dimension)


{-| 设置边的主样式
-}
each :
    Dimension
    -> Theme msg
    -> List (Attribute msg)
each size theme =
    [ Border.solid
    , Border.color theme.primaryBorderColor
    , Border.widthEach size
    ]


all :
    Int
    -> Theme msg
    -> List (Attribute msg)
all size =
    each (Dimension.all size)


top :
    Int
    -> Theme msg
    -> List (Attribute msg)
top size =
    each (Dimension.top size)


bottom :
    Int
    -> Theme msg
    -> List (Attribute msg)
bottom size =
    each (Dimension.bottom size)


left :
    Int
    -> Theme msg
    -> List (Attribute msg)
left size =
    each (Dimension.left size)


right :
    Int
    -> Theme msg
    -> List (Attribute msg)
right size =
    each (Dimension.right size)
