module.exports = {
  plugins: [],
  entry: {
    index: './src/index.js',
    easing: './src/easing.js',
    raf: './src/raf.js',
    bezier:'./src/bezier.js'
  },
  output: {
    path: __dirname + '/lib/',
    filename: '[name].js',
    libraryTarget:'umd'
  },
  module: {
    //加载器配置
    loaders: [
      {
        test: /\.css$/,
        loader: 'style-loader!css-loader'
      },
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