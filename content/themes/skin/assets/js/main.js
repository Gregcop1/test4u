(function() {
  $(function() {
    $.initTargetBlank = function() {
      $('a[href^="http"]').each(function() {
        if (!$(this).attr('href').match(/http:\/\/devnotes/)) {
          return $(this).attr('target', '_blank');
        }
      });
      return this;
    };
    $.initFootNotes = function() {
      $('.post p').each(function() {
        var newText, pattern, text;
        text = $(this).html();
        pattern = /\[\^([0-9])*\]:(.*)/g;
        if (text.match(pattern) !== null) {
          newText = text.replace(pattern, '<span id="fnref-$1">$2<a href="#fn-$1">↩</a></span>');
          return $(this).html(newText).wrap($('<li/>').addClass('footnote'));
        }
      });
      $('.footnote').wrapAll($('<ol/>').addClass('footnotes'));
      $('.post').find('h1, h2, h3, h4, h5, h6, p, li, td, blockquote, pre').each(function() {
        var newText, pattern, text;
        text = $(this).html();
        pattern = /\[\^([0-9])*\]/g;
        if (text.match(pattern) !== null) {
          newText = text.replace(pattern, '<sup><a id="fn-$1" href="#fnref-1">$1</a></sup>');
          return $(this).html(newText);
        }
      });
      return this;
    };
    $.initSmoothScrollOnAnchor = function() {
      $('a[href^=#]').on('click', function(e) {
        console.log($(e.target).attr('href'));
        e.preventDefault();
        return $('html,body').animate({
          scrollTop: $($(e.target).attr('href')).offset().top
        }, 500);
      });
      return this;
    };
    return $(window).ready(function() {
      $.initTargetBlank();
      $.initFootNotes();
      $.initSmoothScrollOnAnchor();
      if (nightMode) {
        nightMode.bind();
      }
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
