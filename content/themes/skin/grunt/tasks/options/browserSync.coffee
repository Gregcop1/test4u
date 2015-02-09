module.exports =
  dev:
    options:
      watchTask: true
      ghostMode:
        clicks: true
        scroll: true
        links: true
      port: '<%= in8.port %>'
    bsFiles:
      src: [
        '<%= in8.jsDest %>/*.js',
        '<%= in8.componentsDest %>/*.js',
        '<%= in8.cssDest %>/*.css',
        '<%= in8.imgSrc %>/**',
        '<%= in8.htmlSrc %>/*.hbs'
      ]
