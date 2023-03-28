点滴(DianDi)前端工程
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

## 许可证

[GPLv3](./LICENSE)

## 参考资料

### 设计

- [The problem with dropdown fields (and what you should use instead)](https://designsmarts.co/the-problem-with-dropdowns/):
  下拉选择框的利弊及其替换方案。下拉隐藏了可选项，增加了用户点击量，降低了使用效率

### 技术

- [A guide to Native code and Effect Managers in Elm - Part 1: Commands](https://dev.to/jjant/a-guide-to-native-code-and-effect-managers-in-elm-part-1-commands-1k6n):
  Elm 原生代码编写方案，仅适用于自编译 Elm 编译器的情况。
  也可以在 Node 项目中通过 NodeJs 将指定目录的原生代码打包放在`~/.elm/0.19.1/packages/elm/`下的方式实现。
  注：必须在`elm/`或`elm-explorations/`目录下才会被识别为 Elm 内部包，以实现原生代码的加载

- [elm/browser](https://package.elm-lang.org/packages/elm/browser/latest/Browser):
  编写 URL 路由的单页面应用
- [elm/http](https://package.elm-lang.org/packages/elm/http/latest/Http):
  如何做 HTTP 请求
- [NoRedInk/json-decode-pipeline](https://package.elm-lang.org/packages/NoRedInk/elm-json-decode-pipeline/latest):
  JSON 编解码库
- [dillonkearns/elm-markdown](https://package.elm-lang.org/packages/dillonkearns/elm-markdown/7.0.1/):
  Elm Markdown 解析库
  - [Custom HTML Block Rendering (with elm-ui)](https://ellie-app.com/d7R3b9FsHfCa1):
    通过 Elm UI 渲染 Markdown，可以自定义样式，对自定义标签的渲染等
- [Elm Ui Widgets](https://package.elm-lang.org/packages/Orasund/elm-ui-widgets/3.4.0/):
  Elm UI 组件库
  - [演示](https://orasund.github.io/elm-ui-widgets/Button)
- [Elm Simple Animation](https://package.elm-lang.org/packages/andrewMacmurray/elm-simple-animation/2.3.0/):
  通过构造 CSS 实现的动画，无状态，不需要更新模型
  - [Elm Animator](https://package.elm-lang.org/packages/mdgriffith/elm-animator/1.1.1/):
    有状态的动画，需要更新模型，但可提供更加复杂和高级的动画控制
- [arsduo/elm-ui-drag-drop](https://package.elm-lang.org/packages/arsduo/elm-ui-drag-drop/latest/):
  支持 Elm UI 的拖拽库
- [dnd-list + Elm UI](https://annaghi.github.io/dnd-list/introduction/basic-elm-ui):
  支持 Elm UI 的拖拽库
- [Rich Text Editor Toolkit Markdown example](https://mweiss.github.io/elm-rte-toolkit/#/examples/markdown):
  支持 Markdown 的富文本编辑器，基于`contenteditable`实现，可学习其数据结构的划分
- [Mini-Rte](https://package.elm-lang.org/packages/dkodaj/rte/latest/):
  简单的文本编辑器，采取自绘方案，代码较少，有利于从底层学起

- [Material Design Components](https://m2.material.io/components):
  Material Design 组件样式
  - [Material-UI](https://v4.mui.com/getting-started/installation/):
    React 的实现
- [Ant Design Icons for Elm](https://package.elm-lang.org/packages/lemol/ant-design-icons-elm/latest/):
  Elm 的 Ant Design Svg 图标
  - [图标列表](https://ant.design/components/icon): 方便查看
- [Deep dive CSS: font metrics, line-height and vertical-align](https://iamvdo.me/en/blog/css-font-metrics-line-height-and-vertical-align):
  文本行距与垂直对齐原理
- [箭头导航的实现](https://stackoverflow.com/a/27636505)
- [What is JavaScript's CompositionEvent?](https://stackoverflow.com/questions/51226598/what-is-javascripts-compositionevent-please-give-examples):
  对`CompositionEvent`的解释，其为 IME 输入时的事件，可用于正确处理输入法输入的字符
