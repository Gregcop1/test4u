# Nanobar override
Nanobar.prototype.go = (p) ->
  if (p == 100)
    p = 99.99
  this.bars[0].go( p );

$ ->

  $.initAverageTime = ()->
    words =  $('.post').text().replace(/\r?\n|\r/g, ' ').split(' ').filter((str) -> str != '')
    $('#progress').append($('<p/>').html('Temps de lecture estimé : ' + Math.round(words.length / 200)+'min'))
    # var StrippedString = OriginalString;

    return @

  $.initProgressBar = ()->
    progress = new Nanobar({
      id: 'progressBar'
      target: $('#progress').get(0)
    })
    $('#progress').removeClass 'active'
    $('#progress').on 'mouseenter', (e)-> 
      $(e.target).closest('#progress').addClass('active')
    $('#progress').on 'mouseleave', (e)-> 
      $(e.target).closest('#progress').removeClass('active')

    $(window).on('scroll', ()->
      currentScroll = $('body').scrollTop()
      maxS = $(document).height() - $(window).height()
      progress.go(Math.ceil(currentScroll * 100 / maxS))
    )

    return @

  $(window).ready ->
    if $('body').hasClass('post-template')
      $.initAverageTime()
      $.initProgressBar()