var hem = new (require('hem'));
var cmd = process.argv.slice(2)[0];
var command = /build|server|watch/.test(cmd) ? cmd : 'server';
var less = require('hem-less');
var options = {
  server: { compress: false },
  watch:  { compress: false },
  build:  { compress: true }
};
less.setOptions(options[command]);
hem.compilers.less = less.compiler;
hem.exec(command, options);
