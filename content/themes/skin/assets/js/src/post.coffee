# Nanobar override
Nanobar.prototype.go = (p) ->
  if (p == 100)
    p = 99.99
  this.bars[0].go( p );

$ ->

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

  $(window).ready ->
    if $('body').hasClass('post-template')
      $.initProgressBar()