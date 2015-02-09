(function() {
  Nanobar.prototype.go = function(p) {
    if (p === 100) {
      p = 99.99;
    }
    return this.bars[0].go(p);
  };

  $(function() {
    $.initAverageTime = function() {
      var words;
      words = $('.post').text().replace(/\r?\n|\r/g, ' ').split(' ').filter(function(str) {
        return str !== '';
      });
      $('#progress').append($('<p/>').html('Temps de lecture estimé : ' + Math.round(words.length / 200) + 'min'));
      return this;
    };
    $.initProgressBar = function() {
      var progress;
      progress = new Nanobar({
        id: 'progressBar',
        target: $('#progress').get(0)
      });
      $('#progress').removeClass('active');
      $('#progress').on('mouseenter', function(e) {
        return $(e.target).closest('#progress').addClass('active');
      });
      $('#progress').on('mouseleave', function(e) {
        return $(e.target).closest('#progress').removeClass('active');
      });
      $(window).on('scroll', function() {
        var currentScroll, maxS;
        currentScroll = $('body').scrollTop();
        maxS = $(document).height() - $(window).height();
        return progress.go(Math.ceil(currentScroll * 100 / maxS));
      });
      return this;
    };
    return $(window).ready(function() {
      if ($('body').hasClass('post-template')) {
        $.initAverageTime();
        return $.initProgressBar();
      }
    });
  });

}).call(this);

//# sourceMappingURL=post.js.map
