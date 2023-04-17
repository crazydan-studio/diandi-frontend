/** @type {import('tailwindcss').Config} */
module.exports = {
  // https://github.com/csaltos/elm-tailwindcss
  content: ["./src/**/*.elm"],
  // Note: 在任意 root 节点加上 class="dark"，即可启用暗黑模式
  darkMode: "class",
  theme: {
    extend: {},
  },
  plugins: [],
};
