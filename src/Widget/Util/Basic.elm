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


module Widget.Util.Basic exposing
    ( fromMaybe
    , trim
    )


trim : String -> Maybe String
trim str =
    let
        trimmedStr =
            String.trim str
    in
    if String.isEmpty trimmedStr then
        Nothing

    else
        Just trimmedStr


fromMaybe : a -> (b -> a) -> Maybe b -> a
fromMaybe default_ getter maybe =
    case maybe of
        Nothing ->
            default_

        Just m ->
            getter m
