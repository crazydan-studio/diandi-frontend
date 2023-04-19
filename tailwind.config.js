/** @type {import('tailwindcss').Config} */
const plugin = require("tailwindcss/plugin");

module.exports = {
  // https://github.com/csaltos/elm-tailwindcss
  content: ["./src/**/*.elm"],
  // Note: 在任意 root 节点加上 class="dark"，即可启用暗黑模式
  darkMode: "class",
  theme: {
    extend: {
      animation: {
        "zoom-in": "zoom-in forwards 0.7s ease-out 1",
      },
      keyframes: {
        "zoom-in": {
          "0%": {
            transform: "scale(1)",
            "transform-origin": "center",
            opacity: 1,
            overflow: "hidden",
          },
          "50%": {
            transform: "scale(0)",
            opacity: 0,
          },
          "100%": {
            width: 0,
            "min-width": 0,
            height: 0,
            "min-height": 0,
            transform: "scale(0)",
            opacity: 0,
            padding: 0,
            margin: 0,
          },
        },
      },
    },
    hljs: {
      // https://highlightjs.org/static/demo/
      theme: "night-owl",
      custom: {
        base: {
          // 使用 tailwindcss 设置的背景色
          background: "transparent",
        },
      },
    },
  },
  safelist: [
    {
      pattern: /hljs+/,
    },
  ],
  plugins: [
    // https://tailwindcss.com/docs/typography-plugin
    require("@tailwindcss/typography"),
    // https://github.com/GeoffSelby/tailwind-highlightjs
    require("tailwind-highlightjs"),
    // 专门针对表格的奇偶行定义变量，
    // 以解决 odd 和 even 变量创建的 nth 选择器是针对当前节点而非其子孙 tr 节点的问题
    // https://tailwindcss.com/docs/plugins#dynamic-variants
    plugin(function ({ matchVariant }) {
      // tr-nth-[odd], tr-nth-[even], tr-[2n+1]
      matchVariant(
        "tr-nth",
        (value) => {
          return `& tr:nth-child(${value})`;
        }
      );
    }),
  ],
};
