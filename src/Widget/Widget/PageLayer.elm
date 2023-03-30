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


module Widget.Widget.PageLayer exposing (close, create, show)

import Element
    exposing
        ( Element
        , column
        , fill
        , height
        , none
        , rgba255
        , width
        )
import Element.Background as Background
import Widget.Internal.Widget.PageLayer as Internal


type alias Config =
    {}


type alias Context a msg =
    { a | pageLayerContext : Internal.Context msg }


layouerId : String
layouerId =
    "global-page-layer"


create :
    Config
    -> Context a msg
    -> Element msg
create _ { pageLayerContext } =
    createHelper layouerId pageLayerContext


show : Element msg -> Context a msg -> msg
show el { pageLayerContext } =
    showHelper el layouerId pageLayerContext


close : Context a msg -> msg
close { pageLayerContext } =
    closeHelper layouerId pageLayerContext



-- ---------------------------------------------------


createHelper :
    String
    -> Internal.Context msg
    -> Element msg
createHelper id { getState } =
    case getState id of
        Just s ->
            case s of
                [] ->
                    none

                { content } :: _ ->
                    column
                        [ width fill
                        , height fill
                        , Background.color (rgba255 0 0 0 0.5)
                        ]
                        [ content ]

        Nothing ->
            none


showHelper :
    Element msg
    -> String
    -> Internal.Context msg
    -> msg
showHelper el id { onUpdate } =
    onUpdate id
        (\s ->
            Just ({ content = el } :: s)
        )


closeHelper :
    String
    -> Internal.Context msg
    -> msg
closeHelper id { onUpdate } =
    onUpdate id
        (\s ->
            case s of
                [] ->
                    Just []

                _ :: ls ->
                    Just ls
        )
