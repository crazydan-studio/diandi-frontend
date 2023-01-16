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

module Theme.Icon.Element exposing (icon)

import Element exposing (Color, Element, el, html, toRgb)
import Theme.Icon
import Svg.Attributes exposing (fill, height, width)


icon :
    { size : Int
    , color : Color
    }
    -> Theme.Icon.Icon
    -> Element msg
icon attr icn =
    let
        size =
            String.fromInt attr.size

        color =
            toRgb attr.color
    in
    el []
        (Theme.Icon.toHtml icn
            [ width size
            , height size

            -- Note: svg不支持rgba模式
            , fill
                ("rgb("
                    ++ ([ color.red, color.green, color.blue ]
                            |> List.indexedMap
                                (\i n ->
                                    (if i == 0 then
                                        ""

                                     else
                                        " "
                                    )
                                        ++ String.fromFloat (n * 255)
                                )
                            |> List.foldr (++) ""
                       )
                    ++ ")"
                )
            ]
            |> html
        )
