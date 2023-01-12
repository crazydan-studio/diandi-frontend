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
