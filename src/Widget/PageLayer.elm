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


module Widget.PageLayer exposing
    ( Msg(..)
    , Pager
    , PagerId
    , State
    , close
    , create
    , init
    , open
    , update
    )

import Html exposing (Html, div)
import Html.Attributes exposing (class)


type alias State app msg =
    { pagers : List ( PagerId, Pager app msg )
    , nextId : PagerId
    }


type alias Pager app msg =
    PagerId -> app -> Html msg


type alias PagerId =
    Int


type Msg app msg
    = Open (Pager app msg)
    | Close PagerId


init : State app msg
init =
    { pagers = []
    , nextId = 0
    }


update : Msg app msg -> State app msg -> State app msg
update msg ({ pagers, nextId } as state) =
    case msg of
        Open pager ->
            { state
                | pagers = ( nextId, pager ) :: pagers
                , nextId = nextId + 1
            }

        Close pagerId ->
            { state
                | pagers =
                    pagers
                        |> List.filter (\( id, _ ) -> pagerId /= id)
            }


create : State app msg -> app -> Html msg
create { pagers } app =
    case pagers of
        [] ->
            div [] []

        ( id, pager ) :: _ ->
            div
                [ class "absolute z-50"
                , class "flex"
                , class "justify-center"
                , class "w-full h-full"
                , class "bg-black/60 dark:bg-black/50"
                ]
                [ pager id app ]


open : (Msg app msg -> msg) -> Pager app msg -> msg
open toMsg pager =
    toMsg (Open pager)


close : (Msg app msg -> msg) -> PagerId -> msg
close toMsg pagerId =
    toMsg (Close pagerId)
