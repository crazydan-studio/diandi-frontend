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
import Theme.Theme as Theme exposing (Theme)


{-| 设置边的主样式
-}
each :
    { top : Int
    , left : Int
    , right : Int
    , bottom : Int
    }
    -> Theme
    -> List (Attribute msg)
each size theme =
    [ Border.solid
    , Border.color (Theme.primaryBorderColor theme)
    , Border.widthEach size
    ]


all :
    Int
    -> Theme
    -> List (Attribute msg)
all size =
    each
        { top = size
        , left = size
        , right = size
        , bottom = size
        }


top :
    Int
    -> Theme
    -> List (Attribute msg)
top size =
    each
        { top = size
        , left = 0
        , right = 0
        , bottom = 0
        }


bottom :
    Int
    -> Theme
    -> List (Attribute msg)
bottom size =
    each
        { top = 0
        , left = 0
        , right = 0
        , bottom = size
        }


left :
    Int
    -> Theme
    -> List (Attribute msg)
left size =
    each
        { top = 0
        , left = size
        , right = 0
        , bottom = 0
        }


right :
    Int
    -> Theme
    -> List (Attribute msg)
right size =
    each
        { top = 0
        , left = 0
        , right = size
        , bottom = 0
        }
