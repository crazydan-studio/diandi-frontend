前端开发
===================================

## 工程构建

安装依赖：

```bash
yarn install
```

> `npm install`会安装失败，只能通过`Yarn`安装依赖。

启动本地调试：

```bash
npm run dev
```

构建发布产物：

```bash
npm run prod
```

## 参考资料

### 设计

- [The problem with dropdown fields (and what you should use instead)](https://designsmarts.co/the-problem-with-dropdowns/):
  下拉选择框的利弊及其替换方案。下拉隐藏了可选项，增加了用户点击量，降低了使用效率

### 技术

- [A guide to Native code and Effect Managers in Elm - Part 1: Commands](https://dev.to/jjant/a-guide-to-native-code-and-effect-managers-in-elm-part-1-commands-1k6n):
  Elm原生代码编写方案，仅适用于自编译Elm编译器的情况。
  也可以在Node项目中通过NodeJs将指定目录的原生代码打包放在`~/.elm/0.19.1/packages/elm/`下的方式实现。
  注：必须在`elm/`或`elm-explorations/`目录下才会被识别为Elm内部包，以实现原生代码的加载
- [elm/browser](https://package.elm-lang.org/packages/elm/browser/latest/Browser):
  编写URL路由的单页面应用
- [elm/http](https://package.elm-lang.org/packages/elm/http/latest/Http):
  如何做HTTP请求
- [NoRedInk/json-decode-pipeline](https://package.elm-lang.org/packages/NoRedInk/elm-json-decode-pipeline/latest):
  JSON编解码库
- [dillonkearns/elm-markdown](https://package.elm-lang.org/packages/dillonkearns/elm-markdown/7.0.1/):
  Elm Markdown解析库
  - [Custom HTML Block Rendering (with elm-ui)](https://ellie-app.com/d7R3b9FsHfCa1):
    通过Elm UI渲染Markdown，可以自定义样式，对自定义标签的渲染等
- [Material Design Components](https://m2.material.io/components):
  Material Design组件样式
- [Ant Design Icons for Elm](https://package.elm-lang.org/packages/lemol/ant-design-icons-elm/latest/):
  Elm的Ant Design Svg图标
  - [图标列表](https://ant.design/components/icon): 方便查看
- [Elm Ui Widgets](https://package.elm-lang.org/packages/Orasund/elm-ui-widgets/3.4.0/):
  Elm UI组件库
  - [演示](https://orasund.github.io/elm-ui-widgets/Button)
- [Elm Simple Animation](https://package.elm-lang.org/packages/andrewMacmurray/elm-simple-animation/2.3.0/):
  通过构造CSS实现的动画，无状态，不需要更新模型
  - [Elm Animator](https://package.elm-lang.org/packages/mdgriffith/elm-animator/1.1.1/):
    有状态的动画，需要更新模型，但可提供更加复杂和高级的动画控制
- [arsduo/elm-ui-drag-drop](https://package.elm-lang.org/packages/arsduo/elm-ui-drag-drop/latest/):
  支持Elm UI的拖拽库
- [rtfeldman/elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/18.0.0/):
  支持添加`style`属性，并为其生成css class
