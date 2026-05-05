const fs = require('fs');
const packageJson = fs.readFileSync('./package.json');
const version = JSON.parse(packageJson).version || 0;
const webpack = require('webpack');
const isProduction = process.env.NODE_ENV === 'production';

module.exports = {
  configureWebpack: {
    plugins: [
      new webpack.DefinePlugin({
        'process.env': {
          PACKAGE_VERSION: '"' + version + '"'
        }
      })
    ]
  },
  lintOnSave: false,
  productionSourceMap: false,
  publicPath: isProduction ? '/multitrack-player/' : '/'
};
