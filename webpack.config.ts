import webpack from 'webpack'
import merge from 'webpack-merge'
import path from 'path'

const mode =
  process.env.npm_lifecycle_event === 'build' ? 'production' : 'development'

const common: webpack.Configuration = {
  mode,
  entry: path.join(__dirname, '/src/index.ts'),
  output: {
    path: path.resolve(__dirname, 'public'),
    filename: 'bundle.js',
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        loader: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx', '.elm'],
  },
  devServer: {
    contentBase: path.join(__dirname, 'public'),
    port: 3000,
    stats: 'errors-only',
    hot: true,
  },
}

const development: webpack.Configuration = {
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: 'elm-hot-webpack-loader',
          },
          {
            loader: 'elm-webpack-loader',
            options: {
              debug: true,
              forceWatch: true,
            },
          },
        ],
      },
    ],
  },
  plugins: [
    // Suggested for hot-loading
    new webpack.NamedModulesPlugin(),
    // Prevents compilation errors causing the hot loader to lose state
    new webpack.NoEmitOnErrorsPlugin(),
  ],
}

const production: webpack.Configuration = {
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: 'elm-webpack-loader',
            options: {
              optimize: true,
            },
          },
        ],
      },
    ],
  },
}

export default merge(common, mode === 'production' ? production : development)
