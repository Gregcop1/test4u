# # main: website wide scripts

$ ->

  $.initFixNav = ()->
    window.addEventListener('scroll', (e)->
      if window.scrollY
        $('body').addClass('fixedNav')
      else
        $('body').removeClass('fixedNav')
    )
    return @

  $.initTargetBlank = ()->
    $('a[href^="http"]').each(->
      if !$(this).attr('href').match(/http:\/\/test4u/)
        $(this).attr('target', '_blank')
    )
    return @

  $.initSmoothScrollOnAnchor = ()->
    $('a[href^=#]').on('click', (e)->     
      e.preventDefault()
      $('html,body').animate({scrollTop: ($( document.getElementById($(e.target).attr( 'href').replace('#','')) ).offset().top - 70) }, 500)
    )

    return @

  $.initCaption = ()->
    $('p img').each(()->
      if $(this).attr('alt') != ''
        $('<span/>').addClass('caption')
          .html($('<span/>').addClass('caption-text')
            .html($(this).attr('alt')))
          .insertAfter($(this))
    )

    return @

  $(window).ready ->
    $.initFixNav()
    $.initTargetBlank()
    $.initSmoothScrollOnAnchor()
    $.initCaption()

    # Handle src update on hover event
    $(".no-touch img.hover").hoverSrc()

    # Enable placeholder management for outdated browsers
    unless Modernizr.input.placeholder
      $("input").each ->
        $(this).placeholder()  unless $(this).attr("placeholder") is ""


    ###

    # Add backToTop anchor when half a screen  is scrolled
    $('body').append('<a id="backToTop" href="#">Back to top</a>')
    $('#backToTop').backToTop($(window).height()/2)

    # Handle pulldown
    $('.pulldown').pulldown()

    # Refresh scroll offset of backToTop button appearance
    $(window).bind 'resize', ->
      $('#backToTop').backToTop($(window).height()/2)

    ###