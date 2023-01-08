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
