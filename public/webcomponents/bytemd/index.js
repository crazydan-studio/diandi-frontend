import { LitElement } from "lit";

import { Editor, Viewer } from "bytemd";
import "bytemd/dist/index.css";
// Note: 需将其 fonts 复制到站点 /fonts 下
import "katex/dist/katex.css";

import gfm from "@bytemd/plugin-gfm";
import highlight from "@bytemd/plugin-highlight";
import breaks from "@bytemd/plugin-breaks";
import gemoji from "@bytemd/plugin-gemoji";
import math from "@bytemd/plugin-math";
import mermaid from "@bytemd/plugin-mermaid";
import mediumZoom from "@bytemd/plugin-medium-zoom";
import rehypeMinifyWhitespace from "rehype-minify-whitespace";

// Note: 框架的 css 机制在不使用 shadow dom 时不可用，
// 只能以 import 方式全局引入样式
import "./index.css";

// https://medium.com/dailyjs/leveraging-webpack-power-to-import-all-files-from-one-folder-cddedd3201b3
const bytemdLocales = loadPluginLocales(
  require.context("/node_modules/bytemd/locales", false, /\.json$/)
);
const gfmLocales = loadPluginLocales(
  require.context("/node_modules/@bytemd/plugin-gfm/locales", false, /\.json$/)
);
const mathLocales = loadPluginLocales(
  require.context("/node_modules/@bytemd/plugin-math/locales", false, /\.json$/)
);
const mermaidLocales = loadPluginLocales(
  require.context(
    "/node_modules/@bytemd/plugin-mermaid/locales",
    false,
    /\.json$/
  )
);

function loadPluginLocales(ctx) {
  const locales = {};
  ctx
    .keys()
    .filter((name) => name.startsWith("./"))
    .forEach((name) => {
      const locale = name.replaceAll(/^\.\/(.+)\.json$/g, "$1");
      locales[locale] = ctx(name);
    });
  return locales;
}

function plugins(lang) {
  return [
    gfm({
      locale: gfmLocales[lang],
    }),
    breaks(),
    highlight(),
    gemoji(),
    math({
      locale: mathLocales[lang],
      // https://github.com/KaTeX/KaTeX/issues/2796
      katexOptions: { output: "html" },
    }),
    mermaid({
      locale: mermaidLocales[lang],
    }),
    mediumZoom(),
    {
      // 清除生成的 HTML 中标签间的换行符，以避免在展示页面中因为换行符而出现不可见的空白行
      // https://github.com/rehypejs/rehype-minify/tree/main/packages/rehype-minify-whitespace
      rehype(processor) {
        processor.use(rehypeMinifyWhitespace);
        return processor;
      },
    },
  ];
}

export class ByteMDViewer extends LitElement {
  // https://lit.dev/docs/components/properties/#when-properties-change
  static properties = {
    bytemd: { state: true },
    // attributes
    value: { attribute: true },
  };

  // 不使用 shadow dom 以支持全局样式设置
  // https://lit.dev/docs/components/shadow-dom/#implementing-createrenderroot
  createRenderRoot() {
    return this;
  }

  // Note: 首次初始化已完成，此刻，render() 模板中的节点均已就绪
  firstUpdated() {
    // https://github.com/bytedance/bytemd/blob/main/README.md
    this.bytemd = new Viewer({
      target: this.renderRoot,
      props: {
        value: this.value,
        plugins: plugins(),
      },
    });
  }

  updated(changedProperties) {
    if (changedProperties.has("value")) {
      this.bytemd.$set({ value: this.value });
    }
  }
}

export class ByteMDEditor extends LitElement {
  static properties = {
    bytemd: { state: true },
    // attributes
    value: { attribute: true },
    // split, tab, auto
    mode: { attribute: true },
    lang: { attribute: true },
    placeholder: { attribute: true },
  };

  createRenderRoot() {
    return this;
  }

  firstUpdated() {
    this.bytemd = new Editor({
      target: this.renderRoot,
      props: {
        value: this.value,
        mode: this.mode,
        placeholder: this.placeholder,
        locale: bytemdLocales[this.lang],
        plugins: plugins(this.lang),
      },
    });

    this.bytemd.$on("change", (e) => {
      const value = e.detail.value;
      this.value = value;
      this.bytemd.$set({ value });

      // https://lit.dev/docs/components/events/#dispatching-events
      // Note: 需将 value 放在新的结构体中，
      // 否则，在监听端会在最后一次仅收到最后输入的内容
      const detail = { value };
      const event = new CustomEvent("change", {
        detail,
        bubbles: true,
        composed: true,
        cancelable: true,
      });
      this.dispatchEvent(event);
    });
  }

  updated(changedProperties) {
    if (changedProperties.has("value")) {
      this.bytemd.$set({ value: this.value });
    } else if (changedProperties.has("lang")) {
      this.bytemd.$set({
        locale: bytemdLocales[this.lang],
        plugins: plugins(this.lang),
      });
    } else if (changedProperties.has("mode")) {
      this.bytemd.$set({ mode: this.mode });
    }
  }
}

// Note: 组件名称中必须包含连字符
customElements.define("bytemd-viewer", ByteMDViewer);
customElements.define("bytemd-editor", ByteMDEditor);