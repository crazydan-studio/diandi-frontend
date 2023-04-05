"use strict";

import { Elm } from "../src/Main";
import { getFirstBrowserLanguage, findNotTranslatedTexts } from "./js/lang";
import pkg from "../package.json";

import "./js/event";
import "./css/index.css";
import "./css/animation.css";

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
