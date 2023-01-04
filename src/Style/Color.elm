module Style.Color exposing
    ( bgColor
    , fgColor
    , fromPalette
    )

{-| -}

import Element exposing (Attribute, rgb255)
import Element.Background as Background
import Element.Font as Font
import Model.ColorPalette exposing (..)


bgColor : Int -> Int -> Int -> Attribute msg
bgColor r g b =
    Background.color (rgb255 r g b)


fgColor : Int -> Int -> Int -> Attribute msg
fgColor r g b =
    Font.color (rgb255 r g b)


fgColorWhite : Attribute msg
fgColorWhite =
    fgColor 255 255 255


fgColorBlack : Attribute msg
fgColorBlack =
    fgColor 0 0 0


{-| 调色板
配色信息来自于[Material Design Color Palette by](https://blog.avada.io/css/color-palettes#material-design-color-palette-badboy)
-}
fromPalette : Palette -> List (Attribute msg)
fromPalette p =
    case p of
        Red50 ->
            [ bgColor 255 235 238, fgColorBlack ]

        Red100 ->
            [ bgColor 255 205 210, fgColorBlack ]

        Red200 ->
            [ bgColor 239 154 154, fgColorBlack ]

        Red300 ->
            [ bgColor 229 115 115, fgColorWhite ]

        Red400 ->
            [ bgColor 239 83 80, fgColorWhite ]

        Red500 ->
            [ bgColor 244 67 54, fgColorWhite ]

        Red600 ->
            [ bgColor 229 57 53, fgColorWhite ]

        Red700 ->
            [ bgColor 211 47 47, fgColorWhite ]

        Red800 ->
            [ bgColor 198 40 40, fgColorWhite ]

        Red900 ->
            [ bgColor 183 28 28, fgColorWhite ]

        RedA100 ->
            [ bgColor 255 138 128, fgColorBlack ]

        RedA200 ->
            [ bgColor 255 82 82, fgColorWhite ]

        RedA400 ->
            [ bgColor 255 23 68, fgColorWhite ]

        RedA700 ->
            [ bgColor 213 0 0, fgColorWhite ]

        Pink50 ->
            [ bgColor 252 228 236, fgColorBlack ]

        Pink100 ->
            [ bgColor 248 187 208, fgColorBlack ]

        Pink200 ->
            [ bgColor 244 143 177, fgColorBlack ]

        Pink300 ->
            [ bgColor 240 98 146, fgColorWhite ]

        Pink400 ->
            [ bgColor 236 64 122, fgColorWhite ]

        Pink500 ->
            [ bgColor 233 30 99, fgColorWhite ]

        Pink600 ->
            [ bgColor 216 27 96, fgColorWhite ]

        Pink700 ->
            [ bgColor 194 24 91, fgColorWhite ]

        Pink800 ->
            [ bgColor 173 20 87, fgColorWhite ]

        Pink900 ->
            [ bgColor 136 14 79, fgColorWhite ]

        PinkA100 ->
            [ bgColor 255 128 171, fgColorBlack ]

        PinkA200 ->
            [ bgColor 255 64 129, fgColorWhite ]

        PinkA400 ->
            [ bgColor 245 0 87, fgColorWhite ]

        PinkA700 ->
            [ bgColor 197 17 98, fgColorWhite ]

        Purple50 ->
            [ bgColor 243 229 245, fgColorBlack ]

        Purple100 ->
            [ bgColor 225 190 231, fgColorBlack ]

        Purple200 ->
            [ bgColor 206 147 216, fgColorBlack ]

        Purple300 ->
            [ bgColor 186 104 200, fgColorWhite ]

        Purple400 ->
            [ bgColor 171 71 188, fgColorWhite ]

        Purple500 ->
            [ bgColor 156 39 176, fgColorWhite ]

        Purple600 ->
            [ bgColor 142 36 170, fgColorWhite ]

        Purple700 ->
            [ bgColor 123 31 162, fgColorWhite ]

        Purple800 ->
            [ bgColor 106 27 154, fgColorWhite ]

        Purple900 ->
            [ bgColor 74 20 140, fgColorWhite ]

        PurpleA100 ->
            [ bgColor 234 128 252, fgColorBlack ]

        PurpleA200 ->
            [ bgColor 224 64 251, fgColorWhite ]

        PurpleA400 ->
            [ bgColor 213 0 249, fgColorWhite ]

        PurpleA700 ->
            [ bgColor 170 0 255, fgColorWhite ]

        DeepPurple50 ->
            [ bgColor 237 231 246, fgColorBlack ]

        DeepPurple100 ->
            [ bgColor 209 196 233, fgColorBlack ]

        DeepPurple200 ->
            [ bgColor 179 157 219, fgColorBlack ]

        DeepPurple300 ->
            [ bgColor 149 117 205, fgColorWhite ]

        DeepPurple400 ->
            [ bgColor 126 87 194, fgColorWhite ]

        DeepPurple500 ->
            [ bgColor 103 58 183, fgColorWhite ]

        DeepPurple600 ->
            [ bgColor 94 53 177, fgColorWhite ]

        DeepPurple700 ->
            [ bgColor 81 45 168, fgColorWhite ]

        DeepPurple800 ->
            [ bgColor 69 39 160, fgColorWhite ]

        DeepPurple900 ->
            [ bgColor 49 27 146, fgColorWhite ]

        DeepPurpleA100 ->
            [ bgColor 179 136 255, fgColorBlack ]

        DeepPurpleA200 ->
            [ bgColor 124 77 255, fgColorWhite ]

        DeepPurpleA400 ->
            [ bgColor 101 31 255, fgColorWhite ]

        DeepPurpleA700 ->
            [ bgColor 98 0 234, fgColorWhite ]

        Indigo50 ->
            [ bgColor 232 234 246, fgColorBlack ]

        Indigo100 ->
            [ bgColor 197 202 233, fgColorBlack ]

        Indigo200 ->
            [ bgColor 159 168 218, fgColorBlack ]

        Indigo300 ->
            [ bgColor 121 134 203, fgColorWhite ]

        Indigo400 ->
            [ bgColor 92 107 192, fgColorWhite ]

        Indigo500 ->
            [ bgColor 63 81 181, fgColorWhite ]

        Indigo600 ->
            [ bgColor 57 73 171, fgColorWhite ]

        Indigo700 ->
            [ bgColor 48 63 159, fgColorWhite ]

        Indigo800 ->
            [ bgColor 40 53 147, fgColorWhite ]

        Indigo900 ->
            [ bgColor 26 35 126, fgColorWhite ]

        IndigoA100 ->
            [ bgColor 140 158 255, fgColorBlack ]

        IndigoA200 ->
            [ bgColor 83 109 254, fgColorWhite ]

        IndigoA400 ->
            [ bgColor 61 90 254, fgColorWhite ]

        IndigoA700 ->
            [ bgColor 48 79 254, fgColorWhite ]

        Blue50 ->
            [ bgColor 227 242 253, fgColorBlack ]

        Blue100 ->
            [ bgColor 187 222 251, fgColorBlack ]

        Blue200 ->
            [ bgColor 144 202 249, fgColorBlack ]

        Blue300 ->
            [ bgColor 100 181 246, fgColorBlack ]

        Blue400 ->
            [ bgColor 66 165 245, fgColorWhite ]

        Blue500 ->
            [ bgColor 33 150 243, fgColorWhite ]

        Blue600 ->
            [ bgColor 30 136 229, fgColorWhite ]

        Blue700 ->
            [ bgColor 25 118 210, fgColorWhite ]

        Blue800 ->
            [ bgColor 21 101 192, fgColorWhite ]

        Blue900 ->
            [ bgColor 13 71 161, fgColorWhite ]

        BlueA100 ->
            [ bgColor 130 177 255, fgColorBlack ]

        BlueA200 ->
            [ bgColor 68 138 255, fgColorWhite ]

        BlueA400 ->
            [ bgColor 41 121 255, fgColorWhite ]

        BlueA700 ->
            [ bgColor 41 98 255, fgColorWhite ]

        LightBlue50 ->
            [ bgColor 225 245 254, fgColorBlack ]

        LightBlue100 ->
            [ bgColor 179 229 252, fgColorBlack ]

        LightBlue200 ->
            [ bgColor 129 212 250, fgColorBlack ]

        LightBlue300 ->
            [ bgColor 79 195 247, fgColorBlack ]

        LightBlue400 ->
            [ bgColor 41 182 246, fgColorBlack ]

        LightBlue500 ->
            [ bgColor 3 169 244, fgColorWhite ]

        LightBlue600 ->
            [ bgColor 3 155 229, fgColorWhite ]

        LightBlue700 ->
            [ bgColor 2 136 209, fgColorWhite ]

        LightBlue800 ->
            [ bgColor 2 119 189, fgColorWhite ]

        LightBlue900 ->
            [ bgColor 1 87 155, fgColorWhite ]

        LightBlueA100 ->
            [ bgColor 128 216 255, fgColorBlack ]

        LightBlueA200 ->
            [ bgColor 64 196 255, fgColorBlack ]

        LightBlueA400 ->
            [ bgColor 0 176 255, fgColorBlack ]

        LightBlueA700 ->
            [ bgColor 0 145 234, fgColorWhite ]

        Cyan50 ->
            [ bgColor 224 247 250, fgColorBlack ]

        Cyan100 ->
            [ bgColor 178 235 242, fgColorBlack ]

        Cyan200 ->
            [ bgColor 128 222 234, fgColorBlack ]

        Cyan300 ->
            [ bgColor 77 208 225, fgColorBlack ]

        Cyan400 ->
            [ bgColor 38 198 218, fgColorBlack ]

        Cyan500 ->
            [ bgColor 0 188 212, fgColorWhite ]

        Cyan600 ->
            [ bgColor 0 172 193, fgColorWhite ]

        Cyan700 ->
            [ bgColor 0 151 167, fgColorWhite ]

        Cyan800 ->
            [ bgColor 0 131 143, fgColorWhite ]

        Cyan900 ->
            [ bgColor 0 96 100, fgColorWhite ]

        CyanA100 ->
            [ bgColor 132 255 255, fgColorBlack ]

        CyanA200 ->
            [ bgColor 24 255 255, fgColorBlack ]

        CyanA400 ->
            [ bgColor 0 229 255, fgColorBlack ]

        CyanA700 ->
            [ bgColor 0 184 212, fgColorBlack ]

        Teal50 ->
            [ bgColor 224 242 241, fgColorBlack ]

        Teal100 ->
            [ bgColor 178 223 219, fgColorBlack ]

        Teal200 ->
            [ bgColor 128 203 196, fgColorBlack ]

        Teal300 ->
            [ bgColor 77 182 172, fgColorBlack ]

        Teal400 ->
            [ bgColor 38 166 154, fgColorWhite ]

        Teal500 ->
            [ bgColor 0 150 136, fgColorWhite ]

        Teal600 ->
            [ bgColor 0 137 123, fgColorWhite ]

        Teal700 ->
            [ bgColor 0 121 107, fgColorWhite ]

        Teal800 ->
            [ bgColor 0 105 92, fgColorWhite ]

        Teal900 ->
            [ bgColor 0 77 64, fgColorWhite ]

        TealA100 ->
            [ bgColor 167 255 235, fgColorBlack ]

        TealA200 ->
            [ bgColor 100 255 218, fgColorBlack ]

        TealA400 ->
            [ bgColor 29 233 182, fgColorBlack ]

        TealA700 ->
            [ bgColor 0 191 165, fgColorBlack ]

        Green50 ->
            [ bgColor 232 245 233, fgColorBlack ]

        Green100 ->
            [ bgColor 200 230 201, fgColorBlack ]

        Green200 ->
            [ bgColor 165 214 167, fgColorBlack ]

        Green300 ->
            [ bgColor 129 199 132, fgColorBlack ]

        Green400 ->
            [ bgColor 102 187 106, fgColorWhite ]

        Green500 ->
            [ bgColor 76 175 80, fgColorWhite ]

        Green600 ->
            [ bgColor 67 160 71, fgColorWhite ]

        Green700 ->
            [ bgColor 56 142 60, fgColorWhite ]

        Green800 ->
            [ bgColor 46 125 50, fgColorWhite ]

        Green900 ->
            [ bgColor 27 94 32, fgColorWhite ]

        GreenA100 ->
            [ bgColor 185 246 202, fgColorBlack ]

        GreenA200 ->
            [ bgColor 105 240 174, fgColorBlack ]

        GreenA400 ->
            [ bgColor 0 230 118, fgColorBlack ]

        GreenA700 ->
            [ bgColor 0 200 83, fgColorBlack ]

        LightGreen50 ->
            [ bgColor 241 248 233, fgColorBlack ]

        LightGreen100 ->
            [ bgColor 220 237 200, fgColorBlack ]

        LightGreen200 ->
            [ bgColor 197 225 165, fgColorBlack ]

        LightGreen300 ->
            [ bgColor 174 213 129, fgColorBlack ]

        LightGreen400 ->
            [ bgColor 156 204 101, fgColorBlack ]

        LightGreen500 ->
            [ bgColor 139 195 74, fgColorBlack ]

        LightGreen600 ->
            [ bgColor 124 179 66, fgColorWhite ]

        LightGreen700 ->
            [ bgColor 104 159 56, fgColorWhite ]

        LightGreen800 ->
            [ bgColor 85 139 47, fgColorWhite ]

        LightGreen900 ->
            [ bgColor 51 105 30, fgColorWhite ]

        LightGreenA100 ->
            [ bgColor 204 255 144, fgColorBlack ]

        LightGreenA200 ->
            [ bgColor 178 255 89, fgColorBlack ]

        LightGreenA400 ->
            [ bgColor 118 255 3, fgColorBlack ]

        LightGreenA700 ->
            [ bgColor 100 221 23, fgColorBlack ]

        Lime50 ->
            [ bgColor 249 251 231, fgColorBlack ]

        Lime100 ->
            [ bgColor 240 244 195, fgColorBlack ]

        Lime200 ->
            [ bgColor 230 238 156, fgColorBlack ]

        Lime300 ->
            [ bgColor 220 231 117, fgColorBlack ]

        Lime400 ->
            [ bgColor 212 225 87, fgColorBlack ]

        Lime500 ->
            [ bgColor 205 220 57, fgColorBlack ]

        Lime600 ->
            [ bgColor 192 202 51, fgColorBlack ]

        Lime700 ->
            [ bgColor 175 180 43, fgColorWhite ]

        Lime800 ->
            [ bgColor 158 157 36, fgColorWhite ]

        Lime900 ->
            [ bgColor 130 119 23, fgColorWhite ]

        LimeA100 ->
            [ bgColor 244 255 129, fgColorBlack ]

        LimeA200 ->
            [ bgColor 238 255 65, fgColorBlack ]

        LimeA400 ->
            [ bgColor 198 255 0, fgColorBlack ]

        LimeA700 ->
            [ bgColor 174 234 0, fgColorBlack ]

        Yellow50 ->
            [ bgColor 255 253 231, fgColorBlack ]

        Yellow100 ->
            [ bgColor 255 249 196, fgColorBlack ]

        Yellow200 ->
            [ bgColor 255 245 157, fgColorBlack ]

        Yellow300 ->
            [ bgColor 255 241 118, fgColorBlack ]

        Yellow400 ->
            [ bgColor 255 238 88, fgColorBlack ]

        Yellow500 ->
            [ bgColor 255 235 59, fgColorBlack ]

        Yellow600 ->
            [ bgColor 253 216 53, fgColorBlack ]

        Yellow700 ->
            [ bgColor 251 192 45, fgColorBlack ]

        Yellow800 ->
            [ bgColor 249 168 37, fgColorBlack ]

        Yellow900 ->
            [ bgColor 245 127 23, fgColorWhite ]

        YellowA100 ->
            [ bgColor 255 255 141, fgColorBlack ]

        YellowA200 ->
            [ bgColor 255 255 0, fgColorBlack ]

        YellowA400 ->
            [ bgColor 255 234 0, fgColorBlack ]

        YellowA700 ->
            [ bgColor 255 214 0, fgColorBlack ]

        Amber50 ->
            [ bgColor 255 248 225, fgColorBlack ]

        Amber100 ->
            [ bgColor 255 236 179, fgColorBlack ]

        Amber200 ->
            [ bgColor 255 224 130, fgColorBlack ]

        Amber300 ->
            [ bgColor 255 213 79, fgColorBlack ]

        Amber400 ->
            [ bgColor 255 202 40, fgColorBlack ]

        Amber500 ->
            [ bgColor 255 193 7, fgColorBlack ]

        Amber600 ->
            [ bgColor 255 179 0, fgColorBlack ]

        Amber700 ->
            [ bgColor 255 160 0, fgColorBlack ]

        Amber800 ->
            [ bgColor 255 143 0, fgColorBlack ]

        Amber900 ->
            [ bgColor 255 111 0, fgColorWhite ]

        AmberA100 ->
            [ bgColor 255 229 127, fgColorBlack ]

        AmberA200 ->
            [ bgColor 255 215 64, fgColorBlack ]

        AmberA400 ->
            [ bgColor 255 196 0, fgColorBlack ]

        AmberA700 ->
            [ bgColor 255 171 0, fgColorBlack ]

        Orange50 ->
            [ bgColor 255 243 224, fgColorBlack ]

        Orange100 ->
            [ bgColor 255 224 178, fgColorBlack ]

        Orange200 ->
            [ bgColor 255 204 128, fgColorBlack ]

        Orange300 ->
            [ bgColor 255 183 77, fgColorBlack ]

        Orange400 ->
            [ bgColor 255 167 38, fgColorBlack ]

        Orange500 ->
            [ bgColor 255 152 0, fgColorBlack ]

        Orange600 ->
            [ bgColor 251 140 0, fgColorBlack ]

        Orange700 ->
            [ bgColor 245 124 0, fgColorBlack ]

        Orange800 ->
            [ bgColor 239 108 0, fgColorWhite ]

        Orange900 ->
            [ bgColor 230 81 0, fgColorWhite ]

        OrangeA100 ->
            [ bgColor 255 209 128, fgColorBlack ]

        OrangeA200 ->
            [ bgColor 255 171 64, fgColorBlack ]

        OrangeA400 ->
            [ bgColor 255 145 0, fgColorBlack ]

        OrangeA700 ->
            [ bgColor 255 109 0, fgColorWhite ]

        DeepOrange50 ->
            [ bgColor 251 233 231, fgColorBlack ]

        DeepOrange100 ->
            [ bgColor 255 204 188, fgColorBlack ]

        DeepOrange200 ->
            [ bgColor 255 171 145, fgColorBlack ]

        DeepOrange300 ->
            [ bgColor 255 138 101, fgColorBlack ]

        DeepOrange400 ->
            [ bgColor 255 112 67, fgColorBlack ]

        DeepOrange500 ->
            [ bgColor 255 87 34, fgColorWhite ]

        DeepOrange600 ->
            [ bgColor 244 81 30, fgColorWhite ]

        DeepOrange700 ->
            [ bgColor 230 74 25, fgColorWhite ]

        DeepOrange800 ->
            [ bgColor 216 67 21, fgColorWhite ]

        DeepOrange900 ->
            [ bgColor 191 54 12, fgColorWhite ]

        DeepOrangeA100 ->
            [ bgColor 255 158 128, fgColorBlack ]

        DeepOrangeA200 ->
            [ bgColor 255 110 64, fgColorBlack ]

        DeepOrangeA400 ->
            [ bgColor 255 61 0, fgColorWhite ]

        DeepOrangeA700 ->
            [ bgColor 221 44 0, fgColorWhite ]

        Brown50 ->
            [ bgColor 239 235 233, fgColorBlack ]

        Brown100 ->
            [ bgColor 215 204 200, fgColorBlack ]

        Brown200 ->
            [ bgColor 188 170 164, fgColorBlack ]

        Brown300 ->
            [ bgColor 161 136 127, fgColorWhite ]

        Brown400 ->
            [ bgColor 141 110 99, fgColorWhite ]

        Brown500 ->
            [ bgColor 121 85 72, fgColorWhite ]

        Brown600 ->
            [ bgColor 109 76 65, fgColorWhite ]

        Brown700 ->
            [ bgColor 93 64 55, fgColorWhite ]

        Brown800 ->
            [ bgColor 78 52 46, fgColorWhite ]

        Brown900 ->
            [ bgColor 62 39 35, fgColorWhite ]

        Grey50 ->
            [ bgColor 250 250 250, fgColorBlack ]

        Grey100 ->
            [ bgColor 245 245 245, fgColorBlack ]

        Grey200 ->
            [ bgColor 238 238 238, fgColorBlack ]

        Grey300 ->
            [ bgColor 224 224 224, fgColorBlack ]

        Grey400 ->
            [ bgColor 189 189 189, fgColorBlack ]

        Grey500 ->
            [ bgColor 158 158 158, fgColorBlack ]

        Grey600 ->
            [ bgColor 117 117 117, fgColorWhite ]

        Grey700 ->
            [ bgColor 97 97 97, fgColorWhite ]

        Grey800 ->
            [ bgColor 66 66 66, fgColorWhite ]

        Grey900 ->
            [ bgColor 33 33 33, fgColorWhite ]

        BlueGrey50 ->
            [ bgColor 236 239 241, fgColorBlack ]

        BlueGrey100 ->
            [ bgColor 207 216 220, fgColorBlack ]

        BlueGrey200 ->
            [ bgColor 176 190 197, fgColorBlack ]

        BlueGrey300 ->
            [ bgColor 144 164 174, fgColorWhite ]

        BlueGrey400 ->
            [ bgColor 120 144 156, fgColorWhite ]

        BlueGrey500 ->
            [ bgColor 96 125 139, fgColorWhite ]

        BlueGrey600 ->
            [ bgColor 84 110 122, fgColorWhite ]

        BlueGrey700 ->
            [ bgColor 69 90 100, fgColorWhite ]

        BlueGrey800 ->
            [ bgColor 55 71 79, fgColorWhite ]

        BlueGrey900 ->
            [ bgColor 38 50 56, fgColorWhite ]
