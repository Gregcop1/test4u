module.exports = (grunt)->
  grunt.registerTask 'default', [
    'concurrent:builds'
    'autoprefixer:build'
    'browserSync'
    'watch'
  ]