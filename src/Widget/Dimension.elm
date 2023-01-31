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


module Widget.Dimension exposing
    ( Dimension
    , all
    , bottom
    , horizontal
    , left
    , none
    , right
    , top
    , vertical
    )


type alias Dimension =
    { top : Int
    , left : Int
    , right : Int
    , bottom : Int
    }


all : Int -> Dimension
all size =
    { top = size
    , left = size
    , right = size
    , bottom = size
    }


none : Dimension
none =
    all 0


top : Int -> Dimension
top size =
    { top = size
    , left = 0
    , right = 0
    , bottom = 0
    }


bottom : Int -> Dimension
bottom size =
    { top = 0
    , left = 0
    , right = 0
    , bottom = size
    }


left : Int -> Dimension
left size =
    { top = 0
    , left = size
    , right = 0
    , bottom = 0
    }


right : Int -> Dimension
right size =
    { top = 0
    , left = 0
    , right = size
    , bottom = 0
    }


vertical : Int -> Dimension
vertical size =
    { top = size
    , left = 0
    , right = 0
    , bottom = size
    }


horizontal : Int -> Dimension
horizontal size =
    { top = 0
    , left = size
    , right = size
    , bottom = 0
    }
