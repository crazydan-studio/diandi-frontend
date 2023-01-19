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


module Widget.Color exposing
    ( Color(..)
    , ColorGroup
    , colorDecoder
    , customPalette
    , defaultPalette
    , fgColorForBg
    , fromString
    , groups
    , maybeColorDecoder
    , toHtmlRgb
    , toRgb
    , toRgbColor
    , toRgbaColor
    )

{-| -}

import Element
import Element.Background
import Element.Font
import Json.Decode as Decode exposing (Decoder)


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


{-| 配色
配色信息来自于[Material Design Color Palette by](https://blog.avada.io/css/color-palettes#material-design-color-palette-badboy)

代码生成JS脚本(通过浏览器元素选择器，选中配色表所在的iframe)：

```js
var allColors = [];
var colorGroups = {};
var toColor = function (c) { return c.replaceAll(/rgb\((\d+), (\d+), (\d+)\)/g, '$1 $2 $3'); };

document.querySelectorAll('card list').forEach(function (list) {
  var colorGroupName = '';
  var colors = [];

  list.querySelectorAll('item').forEach(function(item, index) {
    var name = item.firstElementChild.innerText.replaceAll(/\n+.+/g, '').replaceAll(/((^|-)(.))/g, function ($0, $1, $2, $3) {
       return $3.toUpperCase();
    });
    if (index == 0) { colorGroupName = name; }
    if (index == 0 && !name.includes('Black') && !name.includes('White')) { return; }

    var style = getComputedStyle(item);
    var value = [name, toColor(style.backgroundColor), toColor(style.color)];

    colors.push(value);
  });

  colorGroups[colorGroupName] = colors;
  allColors = allColors.concat(colors);
});

// 数据定义
console.log(allColors.map(function (p) { return p[0]; }).join(' | '));

// 获取前景色
console.log('    case bg of\n' + allColors.map(function (p) {
  return '        ' + p[0] + ' ->\n            rgb255 ' + p[2];
}).join('\n'));

// 转换为RGB
console.log('    case color of\n' + allColors.map(function (p) {
  return '        ' + p[0] + ' ->\n            (' + p[1].replaceAll(/\s+/g, ',') + ')';
}).join('\n'));

// 从字符串转换Color
console.log('    case (String.toLower s) of\n' + allColors.map(function (p) {
  var name = p[0];
  return '        "' + name.toLowerCase() + '" ->\n            Just ' + name + '';
}).join('\n') + '\n        _ ->\n            Nothing');

// 配色分组表
console.log('    [' + Object.keys(colorGroups).map(function (group) {
  var colors = colorGroups[group];
  return 'ColorGroup "' + group
    + '" [' + colors.map(function (p) { return p[0]; }).join('\n        , ')
    + ']';
}).join('\n    , ') + ']');
```

-}
type Color
    = -- Red
      Red50
    | Red100
    | Red200
    | Red300
    | Red400
    | Red500
    | Red600
    | Red700
    | Red800
    | Red900
    | RedA100
    | RedA200
    | RedA400
    | RedA700
      -- Pink
    | Pink50
    | Pink100
    | Pink200
    | Pink300
    | Pink400
    | Pink500
    | Pink600
    | Pink700
    | Pink800
    | Pink900
    | PinkA100
    | PinkA200
    | PinkA400
    | PinkA700
      -- Purple
    | Purple50
    | Purple100
    | Purple200
    | Purple300
    | Purple400
    | Purple500
    | Purple600
    | Purple700
    | Purple800
    | Purple900
    | PurpleA100
    | PurpleA200
    | PurpleA400
    | PurpleA700
      -- Deep Purple
    | DeepPurple50
    | DeepPurple100
    | DeepPurple200
    | DeepPurple300
    | DeepPurple400
    | DeepPurple500
    | DeepPurple600
    | DeepPurple700
    | DeepPurple800
    | DeepPurple900
    | DeepPurpleA100
    | DeepPurpleA200
    | DeepPurpleA400
    | DeepPurpleA700
      -- Indigo
    | Indigo50
    | Indigo100
    | Indigo200
    | Indigo300
    | Indigo400
    | Indigo500
    | Indigo600
    | Indigo700
    | Indigo800
    | Indigo900
    | IndigoA100
    | IndigoA200
    | IndigoA400
    | IndigoA700
      -- Blue
    | Blue50
    | Blue100
    | Blue200
    | Blue300
    | Blue400
    | Blue500
    | Blue600
    | Blue700
    | Blue800
    | Blue900
    | BlueA100
    | BlueA200
    | BlueA400
    | BlueA700
      -- Light Blue
    | LightBlue50
    | LightBlue100
    | LightBlue200
    | LightBlue300
    | LightBlue400
    | LightBlue500
    | LightBlue600
    | LightBlue700
    | LightBlue800
    | LightBlue900
    | LightBlueA100
    | LightBlueA200
    | LightBlueA400
    | LightBlueA700
      -- Cyan
    | Cyan50
    | Cyan100
    | Cyan200
    | Cyan300
    | Cyan400
    | Cyan500
    | Cyan600
    | Cyan700
    | Cyan800
    | Cyan900
    | CyanA100
    | CyanA200
    | CyanA400
    | CyanA700
      -- Teal
    | Teal50
    | Teal100
    | Teal200
    | Teal300
    | Teal400
    | Teal500
    | Teal600
    | Teal700
    | Teal800
    | Teal900
    | TealA100
    | TealA200
    | TealA400
    | TealA700
      -- Green
    | Green50
    | Green100
    | Green200
    | Green300
    | Green400
    | Green500
    | Green600
    | Green700
    | Green800
    | Green900
    | GreenA100
    | GreenA200
    | GreenA400
    | GreenA700
      -- Light Green
    | LightGreen50
    | LightGreen100
    | LightGreen200
    | LightGreen300
    | LightGreen400
    | LightGreen500
    | LightGreen600
    | LightGreen700
    | LightGreen800
    | LightGreen900
    | LightGreenA100
    | LightGreenA200
    | LightGreenA400
    | LightGreenA700
      -- Lime
    | Lime50
    | Lime100
    | Lime200
    | Lime300
    | Lime400
    | Lime500
    | Lime600
    | Lime700
    | Lime800
    | Lime900
    | LimeA100
    | LimeA200
    | LimeA400
    | LimeA700
      -- Yellow
    | Yellow50
    | Yellow100
    | Yellow200
    | Yellow300
    | Yellow400
    | Yellow500
    | Yellow600
    | Yellow700
    | Yellow800
    | Yellow900
    | YellowA100
    | YellowA200
    | YellowA400
    | YellowA700
      -- Amber
    | Amber50
    | Amber100
    | Amber200
    | Amber300
    | Amber400
    | Amber500
    | Amber600
    | Amber700
    | Amber800
    | Amber900
    | AmberA100
    | AmberA200
    | AmberA400
    | AmberA700
      -- Orange
    | Orange50
    | Orange100
    | Orange200
    | Orange300
    | Orange400
    | Orange500
    | Orange600
    | Orange700
    | Orange800
    | Orange900
    | OrangeA100
    | OrangeA200
    | OrangeA400
    | OrangeA700
      -- Deep Orange
    | DeepOrange50
    | DeepOrange100
    | DeepOrange200
    | DeepOrange300
    | DeepOrange400
    | DeepOrange500
    | DeepOrange600
    | DeepOrange700
    | DeepOrange800
    | DeepOrange900
    | DeepOrangeA100
    | DeepOrangeA200
    | DeepOrangeA400
    | DeepOrangeA700
      -- Brown
    | Brown50
    | Brown100
    | Brown200
    | Brown300
    | Brown400
    | Brown500
    | Brown600
    | Brown700
    | Brown800
    | Brown900
      -- Grey
    | Grey50
    | Grey100
    | Grey200
    | Grey300
    | Grey400
    | Grey500
    | Grey600
    | Grey700
    | Grey800
    | Grey900
      -- Blue Grey
    | BlueGrey50
    | BlueGrey100
    | BlueGrey200
    | BlueGrey300
    | BlueGrey400
    | BlueGrey500
    | BlueGrey600
    | BlueGrey700
    | BlueGrey800
    | BlueGrey900
      --
    | White
    | Black


{-| 配色分组

    ColorGroup 分组名 [调色板列表, ...]

-}
type ColorGroup
    = ColorGroup String (List Color)


colorDecoder : Decoder Color
colorDecoder =
    colorDecoderHelper
        (\v -> v)
        (\p -> Decode.fail ("Unknown color: " ++ p))


maybeColorDecoder : Decoder (Maybe Color)
maybeColorDecoder =
    colorDecoderHelper
        (\v -> Just v)
        (\_ -> Decode.succeed Nothing)


colorDecoderHelper : (Color -> a) -> (String -> Decoder a) -> Decoder a
colorDecoderHelper success fail =
    Decode.string
        |> Decode.andThen
            (\str ->
                case fromString str of
                    Just v ->
                        Decode.succeed (success v)

                    Nothing ->
                        fail str
            )


toRgb : Color -> { r : Int, g : Int, b : Int }
toRgb color =
    let
        ( r, g, b ) =
            toRgbHelper color
    in
    { r = r, g = g, b = b }


toHtmlRgb : Color -> String
toHtmlRgb color =
    let
        c =
            toRgb color
    in
    "rgb("
        ++ ([ c.r
            , c.g
            , c.b
            ]
                |> List.map
                    (\n ->
                        String.fromInt n
                    )
                |> String.join ","
           )
        ++ ")"


fromString : String -> Maybe Color
fromString str =
    case String.toLower str of
        "red50" ->
            Just Red50

        "red100" ->
            Just Red100

        "red200" ->
            Just Red200

        "red300" ->
            Just Red300

        "red400" ->
            Just Red400

        "red500" ->
            Just Red500

        "red600" ->
            Just Red600

        "red700" ->
            Just Red700

        "red800" ->
            Just Red800

        "red900" ->
            Just Red900

        "reda100" ->
            Just RedA100

        "reda200" ->
            Just RedA200

        "reda400" ->
            Just RedA400

        "reda700" ->
            Just RedA700

        "pink50" ->
            Just Pink50

        "pink100" ->
            Just Pink100

        "pink200" ->
            Just Pink200

        "pink300" ->
            Just Pink300

        "pink400" ->
            Just Pink400

        "pink500" ->
            Just Pink500

        "pink600" ->
            Just Pink600

        "pink700" ->
            Just Pink700

        "pink800" ->
            Just Pink800

        "pink900" ->
            Just Pink900

        "pinka100" ->
            Just PinkA100

        "pinka200" ->
            Just PinkA200

        "pinka400" ->
            Just PinkA400

        "pinka700" ->
            Just PinkA700

        "purple50" ->
            Just Purple50

        "purple100" ->
            Just Purple100

        "purple200" ->
            Just Purple200

        "purple300" ->
            Just Purple300

        "purple400" ->
            Just Purple400

        "purple500" ->
            Just Purple500

        "purple600" ->
            Just Purple600

        "purple700" ->
            Just Purple700

        "purple800" ->
            Just Purple800

        "purple900" ->
            Just Purple900

        "purplea100" ->
            Just PurpleA100

        "purplea200" ->
            Just PurpleA200

        "purplea400" ->
            Just PurpleA400

        "purplea700" ->
            Just PurpleA700

        "deeppurple50" ->
            Just DeepPurple50

        "deeppurple100" ->
            Just DeepPurple100

        "deeppurple200" ->
            Just DeepPurple200

        "deeppurple300" ->
            Just DeepPurple300

        "deeppurple400" ->
            Just DeepPurple400

        "deeppurple500" ->
            Just DeepPurple500

        "deeppurple600" ->
            Just DeepPurple600

        "deeppurple700" ->
            Just DeepPurple700

        "deeppurple800" ->
            Just DeepPurple800

        "deeppurple900" ->
            Just DeepPurple900

        "deeppurplea100" ->
            Just DeepPurpleA100

        "deeppurplea200" ->
            Just DeepPurpleA200

        "deeppurplea400" ->
            Just DeepPurpleA400

        "deeppurplea700" ->
            Just DeepPurpleA700

        "indigo50" ->
            Just Indigo50

        "indigo100" ->
            Just Indigo100

        "indigo200" ->
            Just Indigo200

        "indigo300" ->
            Just Indigo300

        "indigo400" ->
            Just Indigo400

        "indigo500" ->
            Just Indigo500

        "indigo600" ->
            Just Indigo600

        "indigo700" ->
            Just Indigo700

        "indigo800" ->
            Just Indigo800

        "indigo900" ->
            Just Indigo900

        "indigoa100" ->
            Just IndigoA100

        "indigoa200" ->
            Just IndigoA200

        "indigoa400" ->
            Just IndigoA400

        "indigoa700" ->
            Just IndigoA700

        "blue50" ->
            Just Blue50

        "blue100" ->
            Just Blue100

        "blue200" ->
            Just Blue200

        "blue300" ->
            Just Blue300

        "blue400" ->
            Just Blue400

        "blue500" ->
            Just Blue500

        "blue600" ->
            Just Blue600

        "blue700" ->
            Just Blue700

        "blue800" ->
            Just Blue800

        "blue900" ->
            Just Blue900

        "bluea100" ->
            Just BlueA100

        "bluea200" ->
            Just BlueA200

        "bluea400" ->
            Just BlueA400

        "bluea700" ->
            Just BlueA700

        "lightblue50" ->
            Just LightBlue50

        "lightblue100" ->
            Just LightBlue100

        "lightblue200" ->
            Just LightBlue200

        "lightblue300" ->
            Just LightBlue300

        "lightblue400" ->
            Just LightBlue400

        "lightblue500" ->
            Just LightBlue500

        "lightblue600" ->
            Just LightBlue600

        "lightblue700" ->
            Just LightBlue700

        "lightblue800" ->
            Just LightBlue800

        "lightblue900" ->
            Just LightBlue900

        "lightbluea100" ->
            Just LightBlueA100

        "lightbluea200" ->
            Just LightBlueA200

        "lightbluea400" ->
            Just LightBlueA400

        "lightbluea700" ->
            Just LightBlueA700

        "cyan50" ->
            Just Cyan50

        "cyan100" ->
            Just Cyan100

        "cyan200" ->
            Just Cyan200

        "cyan300" ->
            Just Cyan300

        "cyan400" ->
            Just Cyan400

        "cyan500" ->
            Just Cyan500

        "cyan600" ->
            Just Cyan600

        "cyan700" ->
            Just Cyan700

        "cyan800" ->
            Just Cyan800

        "cyan900" ->
            Just Cyan900

        "cyana100" ->
            Just CyanA100

        "cyana200" ->
            Just CyanA200

        "cyana400" ->
            Just CyanA400

        "cyana700" ->
            Just CyanA700

        "teal50" ->
            Just Teal50

        "teal100" ->
            Just Teal100

        "teal200" ->
            Just Teal200

        "teal300" ->
            Just Teal300

        "teal400" ->
            Just Teal400

        "teal500" ->
            Just Teal500

        "teal600" ->
            Just Teal600

        "teal700" ->
            Just Teal700

        "teal800" ->
            Just Teal800

        "teal900" ->
            Just Teal900

        "teala100" ->
            Just TealA100

        "teala200" ->
            Just TealA200

        "teala400" ->
            Just TealA400

        "teala700" ->
            Just TealA700

        "green50" ->
            Just Green50

        "green100" ->
            Just Green100

        "green200" ->
            Just Green200

        "green300" ->
            Just Green300

        "green400" ->
            Just Green400

        "green500" ->
            Just Green500

        "green600" ->
            Just Green600

        "green700" ->
            Just Green700

        "green800" ->
            Just Green800

        "green900" ->
            Just Green900

        "greena100" ->
            Just GreenA100

        "greena200" ->
            Just GreenA200

        "greena400" ->
            Just GreenA400

        "greena700" ->
            Just GreenA700

        "lightgreen50" ->
            Just LightGreen50

        "lightgreen100" ->
            Just LightGreen100

        "lightgreen200" ->
            Just LightGreen200

        "lightgreen300" ->
            Just LightGreen300

        "lightgreen400" ->
            Just LightGreen400

        "lightgreen500" ->
            Just LightGreen500

        "lightgreen600" ->
            Just LightGreen600

        "lightgreen700" ->
            Just LightGreen700

        "lightgreen800" ->
            Just LightGreen800

        "lightgreen900" ->
            Just LightGreen900

        "lightgreena100" ->
            Just LightGreenA100

        "lightgreena200" ->
            Just LightGreenA200

        "lightgreena400" ->
            Just LightGreenA400

        "lightgreena700" ->
            Just LightGreenA700

        "lime50" ->
            Just Lime50

        "lime100" ->
            Just Lime100

        "lime200" ->
            Just Lime200

        "lime300" ->
            Just Lime300

        "lime400" ->
            Just Lime400

        "lime500" ->
            Just Lime500

        "lime600" ->
            Just Lime600

        "lime700" ->
            Just Lime700

        "lime800" ->
            Just Lime800

        "lime900" ->
            Just Lime900

        "limea100" ->
            Just LimeA100

        "limea200" ->
            Just LimeA200

        "limea400" ->
            Just LimeA400

        "limea700" ->
            Just LimeA700

        "yellow50" ->
            Just Yellow50

        "yellow100" ->
            Just Yellow100

        "yellow200" ->
            Just Yellow200

        "yellow300" ->
            Just Yellow300

        "yellow400" ->
            Just Yellow400

        "yellow500" ->
            Just Yellow500

        "yellow600" ->
            Just Yellow600

        "yellow700" ->
            Just Yellow700

        "yellow800" ->
            Just Yellow800

        "yellow900" ->
            Just Yellow900

        "yellowa100" ->
            Just YellowA100

        "yellowa200" ->
            Just YellowA200

        "yellowa400" ->
            Just YellowA400

        "yellowa700" ->
            Just YellowA700

        "amber50" ->
            Just Amber50

        "amber100" ->
            Just Amber100

        "amber200" ->
            Just Amber200

        "amber300" ->
            Just Amber300

        "amber400" ->
            Just Amber400

        "amber500" ->
            Just Amber500

        "amber600" ->
            Just Amber600

        "amber700" ->
            Just Amber700

        "amber800" ->
            Just Amber800

        "amber900" ->
            Just Amber900

        "ambera100" ->
            Just AmberA100

        "ambera200" ->
            Just AmberA200

        "ambera400" ->
            Just AmberA400

        "ambera700" ->
            Just AmberA700

        "orange50" ->
            Just Orange50

        "orange100" ->
            Just Orange100

        "orange200" ->
            Just Orange200

        "orange300" ->
            Just Orange300

        "orange400" ->
            Just Orange400

        "orange500" ->
            Just Orange500

        "orange600" ->
            Just Orange600

        "orange700" ->
            Just Orange700

        "orange800" ->
            Just Orange800

        "orange900" ->
            Just Orange900

        "orangea100" ->
            Just OrangeA100

        "orangea200" ->
            Just OrangeA200

        "orangea400" ->
            Just OrangeA400

        "orangea700" ->
            Just OrangeA700

        "deeporange50" ->
            Just DeepOrange50

        "deeporange100" ->
            Just DeepOrange100

        "deeporange200" ->
            Just DeepOrange200

        "deeporange300" ->
            Just DeepOrange300

        "deeporange400" ->
            Just DeepOrange400

        "deeporange500" ->
            Just DeepOrange500

        "deeporange600" ->
            Just DeepOrange600

        "deeporange700" ->
            Just DeepOrange700

        "deeporange800" ->
            Just DeepOrange800

        "deeporange900" ->
            Just DeepOrange900

        "deeporangea100" ->
            Just DeepOrangeA100

        "deeporangea200" ->
            Just DeepOrangeA200

        "deeporangea400" ->
            Just DeepOrangeA400

        "deeporangea700" ->
            Just DeepOrangeA700

        "brown50" ->
            Just Brown50

        "brown100" ->
            Just Brown100

        "brown200" ->
            Just Brown200

        "brown300" ->
            Just Brown300

        "brown400" ->
            Just Brown400

        "brown500" ->
            Just Brown500

        "brown600" ->
            Just Brown600

        "brown700" ->
            Just Brown700

        "brown800" ->
            Just Brown800

        "brown900" ->
            Just Brown900

        "grey50" ->
            Just Grey50

        "grey100" ->
            Just Grey100

        "grey200" ->
            Just Grey200

        "grey300" ->
            Just Grey300

        "grey400" ->
            Just Grey400

        "grey500" ->
            Just Grey500

        "grey600" ->
            Just Grey600

        "grey700" ->
            Just Grey700

        "grey800" ->
            Just Grey800

        "grey900" ->
            Just Grey900

        "bluegrey50" ->
            Just BlueGrey50

        "bluegrey100" ->
            Just BlueGrey100

        "bluegrey200" ->
            Just BlueGrey200

        "bluegrey300" ->
            Just BlueGrey300

        "bluegrey400" ->
            Just BlueGrey400

        "bluegrey500" ->
            Just BlueGrey500

        "bluegrey600" ->
            Just BlueGrey600

        "bluegrey700" ->
            Just BlueGrey700

        "bluegrey800" ->
            Just BlueGrey800

        "bluegrey900" ->
            Just BlueGrey900

        "white" ->
            Just White

        "black" ->
            Just Black

        _ ->
            Nothing


groups : List ColorGroup
groups =
    [ ColorGroup "Red"
        [ Red50
        , Red100
        , Red200
        , Red300
        , Red400
        , Red500
        , Red600
        , Red700
        , Red800
        , Red900
        , RedA100
        , RedA200
        , RedA400
        , RedA700
        ]
    , ColorGroup "Pink"
        [ Pink50
        , Pink100
        , Pink200
        , Pink300
        , Pink400
        , Pink500
        , Pink600
        , Pink700
        , Pink800
        , Pink900
        , PinkA100
        , PinkA200
        , PinkA400
        , PinkA700
        ]
    , ColorGroup "Purple"
        [ Purple50
        , Purple100
        , Purple200
        , Purple300
        , Purple400
        , Purple500
        , Purple600
        , Purple700
        , Purple800
        , Purple900
        , PurpleA100
        , PurpleA200
        , PurpleA400
        , PurpleA700
        ]
    , ColorGroup "Deep Purple"
        [ DeepPurple50
        , DeepPurple100
        , DeepPurple200
        , DeepPurple300
        , DeepPurple400
        , DeepPurple500
        , DeepPurple600
        , DeepPurple700
        , DeepPurple800
        , DeepPurple900
        , DeepPurpleA100
        , DeepPurpleA200
        , DeepPurpleA400
        , DeepPurpleA700
        ]
    , ColorGroup "Indigo"
        [ Indigo50
        , Indigo100
        , Indigo200
        , Indigo300
        , Indigo400
        , Indigo500
        , Indigo600
        , Indigo700
        , Indigo800
        , Indigo900
        , IndigoA100
        , IndigoA200
        , IndigoA400
        , IndigoA700
        ]
    , ColorGroup "Blue"
        [ Blue50
        , Blue100
        , Blue200
        , Blue300
        , Blue400
        , Blue500
        , Blue600
        , Blue700
        , Blue800
        , Blue900
        , BlueA100
        , BlueA200
        , BlueA400
        , BlueA700
        ]
    , ColorGroup "Light Blue"
        [ LightBlue50
        , LightBlue100
        , LightBlue200
        , LightBlue300
        , LightBlue400
        , LightBlue500
        , LightBlue600
        , LightBlue700
        , LightBlue800
        , LightBlue900
        , LightBlueA100
        , LightBlueA200
        , LightBlueA400
        , LightBlueA700
        ]
    , ColorGroup "Cyan"
        [ Cyan50
        , Cyan100
        , Cyan200
        , Cyan300
        , Cyan400
        , Cyan500
        , Cyan600
        , Cyan700
        , Cyan800
        , Cyan900
        , CyanA100
        , CyanA200
        , CyanA400
        , CyanA700
        ]
    , ColorGroup "Teal"
        [ Teal50
        , Teal100
        , Teal200
        , Teal300
        , Teal400
        , Teal500
        , Teal600
        , Teal700
        , Teal800
        , Teal900
        , TealA100
        , TealA200
        , TealA400
        , TealA700
        ]
    , ColorGroup "Green"
        [ Green50
        , Green100
        , Green200
        , Green300
        , Green400
        , Green500
        , Green600
        , Green700
        , Green800
        , Green900
        , GreenA100
        , GreenA200
        , GreenA400
        , GreenA700
        ]
    , ColorGroup "Light Green"
        [ LightGreen50
        , LightGreen100
        , LightGreen200
        , LightGreen300
        , LightGreen400
        , LightGreen500
        , LightGreen600
        , LightGreen700
        , LightGreen800
        , LightGreen900
        , LightGreenA100
        , LightGreenA200
        , LightGreenA400
        , LightGreenA700
        ]
    , ColorGroup "Lime"
        [ Lime50
        , Lime100
        , Lime200
        , Lime300
        , Lime400
        , Lime500
        , Lime600
        , Lime700
        , Lime800
        , Lime900
        , LimeA100
        , LimeA200
        , LimeA400
        , LimeA700
        ]
    , ColorGroup "Yellow"
        [ Yellow50
        , Yellow100
        , Yellow200
        , Yellow300
        , Yellow400
        , Yellow500
        , Yellow600
        , Yellow700
        , Yellow800
        , Yellow900
        , YellowA100
        , YellowA200
        , YellowA400
        , YellowA700
        ]
    , ColorGroup "Amber"
        [ Amber50
        , Amber100
        , Amber200
        , Amber300
        , Amber400
        , Amber500
        , Amber600
        , Amber700
        , Amber800
        , Amber900
        , AmberA100
        , AmberA200
        , AmberA400
        , AmberA700
        ]
    , ColorGroup "Orange"
        [ Orange50
        , Orange100
        , Orange200
        , Orange300
        , Orange400
        , Orange500
        , Orange600
        , Orange700
        , Orange800
        , Orange900
        , OrangeA100
        , OrangeA200
        , OrangeA400
        , OrangeA700
        ]
    , ColorGroup "Deep Orange"
        [ DeepOrange50
        , DeepOrange100
        , DeepOrange200
        , DeepOrange300
        , DeepOrange400
        , DeepOrange500
        , DeepOrange600
        , DeepOrange700
        , DeepOrange800
        , DeepOrange900
        , DeepOrangeA100
        , DeepOrangeA200
        , DeepOrangeA400
        , DeepOrangeA700
        ]
    , ColorGroup "Brown"
        [ Brown50
        , Brown100
        , Brown200
        , Brown300
        , Brown400
        , Brown500
        , Brown600
        , Brown700
        , Brown800
        , Brown900
        ]
    , ColorGroup "Grey"
        [ Grey50
        , Grey100
        , Grey200
        , Grey300
        , Grey400
        , Grey500
        , Grey600
        , Grey700
        , Grey800
        , Grey900
        ]
    , ColorGroup "Blue Grey"
        [ BlueGrey50
        , BlueGrey100
        , BlueGrey200
        , BlueGrey300
        , BlueGrey400
        , BlueGrey500
        , BlueGrey600
        , BlueGrey700
        , BlueGrey800
        , BlueGrey900
        ]
    , ColorGroup "White" [ White ]
    , ColorGroup "Black" [ Black ]
    ]


{-| 获取与指定背景色搭配的前景色
-}
fgColorForBg : Color -> Color
fgColorForBg bg =
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


toRgbHelper : Color -> ( Int, Int, Int )
toRgbHelper color =
    case color of
        Red50 ->
            ( 255, 235, 238 )

        Red100 ->
            ( 255, 205, 210 )

        Red200 ->
            ( 239, 154, 154 )

        Red300 ->
            ( 229, 115, 115 )

        Red400 ->
            ( 239, 83, 80 )

        Red500 ->
            ( 244, 67, 54 )

        Red600 ->
            ( 229, 57, 53 )

        Red700 ->
            ( 211, 47, 47 )

        Red800 ->
            ( 198, 40, 40 )

        Red900 ->
            ( 183, 28, 28 )

        RedA100 ->
            ( 255, 138, 128 )

        RedA200 ->
            ( 255, 82, 82 )

        RedA400 ->
            ( 255, 23, 68 )

        RedA700 ->
            ( 213, 0, 0 )

        Pink50 ->
            ( 252, 228, 236 )

        Pink100 ->
            ( 248, 187, 208 )

        Pink200 ->
            ( 244, 143, 177 )

        Pink300 ->
            ( 240, 98, 146 )

        Pink400 ->
            ( 236, 64, 122 )

        Pink500 ->
            ( 233, 30, 99 )

        Pink600 ->
            ( 216, 27, 96 )

        Pink700 ->
            ( 194, 24, 91 )

        Pink800 ->
            ( 173, 20, 87 )

        Pink900 ->
            ( 136, 14, 79 )

        PinkA100 ->
            ( 255, 128, 171 )

        PinkA200 ->
            ( 255, 64, 129 )

        PinkA400 ->
            ( 245, 0, 87 )

        PinkA700 ->
            ( 197, 17, 98 )

        Purple50 ->
            ( 243, 229, 245 )

        Purple100 ->
            ( 225, 190, 231 )

        Purple200 ->
            ( 206, 147, 216 )

        Purple300 ->
            ( 186, 104, 200 )

        Purple400 ->
            ( 171, 71, 188 )

        Purple500 ->
            ( 156, 39, 176 )

        Purple600 ->
            ( 142, 36, 170 )

        Purple700 ->
            ( 123, 31, 162 )

        Purple800 ->
            ( 106, 27, 154 )

        Purple900 ->
            ( 74, 20, 140 )

        PurpleA100 ->
            ( 234, 128, 252 )

        PurpleA200 ->
            ( 224, 64, 251 )

        PurpleA400 ->
            ( 213, 0, 249 )

        PurpleA700 ->
            ( 170, 0, 255 )

        DeepPurple50 ->
            ( 237, 231, 246 )

        DeepPurple100 ->
            ( 209, 196, 233 )

        DeepPurple200 ->
            ( 179, 157, 219 )

        DeepPurple300 ->
            ( 149, 117, 205 )

        DeepPurple400 ->
            ( 126, 87, 194 )

        DeepPurple500 ->
            ( 103, 58, 183 )

        DeepPurple600 ->
            ( 94, 53, 177 )

        DeepPurple700 ->
            ( 81, 45, 168 )

        DeepPurple800 ->
            ( 69, 39, 160 )

        DeepPurple900 ->
            ( 49, 27, 146 )

        DeepPurpleA100 ->
            ( 179, 136, 255 )

        DeepPurpleA200 ->
            ( 124, 77, 255 )

        DeepPurpleA400 ->
            ( 101, 31, 255 )

        DeepPurpleA700 ->
            ( 98, 0, 234 )

        Indigo50 ->
            ( 232, 234, 246 )

        Indigo100 ->
            ( 197, 202, 233 )

        Indigo200 ->
            ( 159, 168, 218 )

        Indigo300 ->
            ( 121, 134, 203 )

        Indigo400 ->
            ( 92, 107, 192 )

        Indigo500 ->
            ( 63, 81, 181 )

        Indigo600 ->
            ( 57, 73, 171 )

        Indigo700 ->
            ( 48, 63, 159 )

        Indigo800 ->
            ( 40, 53, 147 )

        Indigo900 ->
            ( 26, 35, 126 )

        IndigoA100 ->
            ( 140, 158, 255 )

        IndigoA200 ->
            ( 83, 109, 254 )

        IndigoA400 ->
            ( 61, 90, 254 )

        IndigoA700 ->
            ( 48, 79, 254 )

        Blue50 ->
            ( 227, 242, 253 )

        Blue100 ->
            ( 187, 222, 251 )

        Blue200 ->
            ( 144, 202, 249 )

        Blue300 ->
            ( 100, 181, 246 )

        Blue400 ->
            ( 66, 165, 245 )

        Blue500 ->
            ( 33, 150, 243 )

        Blue600 ->
            ( 30, 136, 229 )

        Blue700 ->
            ( 25, 118, 210 )

        Blue800 ->
            ( 21, 101, 192 )

        Blue900 ->
            ( 13, 71, 161 )

        BlueA100 ->
            ( 130, 177, 255 )

        BlueA200 ->
            ( 68, 138, 255 )

        BlueA400 ->
            ( 41, 121, 255 )

        BlueA700 ->
            ( 41, 98, 255 )

        LightBlue50 ->
            ( 225, 245, 254 )

        LightBlue100 ->
            ( 179, 229, 252 )

        LightBlue200 ->
            ( 129, 212, 250 )

        LightBlue300 ->
            ( 79, 195, 247 )

        LightBlue400 ->
            ( 41, 182, 246 )

        LightBlue500 ->
            ( 3, 169, 244 )

        LightBlue600 ->
            ( 3, 155, 229 )

        LightBlue700 ->
            ( 2, 136, 209 )

        LightBlue800 ->
            ( 2, 119, 189 )

        LightBlue900 ->
            ( 1, 87, 155 )

        LightBlueA100 ->
            ( 128, 216, 255 )

        LightBlueA200 ->
            ( 64, 196, 255 )

        LightBlueA400 ->
            ( 0, 176, 255 )

        LightBlueA700 ->
            ( 0, 145, 234 )

        Cyan50 ->
            ( 224, 247, 250 )

        Cyan100 ->
            ( 178, 235, 242 )

        Cyan200 ->
            ( 128, 222, 234 )

        Cyan300 ->
            ( 77, 208, 225 )

        Cyan400 ->
            ( 38, 198, 218 )

        Cyan500 ->
            ( 0, 188, 212 )

        Cyan600 ->
            ( 0, 172, 193 )

        Cyan700 ->
            ( 0, 151, 167 )

        Cyan800 ->
            ( 0, 131, 143 )

        Cyan900 ->
            ( 0, 96, 100 )

        CyanA100 ->
            ( 132, 255, 255 )

        CyanA200 ->
            ( 24, 255, 255 )

        CyanA400 ->
            ( 0, 229, 255 )

        CyanA700 ->
            ( 0, 184, 212 )

        Teal50 ->
            ( 224, 242, 241 )

        Teal100 ->
            ( 178, 223, 219 )

        Teal200 ->
            ( 128, 203, 196 )

        Teal300 ->
            ( 77, 182, 172 )

        Teal400 ->
            ( 38, 166, 154 )

        Teal500 ->
            ( 0, 150, 136 )

        Teal600 ->
            ( 0, 137, 123 )

        Teal700 ->
            ( 0, 121, 107 )

        Teal800 ->
            ( 0, 105, 92 )

        Teal900 ->
            ( 0, 77, 64 )

        TealA100 ->
            ( 167, 255, 235 )

        TealA200 ->
            ( 100, 255, 218 )

        TealA400 ->
            ( 29, 233, 182 )

        TealA700 ->
            ( 0, 191, 165 )

        Green50 ->
            ( 232, 245, 233 )

        Green100 ->
            ( 200, 230, 201 )

        Green200 ->
            ( 165, 214, 167 )

        Green300 ->
            ( 129, 199, 132 )

        Green400 ->
            ( 102, 187, 106 )

        Green500 ->
            ( 76, 175, 80 )

        Green600 ->
            ( 67, 160, 71 )

        Green700 ->
            ( 56, 142, 60 )

        Green800 ->
            ( 46, 125, 50 )

        Green900 ->
            ( 27, 94, 32 )

        GreenA100 ->
            ( 185, 246, 202 )

        GreenA200 ->
            ( 105, 240, 174 )

        GreenA400 ->
            ( 0, 230, 118 )

        GreenA700 ->
            ( 0, 200, 83 )

        LightGreen50 ->
            ( 241, 248, 233 )

        LightGreen100 ->
            ( 220, 237, 200 )

        LightGreen200 ->
            ( 197, 225, 165 )

        LightGreen300 ->
            ( 174, 213, 129 )

        LightGreen400 ->
            ( 156, 204, 101 )

        LightGreen500 ->
            ( 139, 195, 74 )

        LightGreen600 ->
            ( 124, 179, 66 )

        LightGreen700 ->
            ( 104, 159, 56 )

        LightGreen800 ->
            ( 85, 139, 47 )

        LightGreen900 ->
            ( 51, 105, 30 )

        LightGreenA100 ->
            ( 204, 255, 144 )

        LightGreenA200 ->
            ( 178, 255, 89 )

        LightGreenA400 ->
            ( 118, 255, 3 )

        LightGreenA700 ->
            ( 100, 221, 23 )

        Lime50 ->
            ( 249, 251, 231 )

        Lime100 ->
            ( 240, 244, 195 )

        Lime200 ->
            ( 230, 238, 156 )

        Lime300 ->
            ( 220, 231, 117 )

        Lime400 ->
            ( 212, 225, 87 )

        Lime500 ->
            ( 205, 220, 57 )

        Lime600 ->
            ( 192, 202, 51 )

        Lime700 ->
            ( 175, 180, 43 )

        Lime800 ->
            ( 158, 157, 36 )

        Lime900 ->
            ( 130, 119, 23 )

        LimeA100 ->
            ( 244, 255, 129 )

        LimeA200 ->
            ( 238, 255, 65 )

        LimeA400 ->
            ( 198, 255, 0 )

        LimeA700 ->
            ( 174, 234, 0 )

        Yellow50 ->
            ( 255, 253, 231 )

        Yellow100 ->
            ( 255, 249, 196 )

        Yellow200 ->
            ( 255, 245, 157 )

        Yellow300 ->
            ( 255, 241, 118 )

        Yellow400 ->
            ( 255, 238, 88 )

        Yellow500 ->
            ( 255, 235, 59 )

        Yellow600 ->
            ( 253, 216, 53 )

        Yellow700 ->
            ( 251, 192, 45 )

        Yellow800 ->
            ( 249, 168, 37 )

        Yellow900 ->
            ( 245, 127, 23 )

        YellowA100 ->
            ( 255, 255, 141 )

        YellowA200 ->
            ( 255, 255, 0 )

        YellowA400 ->
            ( 255, 234, 0 )

        YellowA700 ->
            ( 255, 214, 0 )

        Amber50 ->
            ( 255, 248, 225 )

        Amber100 ->
            ( 255, 236, 179 )

        Amber200 ->
            ( 255, 224, 130 )

        Amber300 ->
            ( 255, 213, 79 )

        Amber400 ->
            ( 255, 202, 40 )

        Amber500 ->
            ( 255, 193, 7 )

        Amber600 ->
            ( 255, 179, 0 )

        Amber700 ->
            ( 255, 160, 0 )

        Amber800 ->
            ( 255, 143, 0 )

        Amber900 ->
            ( 255, 111, 0 )

        AmberA100 ->
            ( 255, 229, 127 )

        AmberA200 ->
            ( 255, 215, 64 )

        AmberA400 ->
            ( 255, 196, 0 )

        AmberA700 ->
            ( 255, 171, 0 )

        Orange50 ->
            ( 255, 243, 224 )

        Orange100 ->
            ( 255, 224, 178 )

        Orange200 ->
            ( 255, 204, 128 )

        Orange300 ->
            ( 255, 183, 77 )

        Orange400 ->
            ( 255, 167, 38 )

        Orange500 ->
            ( 255, 152, 0 )

        Orange600 ->
            ( 251, 140, 0 )

        Orange700 ->
            ( 245, 124, 0 )

        Orange800 ->
            ( 239, 108, 0 )

        Orange900 ->
            ( 230, 81, 0 )

        OrangeA100 ->
            ( 255, 209, 128 )

        OrangeA200 ->
            ( 255, 171, 64 )

        OrangeA400 ->
            ( 255, 145, 0 )

        OrangeA700 ->
            ( 255, 109, 0 )

        DeepOrange50 ->
            ( 251, 233, 231 )

        DeepOrange100 ->
            ( 255, 204, 188 )

        DeepOrange200 ->
            ( 255, 171, 145 )

        DeepOrange300 ->
            ( 255, 138, 101 )

        DeepOrange400 ->
            ( 255, 112, 67 )

        DeepOrange500 ->
            ( 255, 87, 34 )

        DeepOrange600 ->
            ( 244, 81, 30 )

        DeepOrange700 ->
            ( 230, 74, 25 )

        DeepOrange800 ->
            ( 216, 67, 21 )

        DeepOrange900 ->
            ( 191, 54, 12 )

        DeepOrangeA100 ->
            ( 255, 158, 128 )

        DeepOrangeA200 ->
            ( 255, 110, 64 )

        DeepOrangeA400 ->
            ( 255, 61, 0 )

        DeepOrangeA700 ->
            ( 221, 44, 0 )

        Brown50 ->
            ( 239, 235, 233 )

        Brown100 ->
            ( 215, 204, 200 )

        Brown200 ->
            ( 188, 170, 164 )

        Brown300 ->
            ( 161, 136, 127 )

        Brown400 ->
            ( 141, 110, 99 )

        Brown500 ->
            ( 121, 85, 72 )

        Brown600 ->
            ( 109, 76, 65 )

        Brown700 ->
            ( 93, 64, 55 )

        Brown800 ->
            ( 78, 52, 46 )

        Brown900 ->
            ( 62, 39, 35 )

        Grey50 ->
            ( 250, 250, 250 )

        Grey100 ->
            ( 245, 245, 245 )

        Grey200 ->
            ( 238, 238, 238 )

        Grey300 ->
            ( 224, 224, 224 )

        Grey400 ->
            ( 189, 189, 189 )

        Grey500 ->
            ( 158, 158, 158 )

        Grey600 ->
            ( 117, 117, 117 )

        Grey700 ->
            ( 97, 97, 97 )

        Grey800 ->
            ( 66, 66, 66 )

        Grey900 ->
            ( 33, 33, 33 )

        BlueGrey50 ->
            ( 236, 239, 241 )

        BlueGrey100 ->
            ( 207, 216, 220 )

        BlueGrey200 ->
            ( 176, 190, 197 )

        BlueGrey300 ->
            ( 144, 164, 174 )

        BlueGrey400 ->
            ( 120, 144, 156 )

        BlueGrey500 ->
            ( 96, 125, 139 )

        BlueGrey600 ->
            ( 84, 110, 122 )

        BlueGrey700 ->
            ( 69, 90, 100 )

        BlueGrey800 ->
            ( 55, 71, 79 )

        BlueGrey900 ->
            ( 38, 50, 56 )

        White ->
            ( 255, 255, 255 )

        Black ->
            ( 0, 0, 0 )
