# Nanobar override
Nanobar.prototype.go = (p) ->
  if (p == 100)
    p = 99.99
  this.bars[0].go( p );

$ ->

  $.initGallery = ->
    $imgs = []
    $a = $('<a/>').addClass('gallery-item')
    $('.gallery img').each(->
      $imgs.push($a.clone()
        .attr('href', $(this).attr('src'))  
        .css('backgroundImage', 'url('+$(this).attr('src')+')'))  
    )

    $('.gallery').empty()
    $imgs.forEach((item)->
      $('.gallery').append(item)
      # console.log item
      # item.fancybox()
    )
    jQuery('.gallery-item').fancybox()
    return @

  $.initProgressBar = ()->
    progress = new Nanobar({
      id: 'progressBar'
      target: $('#progress').get(0)
    })
    
    $(window).on('scroll', ()->
      currentScroll = $('body').scrollTop()
      maxS = $('.post-content').height() - ($(window).height()/2)
      progress.go(Math.ceil(currentScroll * 100 / maxS))
    )

    return @

  $(window).on 'ready', ->
    if $('body').hasClass('post-template')
      $.initGallery()
      $.initProgressBar()