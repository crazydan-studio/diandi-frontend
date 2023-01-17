"use strict";

// https://stackoverflow.com/questions/1043339/javascript-for-detecting-browser-language-preference#answer-29106129
export function getFirstBrowserLanguage() {
  const nav = window.navigator;
  const browserLanguagePropertyKeys = [
    "language",
    "browserLanguage",
    "systemLanguage",
    "userLanguage",
  ];

  if (document.documentElement && document.documentElement.lang) {
    return document.documentElement.lang;
  }

  // support for HTML 5.1 "navigator.languages"
  if (Array.isArray(nav.languages)) {
    for (let i = 0; i < nav.languages.length; i++) {
      let language = nav.languages[i];
      if (language && language.length) {
        return language;
      }
    }
  }

  // support for other well known properties in browsers
  for (let i = 0; i < browserLanguagePropertyKeys.length; i++) {
    let language = nav[browserLanguagePropertyKeys[i]];
    if (language && language.length) {
      return language;
    }
  }

  return "";
}

export function findNotTranslatedTexts() {
  const results = [];

  document
    .querySelectorAll('[i18n-not-translated="true"]')
    .forEach(function (node) {
      const modules = node.getAttribute("i18n-not-translated-modules");
      const text = node.innerText;

      results.push({ modules: modules, text: text });
    });

  return results;
}
