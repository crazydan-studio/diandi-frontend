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


module View.Page.Home exposing (view)

import Element exposing (..)
import Element.Border as Border
import Model
import Msg
import View.Page.Home.Center as Center
import View.Page.Home.Left as Left
import View.Page.Home.Right as Right


view : Model.State -> Element Msg.Msg
view state =
    row
        [ width fill
        , height fill
        ]
        [ el
            [ width (px 256)
            , height fill
            ]
            (Left.view state)
        , el
            [ width fill
            , height fill

            -- box-shadow: 0px 2px 4px -1px rgba(0,0,0,0.2),0px 4px 5px 0px rgba(0,0,0,0.14),0px 1px 10px 0px rgba(0,0,0,0.12);
            , Border.shadows
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
            ]
            (Center.view state)
        , el
            [ width (px (128 * 4))
            , height fill
            ]
            (Right.view state)
        ]
