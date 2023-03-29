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


module Widget.Shadow exposing (hover, normal)

import Element exposing (Attr, rgba255)
import Element.Border as Border


normal : Attr a b
normal =
    -- https://v4.mui.com/components/cards/
    -- box-shadow: 0px 3px 1px -2px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 1px 5px 0px rgba(0,0,0,0.12);
    Border.shadows
        [ { inset = False
          , offset = ( 0, 3 )
          , blur = 1
          , size = -2
          , color = rgba255 0 0 0 0.2
          }
        , { inset = False
          , offset = ( 0, 2 )
          , blur = 2
          , size = 0
          , color = rgba255 0 0 0 0.14
          }
        , { inset = False
          , offset = ( 0, 1 )
          , blur = 5
          , size = 0
          , color = rgba255 0 0 0 0.12
          }
        ]


hover : Attr a b
hover =
    -- box-shadow: 0px 2px 4px -1px rgba(0,0,0,0.2),0px 4px 5px 0px rgba(0,0,0,0.14),0px 1px 10px 0px rgba(0,0,0,0.12);
    Border.shadows
        [ { inset = False
          , offset = ( 0, 2 )
          , blur = 4
          , size = -1
          , color = rgba255 0 0 0 0.2
          }
        , { inset = False
          , offset = ( 0, 4 )
          , blur = 5
          , size = 0
          , color = rgba255 0 0 0 0.14
          }
        , { inset = False
          , offset = ( 0, 1 )
          , blur = 10
          , size = 0
          , color = rgba255 0 0 0 0.12
          }
        ]
