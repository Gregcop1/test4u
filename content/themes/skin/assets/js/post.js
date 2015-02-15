(function() {
  Nanobar.prototype.go = function(p) {
    if (p === 100) {
      p = 99.99;
    }
    return this.bars[0].go(p);
  };

  $(function() {
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
    return $(window).ready(function() {
      if ($('body').hasClass('post-template')) {
        return $.initProgressBar();
      }
    });
  });

}).call(this);

//# sourceMappingURL=post.js.map
