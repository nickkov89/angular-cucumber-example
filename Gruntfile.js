module.exports = function(grunt) {

  grunt.initConfig({
    connect: {
      server: {
        options: {
          keepalive: true,
          port: 9001,
          base: 'app'
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-connect');

  grunt.registerTask('server', ['connect:server']);
};
