/** @type {import('tailwindcss').Config} */
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
  },
  plugins: [],
};
