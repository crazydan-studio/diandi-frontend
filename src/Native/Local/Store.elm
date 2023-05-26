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


module Native.Local.Store exposing (execute)

-- https://github.com/lobanov/elm-localstorage/blob/1.0.1/src/LocalStorage.elm

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Task
import TaskPort
    exposing
        ( QualifiedName
        , inNamespace
        )


moduleVersion : String
moduleVersion =
    "0.1.0"


inNS : String -> QualifiedName
inNS =
    inNamespace "elm-native/localstore" moduleVersion


execute :
    { path : String
    , args : Encode.Value
    }
    -> (Result Http.Error a -> msg)
    -> Decode.Decoder a
    -> Cmd msg
execute { path, args } toMsg decoder =
    TaskPort.callNS
        { function = inNS path
        , valueDecoder = decoder
        , argsEncoder =
            \_ ->
                Encode.object [ ( "args", args ) ]
        }
        ()
        |> Task.onError
            (\error ->
                Task.fail
                    (Http.BadBody
                        (TaskPort.errorToString error)
                    )
            )
        |> Task.andThen Task.succeed
        |> Task.attempt toMsg
