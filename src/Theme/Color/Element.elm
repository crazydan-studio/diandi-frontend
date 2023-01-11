module Theme.Color.Element exposing
    ( customPalette
    , defaultPalette
    , toRgbColor
    , toRgbaColor
    )

import Element
import Element.Background
import Element.Font
import Theme.Color exposing (Color(..), toRgb)


defaultPalette : Color -> List (Element.Attribute msg)
defaultPalette bg =
    customPalette bg (defaultPaletteFgColor bg)


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


defaultPaletteFgColor : Color -> Color
defaultPaletteFgColor bg =
    case bg of
        Red50 ->
            Black

        Red100 ->
            Black

        Red200 ->
            Black

        Red300 ->
            White

        Red400 ->
            White

        Red500 ->
            White

        Red600 ->
            White

        Red700 ->
            White

        Red800 ->
            White

        Red900 ->
            White

        RedA100 ->
            Black

        RedA200 ->
            White

        RedA400 ->
            White

        RedA700 ->
            White

        Pink50 ->
            Black

        Pink100 ->
            Black

        Pink200 ->
            Black

        Pink300 ->
            White

        Pink400 ->
            White

        Pink500 ->
            White

        Pink600 ->
            White

        Pink700 ->
            White

        Pink800 ->
            White

        Pink900 ->
            White

        PinkA100 ->
            Black

        PinkA200 ->
            White

        PinkA400 ->
            White

        PinkA700 ->
            White

        Purple50 ->
            Black

        Purple100 ->
            Black

        Purple200 ->
            Black

        Purple300 ->
            White

        Purple400 ->
            White

        Purple500 ->
            White

        Purple600 ->
            White

        Purple700 ->
            White

        Purple800 ->
            White

        Purple900 ->
            White

        PurpleA100 ->
            Black

        PurpleA200 ->
            White

        PurpleA400 ->
            White

        PurpleA700 ->
            White

        DeepPurple50 ->
            Black

        DeepPurple100 ->
            Black

        DeepPurple200 ->
            Black

        DeepPurple300 ->
            White

        DeepPurple400 ->
            White

        DeepPurple500 ->
            White

        DeepPurple600 ->
            White

        DeepPurple700 ->
            White

        DeepPurple800 ->
            White

        DeepPurple900 ->
            White

        DeepPurpleA100 ->
            Black

        DeepPurpleA200 ->
            White

        DeepPurpleA400 ->
            White

        DeepPurpleA700 ->
            White

        Indigo50 ->
            Black

        Indigo100 ->
            Black

        Indigo200 ->
            Black

        Indigo300 ->
            White

        Indigo400 ->
            White

        Indigo500 ->
            White

        Indigo600 ->
            White

        Indigo700 ->
            White

        Indigo800 ->
            White

        Indigo900 ->
            White

        IndigoA100 ->
            Black

        IndigoA200 ->
            White

        IndigoA400 ->
            White

        IndigoA700 ->
            White

        Blue50 ->
            Black

        Blue100 ->
            Black

        Blue200 ->
            Black

        Blue300 ->
            Black

        Blue400 ->
            White

        Blue500 ->
            White

        Blue600 ->
            White

        Blue700 ->
            White

        Blue800 ->
            White

        Blue900 ->
            White

        BlueA100 ->
            Black

        BlueA200 ->
            White

        BlueA400 ->
            White

        BlueA700 ->
            White

        LightBlue50 ->
            Black

        LightBlue100 ->
            Black

        LightBlue200 ->
            Black

        LightBlue300 ->
            Black

        LightBlue400 ->
            Black

        LightBlue500 ->
            White

        LightBlue600 ->
            White

        LightBlue700 ->
            White

        LightBlue800 ->
            White

        LightBlue900 ->
            White

        LightBlueA100 ->
            Black

        LightBlueA200 ->
            Black

        LightBlueA400 ->
            Black

        LightBlueA700 ->
            White

        Cyan50 ->
            Black

        Cyan100 ->
            Black

        Cyan200 ->
            Black

        Cyan300 ->
            Black

        Cyan400 ->
            Black

        Cyan500 ->
            White

        Cyan600 ->
            White

        Cyan700 ->
            White

        Cyan800 ->
            White

        Cyan900 ->
            White

        CyanA100 ->
            Black

        CyanA200 ->
            Black

        CyanA400 ->
            Black

        CyanA700 ->
            Black

        Teal50 ->
            Black

        Teal100 ->
            Black

        Teal200 ->
            Black

        Teal300 ->
            Black

        Teal400 ->
            White

        Teal500 ->
            White

        Teal600 ->
            White

        Teal700 ->
            White

        Teal800 ->
            White

        Teal900 ->
            White

        TealA100 ->
            Black

        TealA200 ->
            Black

        TealA400 ->
            Black

        TealA700 ->
            Black

        Green50 ->
            Black

        Green100 ->
            Black

        Green200 ->
            Black

        Green300 ->
            Black

        Green400 ->
            White

        Green500 ->
            White

        Green600 ->
            White

        Green700 ->
            White

        Green800 ->
            White

        Green900 ->
            White

        GreenA100 ->
            Black

        GreenA200 ->
            Black

        GreenA400 ->
            Black

        GreenA700 ->
            Black

        LightGreen50 ->
            Black

        LightGreen100 ->
            Black

        LightGreen200 ->
            Black

        LightGreen300 ->
            Black

        LightGreen400 ->
            Black

        LightGreen500 ->
            Black

        LightGreen600 ->
            White

        LightGreen700 ->
            White

        LightGreen800 ->
            White

        LightGreen900 ->
            White

        LightGreenA100 ->
            Black

        LightGreenA200 ->
            Black

        LightGreenA400 ->
            Black

        LightGreenA700 ->
            Black

        Lime50 ->
            Black

        Lime100 ->
            Black

        Lime200 ->
            Black

        Lime300 ->
            Black

        Lime400 ->
            Black

        Lime500 ->
            Black

        Lime600 ->
            Black

        Lime700 ->
            White

        Lime800 ->
            White

        Lime900 ->
            White

        LimeA100 ->
            Black

        LimeA200 ->
            Black

        LimeA400 ->
            Black

        LimeA700 ->
            Black

        Yellow50 ->
            Black

        Yellow100 ->
            Black

        Yellow200 ->
            Black

        Yellow300 ->
            Black

        Yellow400 ->
            Black

        Yellow500 ->
            Black

        Yellow600 ->
            Black

        Yellow700 ->
            Black

        Yellow800 ->
            Black

        Yellow900 ->
            White

        YellowA100 ->
            Black

        YellowA200 ->
            Black

        YellowA400 ->
            Black

        YellowA700 ->
            Black

        Amber50 ->
            Black

        Amber100 ->
            Black

        Amber200 ->
            Black

        Amber300 ->
            Black

        Amber400 ->
            Black

        Amber500 ->
            Black

        Amber600 ->
            Black

        Amber700 ->
            Black

        Amber800 ->
            Black

        Amber900 ->
            White

        AmberA100 ->
            Black

        AmberA200 ->
            Black

        AmberA400 ->
            Black

        AmberA700 ->
            Black

        Orange50 ->
            Black

        Orange100 ->
            Black

        Orange200 ->
            Black

        Orange300 ->
            Black

        Orange400 ->
            Black

        Orange500 ->
            Black

        Orange600 ->
            Black

        Orange700 ->
            Black

        Orange800 ->
            White

        Orange900 ->
            White

        OrangeA100 ->
            Black

        OrangeA200 ->
            Black

        OrangeA400 ->
            Black

        OrangeA700 ->
            White

        DeepOrange50 ->
            Black

        DeepOrange100 ->
            Black

        DeepOrange200 ->
            Black

        DeepOrange300 ->
            Black

        DeepOrange400 ->
            Black

        DeepOrange500 ->
            White

        DeepOrange600 ->
            White

        DeepOrange700 ->
            White

        DeepOrange800 ->
            White

        DeepOrange900 ->
            White

        DeepOrangeA100 ->
            Black

        DeepOrangeA200 ->
            Black

        DeepOrangeA400 ->
            White

        DeepOrangeA700 ->
            White

        Brown50 ->
            Black

        Brown100 ->
            Black

        Brown200 ->
            Black

        Brown300 ->
            White

        Brown400 ->
            White

        Brown500 ->
            White

        Brown600 ->
            White

        Brown700 ->
            White

        Brown800 ->
            White

        Brown900 ->
            White

        Grey50 ->
            Black

        Grey100 ->
            Black

        Grey200 ->
            Black

        Grey300 ->
            Black

        Grey400 ->
            Black

        Grey500 ->
            Black

        Grey600 ->
            White

        Grey700 ->
            White

        Grey800 ->
            White

        Grey900 ->
            White

        BlueGrey50 ->
            Black

        BlueGrey100 ->
            Black

        BlueGrey200 ->
            Black

        BlueGrey300 ->
            White

        BlueGrey400 ->
            White

        BlueGrey500 ->
            White

        BlueGrey600 ->
            White

        BlueGrey700 ->
            White

        BlueGrey800 ->
            White

        BlueGrey900 ->
            White

        White ->
            Black

        Black ->
            White
