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
    },

    cucumberjs: {
      files: 'features/*.feature'
    }
  });

  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-cucumber');

  grunt.registerTask('server', ['connect:server']);
  grunt.registerTask('test', ['cucumberjs']);
};
