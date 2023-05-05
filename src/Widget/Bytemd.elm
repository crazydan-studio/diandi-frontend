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


module Widget.Bytemd exposing
    ( EditorMode(..)
    , editor
    , viewer
    )

import Html exposing (Html, node)
import Html.Attributes exposing (attribute, class, placeholder, value)
import Html.Events exposing (on)
import I18n.Lang exposing (Lang(..))
import Json.Decode as Decode


type EditorMode
    = Auto
    | Split
    | Tab


type alias EditorConfig msg =
    { value : String
    , styles : List String
    , mode : EditorMode
    , lang : Lang
    , placeholder : String
    , onChange : Maybe (String -> msg)
    }


type alias ViewerConfig =
    { value : String
    , styles : List String
    , lang : Lang
    }


viewer : ViewerConfig -> Html msg
viewer config =
    node "bytemd-viewer"
        [ value config.value
        , attribute "inner-class" (config.styles |> String.join " ")
        , attribute "lang"
            (case config.lang of
                Zh_CN ->
                    "zh_Hans"

                En_US ->
                    "en"

                Default ->
                    "zh_Hans"
            )
        ]
        []


editor : EditorConfig msg -> Html msg
editor config =
    node "bytemd-editor"
        ([ value config.value

         -- 高度自适应
         , class "grow flex flex-col"
         , attribute "inner-class"
            ((config.styles
                ++ [ "grow"

                   -- 设置最小高度
                   , "h-16"
                   ]
             )
                |> String.join " "
            )
         , placeholder config.placeholder
         , attribute "lang"
            (case config.lang of
                Zh_CN ->
                    "zh_Hans"

                En_US ->
                    "en"

                Default ->
                    "zh_Hans"
            )
         , attribute "mode"
            (case config.mode of
                Auto ->
                    "auto"

                Split ->
                    "split"

                Tab ->
                    "tab"
            )
         ]
            ++ (config.onChange
                    |> Maybe.map
                        (\onChange ->
                            [ on "change"
                                (Decode.at
                                    [ "detail", "value" ]
                                    Decode.string
                                    |> Decode.andThen
                                        (\value ->
                                            Decode.succeed
                                                (onChange value)
                                        )
                                )
                            ]
                        )
                    |> Maybe.withDefault []
               )
        )
        []
