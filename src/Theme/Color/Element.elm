module Theme.Color.Element exposing
    ( customPalette
    , defaultPalette
    , toRgbColor
    , toRgbaColor
    )

import Element
import Element.Background
import Element.Font
import Theme.Color exposing (Color(..), fgColorForBg, toRgb)


defaultPalette : Color -> List (Element.Attribute msg)
defaultPalette bg =
    customPalette bg (fgColorForBg bg)


customPalette : Color -> Color -> List (Element.Attribute msg)
customPalette bg fg =
    [ Element.Background.color (toRgbColor bg)
    , Element.Font.color (toRgbColor fg)
    ]


toRgbColor : Color -> Element.Color
toRgbColor c =
    toRgbaColor c 1


toRgbaColor : Color -> Float -> Element.Color
toRgbaColor c a =
    let
        { r, g, b } =
            toRgb c
    in
    Element.rgba255 r g b a
