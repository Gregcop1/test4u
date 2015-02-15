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

  $.initFootNotes = ()->
    # replace definition markers
    $('.post p').each(()->
      text = $(this).html()
      pattern = /\[\^([0-9])*\]:(.*)/g
      if text.match(pattern) != null
        newText = text.replace(pattern, '<span id="fnref-$1">$2<a href="#fn-$1">↩</a></span>')
        $(this).html(newText)
          .wrap($('<li/>').addClass('footnote'))
    )
    $('.footnote').wrapAll($('<ol/>').addClass('footnotes'))

    # replace reference
    $('.post').find('h1, h2, h3, h4, h5, h6, p, li, td, blockquote, pre').each(()->
      text = $(this).html()
      pattern = /\[\^([0-9])*\]/g
      if text.match(pattern) != null
        newText = text.replace(pattern, '<sup><a id="fn-$1" href="#fnref-1">$1</a></sup>')
        $(this).html(newText)
    )

    return @

  $.initSmoothScrollOnAnchor = ()->
    $('a[href^=#]').on('click', (e)->     
      e.preventDefault()
      $('html,body').animate({scrollTop:$( $(e.target).attr( 'href') ).offset().top}, 500)
    )

    return @

  $(window).ready ->
    $.initFixNav()
    $.initTargetBlank()
    $.initFootNotes()
    $.initSmoothScrollOnAnchor()
    if nightMode
      nightMode.bind()

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