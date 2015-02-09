module.exports =
  minify:
    options:
      banner: '/*! minified <%= grunt.template.today("yyyy-mm-dd HH:MM:ss") %> */'
    expand: true
    cwd: '<%= in8.cssDest %>/'
    src: ['*.css', '!rte.css']
    dest: '<%= in8.cssDest %>/'