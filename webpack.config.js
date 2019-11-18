const webConfig = {
  entry: "./src/index.ts",
  output: {
    filename: "main.js"
  },
  target: "web",
  devtool: "inline-source-map",
  module: {
    rules: [{ test: /\.ts$/, use: "ts-loader", exclude: /node_modules/ }]
  },
  resolve: {
    extensions: [".ts", ".js"]
  }
};

module.exports = [webConfig];
