# Nanobar override
Nanobar.prototype.go = (p) ->
  if (p == 100)
    p = 99.99
  this.bars[0].go( p );

$ ->

  $.initGallery = ->
    $imgs = []
    $a = $('<a/>').addClass('gallery-item')
    count = $('.gallery img').length
    wClass = 'w-4'

    if count % 3 == 0
      wClass = 'w-3'
    else if count % 5 == 0
      wClass = 'w-5'
    $a.addClass(wClass)
    $('.gallery img').each(->
      $imgs.push($a.clone()
        .attr('href', $(this).attr('src').trim())
        .attr('title', $(this).attr('alt').trim())
        .attr('rel', 'gallery')
        .css('backgroundImage', 'url('+$(this).attr('src')+')'))
    )

    $('.gallery').empty()
    $imgs.forEach((item)->
      $('.gallery').append(item)
    )
    jQuery('.gallery-item').fancybox({
      padding: 0
      })
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

  jQuery(document).on 'ready', ->
    if $('body').hasClass('post-template')
      $.initGallery()
      $.initProgressBar()
