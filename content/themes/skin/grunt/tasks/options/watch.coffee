module.exports =

  html:
    files:'<%= in8.htmlSrc %>/*.hbs'
    options:
      reload: true

  sass:
    files:'<%= in8.cssSrc %>/*.scss'
    tasks: [
      'sass:build',
      'autoprefixer:build'
    ]

  images:
    files:[
      '<%= in8.imgSrc %>/**'
    ]

  coffee:
    files: ['<%= in8.jsSrc %>/*.coffee', '<%= in8.componentsSrc %>/*.coffee']
    tasks: 'newer:coffee'