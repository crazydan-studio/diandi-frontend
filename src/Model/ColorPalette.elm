module Model.ColorPalette exposing
    ( Palette(..)
    , PaletteGroup
    , fromString
    , maybePaletteDecoder
    , paletteDecoder
    , paletteGroups
    )

{-| -}

import Json.Decode as Decode exposing (Decoder)


paletteDecoder : Decoder Palette
paletteDecoder =
    paletteDecoderHelper
        (\v -> v)
        (\p -> Decode.fail ("Unknown color palette: " ++ p))


maybePaletteDecoder : Decoder (Maybe Palette)
maybePaletteDecoder =
    paletteDecoderHelper
        (\v -> Just v)
        (\_ -> Decode.succeed Nothing)


paletteDecoderHelper : (Palette -> a) -> (String -> Decoder a) -> Decoder a
paletteDecoderHelper success fail =
    Decode.string
        |> Decode.andThen
            (\p ->
                case fromString p of
                    Just v ->
                        Decode.succeed (success v)

                    Nothing ->
                        fail p
            )


{-| 调色板分组

    PaletteGroup 分组名 [调色板列表, ...]

-}
type PaletteGroup
    = PaletteGroup String (List Palette)


{-| 调色板
配色信息来自于[Material Design Color Palette by](https://blog.avada.io/css/color-palettes#material-design-color-palette-badboy)

代码生成JS脚本(通过浏览器元素选择器，选中配色表所在的iframe)：

```js
var allPalettes = [];
var paletteGroups = {};
var toColor = function (c) { return c.replaceAll(/rgb\((\d+), (\d+), (\d+)\)/g, '(rgb255 $1 $2 $3)'); };

document.querySelectorAll('card list').forEach(function (list) {
  var paletteGroupName = '';
  var palettes = [];

  list.querySelectorAll('item').forEach(function(item, index) {
    var name = item.firstElementChild.innerText.replaceAll(/\n+.+/g, '').replaceAll(/((^|-)(.))/g, function ($0, $1, $2, $3) {
       return $3.toUpperCase();
    });
    if (index == 0) { paletteGroupName = name; }
    if (index == 0 && !name.includes('Black') && !name.includes('White')) { return; }

    var style = getComputedStyle(item);
    var value = [name, 'Background.color ' + toColor(style.backgroundColor), 'Font.color ' + toColor(style.color)];

    palettes.push(value);
  });

  paletteGroups[paletteGroupName] = palettes;
  allPalettes = allPalettes.concat(palettes);
});

// 数据定义
console.log(allPalettes.map(function (p) { return p[0]; }).join(' | '));

// 转换为Element.Color
console.log('    case palette of\n' + allPalettes.map(function (p) {
  return '        ' + p[0] + ' ->\n            [' + p[1] + ', ' + p[2] + ']';
}).join('\n'));

// 从字符串转换Palette
console.log('    case (String.toLower p) of\n' + allPalettes.map(function (p) {
  var name = p[0];
  return '        "' + name.toLowerCase() + '" ->\n            Just ' + name + '';
}).join('\n') + '\n        _ ->\n            Nothing');

// 调色板分组表
console.log('    [' + Object.keys(paletteGroups).map(function (group) {
  var palettes = paletteGroups[group];
  return 'PaletteGroup "' + group
    + '" [' + palettes.map(function (p) { return p[0]; }).join('\n        , ')
    + ']';
}).join('\n    , ') + ']');
```

-}
type Palette
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


fromString : String -> Maybe Palette
fromString p =
    case String.toLower p of
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

        _ ->
            Nothing


paletteGroups : List PaletteGroup
paletteGroups =
    [ PaletteGroup "Red"
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
    , PaletteGroup "Pink"
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
    , PaletteGroup "Purple"
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
    , PaletteGroup "Deep Purple"
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
    , PaletteGroup "Indigo"
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
    , PaletteGroup "Blue"
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
    , PaletteGroup "Light Blue"
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
    , PaletteGroup "Cyan"
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
    , PaletteGroup "Teal"
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
    , PaletteGroup "Green"
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
    , PaletteGroup "Light Green"
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
    , PaletteGroup "Lime"
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
    , PaletteGroup "Yellow"
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
    , PaletteGroup "Amber"
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
    , PaletteGroup "Orange"
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
    , PaletteGroup "Deep Orange"
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
    , PaletteGroup "Brown"
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
    , PaletteGroup "Grey"
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
    , PaletteGroup "Blue Grey"
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
    ]
