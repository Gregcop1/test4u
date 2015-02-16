(function() {
  Nanobar.prototype.go = function(p) {
    if (p === 100) {
      p = 99.99;
    }
    return this.bars[0].go(p);
  };

  $(function() {
    $.initGallery = function() {
      var $a, $imgs;
      $imgs = [];
      $a = $('<a/>').addClass('gallery-item');
      $('.gallery img').each(function() {
        return $imgs.push($a.clone().attr('href', $(this).attr('src')).css('backgroundImage', 'url(' + $(this).attr('src') + ')'));
      });
      $('.gallery').empty();
      $imgs.forEach(function(item) {
        return $('.gallery').append(item);
      });
      jQuery('.gallery-item').fancybox();
      return this;
    };
    $.initProgressBar = function() {
      var progress;
      progress = new Nanobar({
        id: 'progressBar',
        target: $('#progress').get(0)
      });
      $(window).on('scroll', function() {
        var currentScroll, maxS;
        currentScroll = $('body').scrollTop();
        maxS = $('.post-content').height() - ($(window).height() / 2);
        return progress.go(Math.ceil(currentScroll * 100 / maxS));
      });
      return this;
    };
    return $(window).on('ready', function() {
      if ($('body').hasClass('post-template')) {
        $.initGallery();
        return $.initProgressBar();
      }
    });
  });

}).call(this);

//# sourceMappingURL=post.js.map
