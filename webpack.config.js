// https://github.com/simonh1000/elm-webpack-starter/blob/master/webpack.config.js
const path = require("path");
const { merge } = require("webpack-merge");

const ClosurePlugin = require("closure-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const HTMLWebpackPlugin = require("html-webpack-plugin");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");

// Production CSS assets - separate, minimised file
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const packageJson = require("./package.json");

const MODE =
  process.env.npm_lifecycle_event === "prod" ? "production" : "development";
const withDebug = !process.env["npm_config_nodebug"] && MODE === "development";
// this may help for Yarn users
// const withDebug = !npmParams.includes("--nodebug");
console.log(
  "\x1b[36m%s\x1b[0m",
  `** elm-webpack-starter: mode "${MODE}", withDebug: ${withDebug}\n`
);

const srcDir = "src";
const publicDir = "public";
const __ROOT__ = path.dirname(__filename);
function filepath(...paths) {
  return path.join(__ROOT__, ...paths);
}

const common = {
  mode: MODE,
  entry: filepath(publicDir, "index.js"),
  output: {
    path: filepath("dist"),
    publicPath: "",
    // FIXME webpack -p automatically adds hash when building for production
    filename: MODE === "production" ? "[name]-[hash].js" : "index.js",
  },
  plugins: [
    new HTMLWebpackPlugin({
      title: packageJson.title,
      author: packageJson.author,
      url: packageJson.url,
      image: packageJson.image,
      lang: packageJson.lang,
      description: packageJson.description,

      // Use this template to get basic responsive meta tags
      template: filepath(publicDir, "index.html"),
      // disable css and js inject to allow to put the resources at any location manually
      inject: false,
    }),
  ],
  resolve: {
    modules: [filepath(srcDir), filepath(publicDir), filepath("node_modules")],
    extensions: [".js", ".mjs", ".elm", ".css", ".png"],
  },
  module: {
    rules: [
      {
        test: /\.(js|mjs)$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: "url-loader",
          options: {
            limit: 10000,
            mimetype: "application/font-woff",
          },
        },
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: "file-loader",
      },
      {
        test: /\.(jpe?g|png|gif|svg)$/i,
        exclude: [/elm-stuff/, /node_modules/],
        loader: "file-loader",
      },
    ],
  },
};

if (MODE === "development") {
  module.exports = merge(common, {
    module: {
      rules: [
        {
          test: /\.css$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: [
            "style-loader",
            {
              loader: "css-loader",
              options: {
                url: false,
              },
            },
          ],
        },
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: [
            { loader: "elm-hot-webpack-loader" },
            {
              loader: "elm-webpack-loader",
              // https://github.com/elm-community/elm-webpack-loader
              options: {
                cwd: filepath("."),
                // add Elm's debug overlay to output
                debug: withDebug,
              },
            },
          ],
        },
      ],
    },
    devServer: {
      // 构建异常时不刷新整个页面
      hot: "only",
      historyApiFallback: true,
      // 静态文件目录不能包含代码，否则，修改代码会造成页面完全刷新
      static: {
        directory: filepath(publicDir, "assets"),
      },
      // https://webpack.js.org/configuration/dev-server/#devserverproxy
      proxy: [
        {
          context: ["/api", "/auth"],
          target: "http://localhost:8080",
        },
      ],
    },
  });
}

if (MODE === "production") {
  module.exports = merge(common, {
    optimization: {
      minimizer: [
        new ClosurePlugin(
          { mode: "STANDARD" },
          {
            // compiler flags here
            //
            // for debugging help, try these:
            //
            // formatting: 'PRETTY_PRINT',
            // debug: true
            // renaming: false
          }
        ),
        new OptimizeCSSAssetsPlugin({}),
      ],
    },
    plugins: [
      // Delete everything from output-path (/dist) and report to user
      new CleanWebpackPlugin({
        root: filepath("."),
        exclude: [],
        verbose: true,
        dry: false,
      }),
      // Copy static assets
      new CopyWebpackPlugin({
        patterns: [
          {
            from: filepath(publicDir, "assets"),
          },
        ],
      }),
      new MiniCssExtractPlugin({
        // Options similar to the same options in webpackOptions.output
        // both options are optional
        filename: "[name]-[hash].css",
      }),
    ],
    module: {
      rules: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: {
            loader: "elm-webpack-loader",
            // https://github.com/elm-community/elm-webpack-loader
            options: {
              cwd: filepath("."),
              optimize: true,
            },
          },
        },
        {
          test: /\.css$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: [
            MiniCssExtractPlugin.loader,
            {
              loader: "css-loader",
              options: {
                url: false,
              },
            },
          ],
        },
      ],
    },
  });
}
