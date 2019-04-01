const path = require('path');

module.exports = {
  entry: './frontend/index.js',
  mode: 'development',
  output: {
    path: path.resolve(__dirname, "app/assets/javascripts/"),
    filename: 'bundle.js'
  },
  devServer: {
    contentBase: '/app/assets/build'
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: ['babel-loader']
      }
    ]
  },
  resolve: {
    extensions: ['*', '.js', '.jsx']
  },
};
