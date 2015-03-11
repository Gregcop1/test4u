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
      if !$(this).attr('href').match(/http:\/\/www\.test4u/)
        $(this).attr('target', '_blank')
    )
    return @

  $.initSmoothScrollOnAnchor = ()->
    $('a[href*=#]').on('click', (e)->
      e.preventDefault()
      $target = $(e.target).closest('a')
      $('html,body').animate({scrollTop: ($( document.getElementById($target.attr( 'href').replace('#','')) ).offset().top - 70) }, 500)
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

  $.initResponsive = ()->
    if $('body').width() <= 801
      # prepare menu
      $newMenu = $('<ul/>').attr('id', 'responsiveMenu')
        .addClass('responsiveMenu')
      $('.mainNav li').not(':first').each(->
        $(this).appendTo($newMenu)
      )
      $('body').prepend($newMenu)

      # prepare content
      $('main.content').attr('id', 'responsiveContent')
        .addClass('responsiveContent')

      # prepare menu button
      $('<button/>').attr('id', 'responsiveButton')
        .addClass('responsiveButton')
        .html('☰')
        .prependTo('body')
    return @

  $launchResponsiveMenu = ()->
    # build slideout
    if $('body').width() <= 801
      slideout = new Slideout(
        'panel': document.getElementById('responsiveContent'),
        'menu': document.getElementById('responsiveMenu'),
        'padding': 153,
        'tolerance': 70
      )

      $('#responsiveButton').on 'click', (e)=>
        slideout.toggle()
        return @
    return @

  $(window).ready ->
    $.initResponsive()
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

  $(window).load ->
    $launchResponsiveMenu()

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
