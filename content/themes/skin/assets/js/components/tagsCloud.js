(function() {
  var TagsCloud;

  Array.prototype.sortByKey = function(key) {
    return this.sort(function(a, b) {
      var x, y, _ref, _ref1;
      x = a[key];
      y = b[key];
      if (typeof x === "string") {
        x = x.toLowerCase();
        y = y.toLowerCase();
      }
      return (_ref = x > y) != null ? _ref : -{
        1: (_ref1 = x > y) != null ? _ref1 : {
          1: 0
        }
      };
    });
  };

  String.prototype.slugify = function() {
    return this.replace(/\ /g, '-').replace(/[éèêë]/g, 'e').replace(/[àäâ]/g, 'a').replace(/[ùüû]/g, 'u').replace(/[ôö]/g, 'o').replace(/[ïî]/g, 'i');
  };

  TagsCloud = (function() {
    TagsCloud.prototype.tags = [];

    function TagsCloud(target) {
      this.target = target;
      this.getTags();
      return this;
    }

    TagsCloud.prototype.getTags = function() {
      var tags, that;
      tags = [];
      that = this;
      $.get('/rss').done(function(data) {
        var tagList;
        if (data) {
          tagList = $(data).find('category');
          tagList.each(function() {
            var name, pos;
            name = $(this).text().trim();
            pos = that.getTagByName(name, tags);
            if (pos === -1) {
              return tags.push({
                name: name,
                weight: 1,
                slug: name.slugify()
              });
            } else {
              return tags[pos].weight += 1;
            }
          });
        }
        that.tags = tags.sortByKey('name');
        return that.buildList();
      });
      return this;
    };

    TagsCloud.prototype.getTagByName = function(name, tags) {
      var pos;
      pos = -1;
      tags.forEach(function(item, index) {
        if (name === item.name) {
          return pos = index;
        }
      });
      return pos;
    };

    TagsCloud.prototype.buildList = function() {
      var $list, $target, bounds, that;
      bounds = this.getBounds();
      that = this;
      $target = $(this.target);
      $list = $('<p/>').addClass('list').appendTo($target);
      this.tags.forEach(function(item, index) {
        if (index > 0) {
          $list.append(' - ');
        }
        return $list.append($('<a/>').html(item.name).attr('href', '/tag/' + item.slug + '/').addClass(that.getClassByWeight(item.weight, bounds)));
      });
      return this;
    };

    TagsCloud.prototype.getBounds = function() {
      var max, min;
      min = 100000;
      max = 0;
      this.tags.forEach(function(item) {
        if (item.weight < min) {
          min = item.weight;
        }
        if (item.weight > max) {
          return max = item.weight;
        }
      });
      return {
        min: min,
        max: max
      };
    };

    TagsCloud.prototype.getClassByWeight = function(weight, bounds) {
      var i, index, prefix, step, weightName;
      prefix = 'weight-';
      weightName = ['light', 'regular', 'medium', 'bold'];
      step = (bounds.max - bounds.min) / weightName.length;
      i = 0;
      while (true) {
        index = i;
        i++;
        if (!(((i + 1) * step + bounds.min) <= weight)) {
          break;
        }
      }
      return prefix + weightName[index];
    };

    return TagsCloud;

  })();

  $(window).on('ready', function() {
    return new TagsCloud('#tagsCloud .panel');
  });

}).call(this);

//# sourceMappingURL=tagsCloud.js.map
