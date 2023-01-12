"use strict";

import { Elm } from "../src/Main";
import { getFirstBrowserLanguage, findNotTranslatedTexts } from "./js/lang";
import pkg from "../package.json";

import "./index.css";

const fadeTimeout = 500;
const loading = document.getElementById("loading");

function runApp() {
  // Note: 采用 Browser.application 方式初始化，无需挂载到dom节点
  const app = Elm.Main.init({
    // https://guide.elm-lang.org/interop/flags.html
    flags: {
      title: pkg.title,
      description: pkg.description,
      lang: getFirstBrowserLanguage().replaceAll("-", "_"),
    },
  });

  app.ports.findNotTranslatedTexts.subscribe(function () {
    const results = findNotTranslatedTexts();

    app.ports.getNotTranslatedTexts.send(results);
  });

  loading.remove();
}

loading.style.transition = fadeTimeout / 1000.0 + "s";
loading.style.opacity = "0";

setTimeout(runApp, fadeTimeout);
