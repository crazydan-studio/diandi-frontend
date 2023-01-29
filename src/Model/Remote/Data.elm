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


module Model.Remote.Data exposing
    ( Status(..)
    , andThen
    , from
    , map
    , update
    )

import Http
import I18n.Lang exposing (Lang, TranslateResult)
import Model.Remote exposing (parseError)


type Status dataType
    = LoadWaiting
    | Loading
    | Loaded dataType
    | LoadingError TranslateResult


from : Lang -> (a -> b) -> Result Http.Error a -> Status b
from lang convert result =
    case result of
        Ok data ->
            Loaded (convert data)

        Err error ->
            LoadingError (parseError lang error)


update : (a -> a) -> Status a -> Status a
update updater status =
    case status of
        Loaded a ->
            Loaded (updater a)

        _ ->
            status


map : (a -> b) -> Status a -> Maybe b
map mapper status =
    case status of
        Loaded a ->
            Just (mapper a)

        _ ->
            Nothing


andThen : (a -> Maybe b) -> Status a -> Maybe b
andThen callback status =
    case status of
        Loaded a ->
            callback a

        _ ->
            Nothing
