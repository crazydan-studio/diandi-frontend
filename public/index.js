"use strict";

import pkg from "../package.json";

import { Elm } from "../src/Main";
import {
  getFirstBrowserLanguage,
  findNotTranslatedTexts,
} from "../src/Native/lang";
import "../src/Native/event";
import "../src/Native/webcomponents";

import "./index.css";

// Note: 采用 Browser.application 方式初始化，无需挂载到dom节点
const app = Elm.Main.init({
  // https://guide.elm-lang.org/interop/flags.html
  flags: {
    title: pkg.title,
    description: pkg.description,
    lang: getFirstBrowserLanguage(),
    screen: {
      height: window.innerHeight,
      width: window.innerWidth,
    },
  },
});

app.ports.findNotTranslatedTexts.subscribe(function () {
  const results = findNotTranslatedTexts();

  app.ports.getNotTranslatedTexts.send(results);
});
