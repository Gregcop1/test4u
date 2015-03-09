(function() {
  $(function() {
    $.initFixNav = function() {
      window.addEventListener('scroll', function(e) {
        if (window.scrollY) {
          return $('body').addClass('fixedNav');
        } else {
          return $('body').removeClass('fixedNav');
        }
      });
      return this;
    };
    $.initTargetBlank = function() {
      $('a[href^="http"]').each(function() {
        if (!$(this).attr('href').match(/http:\/\/www\.test4u/)) {
          return $(this).attr('target', '_blank');
        }
      });
      return this;
    };
    $.initSmoothScrollOnAnchor = function() {
      $('a[href*=#]').on('click', function(e) {
        var $target;
        e.preventDefault();
        $target = $(e.target).closest('a');
        return $('html,body').animate({
          scrollTop: $(document.getElementById($target.attr('href').replace('#', ''))).offset().top - 70
        }, 500);
      });
      return this;
    };
    $.initCaption = function() {
      $('p img').each(function() {
        if ($(this).attr('alt') !== '') {
          return $('<span/>').addClass('caption').html($('<span/>').addClass('caption-text').html($(this).attr('alt'))).insertAfter($(this));
        }
      });
      return this;
    };
    return $(window).ready(function() {
      $.initFixNav();
      $.initTargetBlank();
      $.initSmoothScrollOnAnchor();
      $.initCaption();
      $(".no-touch img.hover").hoverSrc();
      if (!Modernizr.input.placeholder) {
        return $("input").each(function() {
          if ($(this).attr("placeholder") !== "") {
            return $(this).placeholder();
          }
        });
      }

      /*
      
       * Add backToTop anchor when half a screen  is scrolled
      $('body').append('<a id="backToTop" href="#">Back to top</a>')
      $('#backToTop').backToTop($(window).height()/2)
      
       * Handle pulldown
      $('.pulldown').pulldown()
      
       * Refresh scroll offset of backToTop button appearance
      $(window).bind 'resize', ->
        $('#backToTop').backToTop($(window).height()/2)
       */
    });
  });

}).call(this);

//# sourceMappingURL=main.js.map
