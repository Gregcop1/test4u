(function() {
  Nanobar.prototype.go = function(p) {
    if (p === 100) {
      p = 99.99;
    }
    return this.bars[0].go(p);
  };

  $(function() {
    $.initGallery = function() {
      var $a, $imgs, count, wClass;
      $imgs = [];
      $a = $('<a/>').addClass('gallery-item');
      count = $('.gallery img').length;
      wClass = 'w-4';
      if (count % 5 === 0) {
        wClass = 'w-5';
      } else if (count % 3 === 0) {
        wClass = 'w-3';
      }
      $a.addClass(wClass);
      $('.gallery img').each(function() {
        return $imgs.push($a.clone().attr('href', $(this).attr('src').trim()).attr('title', $(this).attr('alt').trim()).attr('rel', 'gallery').css('backgroundImage', 'url(' + $(this).attr('src') + ')'));
      });
      $('.gallery').empty();
      $imgs.forEach(function(item) {
        return $('.gallery').append(item);
      });
      jQuery('.gallery-item').fancybox({
        padding: 0
      });
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
    return jQuery(document).on('ready', function() {
      if ($('body').hasClass('post-template')) {
        $.initGallery();
        return $.initProgressBar();
      }
    });
  });

}).call(this);

//# sourceMappingURL=post.js.map
