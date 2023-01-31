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


module View.Style.Base exposing
    ( spacing
    , spacing2x
    , spacing3x
    , spacing8x
    )

{-| -}


{-| 留白
-}
spacing : Int
spacing =
    8


{-| 2倍留白
-}
spacing2x : Int
spacing2x =
    spacing * 2


{-| 3倍留白
-}
spacing3x : Int
spacing3x =
    spacing * 3


{-| 8倍留白
-}
spacing8x : Int
spacing8x =
    spacing * 8
