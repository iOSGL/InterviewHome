var webpack = require('webpack');

// var commonsPlugin = new webpack.optimize.CommonsChunkPlugin('common.js');
module.exports = {
  //插件项
  plugins: [],
  //页面入口文件配置
  entry: {
    index: './demo/index.js'
  },
  //入口文件输出配置
  output: {
    path: __dirname + '/dist/',
    filename: '[name].js'
  },
  devServer: {
    contentBase: "./demo",  //以public为根目录提供文件
    historyApiFallback: true,
    inline: true,
    publicPath: '/dist/'
  },
  module: {
    //加载器配置
    loaders: [
      {
        test: /\.css$/,
        loader: 'style-loader!css-loader'
      },
      // {
      //   test: /\.js$/,
      //   loader: 'jsx-loader?harmony'
      // },
      {
        test: /\.(png|jpg)$/,
        loader: 'url-loader?limit=8192'
      },
      {
        test: /\.jsx?$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
        query: {
          presets: ['es2015','stage-0']
        }
      }
    ]
  }
};