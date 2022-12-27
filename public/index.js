"use strict";

import { Elm } from "../src/Main";
import { getFirstBrowserLanguage } from "./js/lang";

import "./index.css";

window.runApp = function () {
  const app = Elm.Main.init({
    node: document.getElementById("app"),
    // https://guide.elm-lang.org/interop/flags.html
    flags: {
      lang: getFirstBrowserLanguage(),
      height: window.innerHeight,
      width: window.innerWidth,
    },
  });
};
