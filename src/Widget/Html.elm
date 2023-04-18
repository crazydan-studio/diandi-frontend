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


module Widget.Html exposing
    ( onClickOutOfMe
    , onEnter
    , onInputBlur
    , template
    , toRgba
    )

import Element
    exposing
        ( Attribute
        , Color
        , toRgb
        )
import Element.Events as Event
import Element.Input as Input
import Html
import Html.Events as HtmlEvent
import Json.Decode as Decode


toRgba : Color -> String
toRgba color =
    let
        { red, green, blue, alpha } =
            toRgb color
    in
    "rgba("
        ++ ([ red * 255
            , green * 255
            , blue * 255
            , alpha
            ]
                |> List.map
                    (\n ->
                        String.fromFloat n
                    )
                |> String.join ","
           )
        ++ ")"


onClickOutOfMe : msg -> Attribute msg
onClickOutOfMe msg =
    Event.on "clickOutOfMe"
        (Decode.succeed msg)


onInputBlur : (Input.Selection -> msg) -> Attribute msg
onInputBlur toMsg =
    Event.on "blur"
        (Input.selectionDecoder
            |> Decode.map toMsg
        )


onEnter : msg -> Html.Attribute msg
onEnter msg =
    HtmlEvent.on "keyup"
        (Decode.field "key" Decode.string
            |> Decode.andThen
                (\key ->
                    if key == "Enter" then
                        Decode.succeed msg

                    else
                        Decode.fail "Not the enter key"
                )
        )


template : List ( String, String ) -> String -> String
template data tpl =
    data
        |> List.foldl
            (\( name, value ) t ->
                t
                    |> String.replace
                        ("{{" ++ name ++ "}}")
                        value
            )
            tpl
