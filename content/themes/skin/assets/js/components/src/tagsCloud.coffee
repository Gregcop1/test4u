Array.prototype.sortByKey = (key)->
  return @sort( (a, b) ->
    x = a[key]
    y = b[key]

    if (typeof x == "string")
      x = x.toLowerCase(); 
      y = y.toLowerCase();

    return ((x > y) ? -1 : ((x > y) ? 1 : 0))
  )

String.prototype.slugify = ()->
  return @replace(/\ /g, '-')
    .replace(/[éèêë]/g, 'e')
    .replace(/[àäâ]/g, 'a')
    .replace(/[ùüû]/g, 'u')
    .replace(/[ôö]/g, 'o')
    .replace(/[ïî]/g, 'i')

class TagsCloud
  tags: []

  constructor: (@target)->
    @getTags()
    
    return @

  getTags: ()->
    tags = []
    that = @

    $.get('/rss')
      .done((data)->
        if data
          tagList = $(data).find('category')
          tagList.each( ->
            name = $(this).text().trim() 
            pos = that.getTagByName(name, tags)
            
            if pos == -1
              tags.push({
                name: name
                weight: 1
                slug: name.slugify()
              })
            else
              tags[pos].weight += 1
          ) 
        
        # sort
        that.tags = tags.sortByKey('name')
        # build
        that.buildList()
      )

    return @


  getTagByName: (name, tags)->
    pos = -1
    tags.forEach( (item, index)->
      if name == item.name
        pos = index
    )  
    return pos

  buildList: ()->
    bounds = @getBounds()
    that = @
    $target = $(@target)
    $list = $('<p/>').addClass('list')
      .appendTo($target)
    @tags.forEach((item, index)->
      if index > 0
        $list.append(' - ')
      $list.append(
        $('<a/>').html(item.name)
          .attr('href', '/tag/'+item.slug+'/')
          .addClass(that.getClassByWeight(item.weight, bounds))
      )
    )
    return @

  getBounds: ()->
    min = 100000
    max = 0
    @tags.forEach((item) -> 
      if item.weight < min
        min = item.weight
      if item.weight > max
        max = item.weight
    )
    return {
      min: min
      max: max
    }

  getClassByWeight: (weight, bounds)->
    prefix = 'weight-'
    weightName = ['light', 'regular', 'medium', 'bold']
    step = (bounds.max - bounds.min) / weightName.length
    i = 0
    loop
      index = i
      i++
      break unless ((i+1) * step + bounds.min) <= weight
    return prefix + weightName[index]

$(window).on 'ready', ->
  new TagsCloud('#tagsCloud .panel');
