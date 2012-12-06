Vector     = require './vector'
util       = require './util'
parser     = require './parser'
comparator = require './comparator'
merger     = require './merger'
types       = require './type'

module.exports = class CrunchVector extends Vector

  constructor: (@d, @name, @category_code) ->
  get: (key) -> @d[key]
  set: (key, value) -> @d[key] = value

  comp: (v) ->
    dist = 0
    for name, {type} of @constructor.features
      delta = comparator(type, @get(name), v.get(name))
      dist += delta
    dist

  @parse: (buffer) ->
    data = buffer.toString('utf8')
    data = data.split('\n')

    # TODO: add try catch around JSON.parse
    data = data.filter (elem) -> elem isnt ''
    data = data.map (elem) -> JSON.parse(elem)

    # preprocess
    matrix = @preprocess(data)

    # interpolate missing values
    @interpolate(matrix)

    matrix

  @interpolate: (points) ->
    # numbers find means
    for name, {type} of @features
      switch type
        when 'number'
          numbers = points.map (vec) -> vec.get(name)
          mean = util.mean(numbers)
          points.forEach (vec) ->
            value = vec.get(name)
            if value
              vec.set(name, value / mean)
            else
              vec.set(name, 1)
  
  @center: (points) ->
    result = {}
    for name, {type} of @features
      row = points.map (p) -> p.get(name)
      result[name] = merger(type, row)
    new CrunchVector(result, 'centroid')

  toString: -> @d

  @preprocess: (data) ->
    data.map (elem) =>
      e = {}
      for field, {preprocess, type} of @features
        value = elem[field]
        value = types(task, value) for task in preprocess
        e[field] = value
      new CrunchVector(e, elem.name, elem.category_code)

  @features:

    # text
    overview: preprocess: ['html', 'tags'], type: 'frequency'

    # tags
    tag_list: preprocess: ['dash-tags', 'tags'], type: 'frequency'

    # category
    category_code: preprocess: ['uniary', 'tags'], type: 'frequency'

    #zip_code:      preprocess: ['uniary', 'tags'], type: 'frequency'
    #city:          preprocess: ['uniary', 'tags'], type: 'frequency'
    #state_code:    preprocess: ['uniary', 'tags'], type: 'frequency'
    #country_code:  preprocess: ['uniary', 'tags'], type: 'frequency'

    # arrays
    products:       preprocess: ['array'], type: 'number'
    relationships:  preprocess: ['array'], type: 'number'
    competitions:   preprocess: ['array'], type: 'number'
    providerships:  preprocess: ['array'], type: 'number'
    funding_rounds: preprocess: ['array'], type: 'number'
    investments:    preprocess: ['array'], type: 'number'
    acquisitions:   preprocess: ['array'], type: 'number'
    offices:        preprocess: ['array'], type: 'number'
    milestones:     preprocess: ['array'], type: 'number'
    video_embeds:   preprocess: ['array'], type: 'number'
    screenshots:    preprocess: ['array'], type: 'number'
    external_links: preprocess: ['array'], type: 'number'

    # numbers
    number_of_employees:  preprocess: [], type: 'number'
    founded_year:         preprocess: [], type: 'number'

    # currency
    #total_money_raised: preprocess: ['null', 'currency'], type: 'number'

    # boolean
    ipo:              preprocess: ['boolean'], type: 'number'
    blog_url:         preprocess: ['boolean'], type: 'number'
    blog_feed_url:    preprocess: ['boolean'], type: 'number'
    twitter_username: preprocess: ['boolean'], type: 'number'
