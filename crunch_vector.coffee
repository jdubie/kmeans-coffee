Vector     = require './vector'
util       = require './util'
parser     = require './parser'
comparator = require './comparator'
merger     = require './merger'

module.exports = class CrunchVector extends Vector

  constructor: (@d, @name, @category_code) ->
  get: (key) -> @d[key]
  set: (key, value) -> @d[key] = value

  comp: (v) ->
    dist = 0
    for name, type of @constructor.features
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
    matrix = data.map (elem) =>
      e = {}
      for field, type of @features
        e[field] = parser(type, elem[field])
      new CrunchVector(e, elem.name, elem.category_code)

    # interpolate missing values
    @interpolate(matrix)

    # divide by means and log
    #@normalize(matrix)

    matrix

  @interpolate: (points) ->
    # numbers find means
    for name, type of @features
      numbers = points.map (vec) -> vec.get(name)
      mean = util.mean(numbers)
      points.forEach (vec) ->
        value = vec.get(name)
        if value
          vec.set(name, value / mean)
        else
          vec.set(name, 1)
        #if value
        #  vec.set(name, value)
        #else
        #  vec.set(name, mean)
  
  @center: (points) ->
    result = {}
    for name, type of @features
      row = points.map (p) -> p.get(name)
      result[name] = merger(row)
    new CrunchVector(result, 'centroid')

  toString: -> @d

  @features:
    # arrays
    products:       'array'
    relationships:  'array'
    competitions:   'array'
    providerships:  'array'
    funding_rounds: 'array'
    investments:    'array'
    acquisitions:   'array'
    offices:        'array'
    milestones:     'array'
    video_embeds:   'array'
    screenshots:    'array'
    external_links: 'array'

    # numbers
    number_of_employees: 'number'
    founded_year: 'number'
    founded_month: 'number'
    founded_day: 'number'

    # currency
    total_money_raised: 'currency'

    # boolean
    ipo:                  'boolean'
    email_address:        'boolean'
    homepage_url:         'boolean'
    blog_url:             'boolean'
    blog_feed_url:        'boolean'
    twitter_username:     'boolean'

    # location
    #zip_code:       'zip_code'
    #city:           'city'
    #state_code:     'state_code'
    #country_code:   'country_code'
    #latitude:       'latitude'
    #longitude:      'longitude'

    # TODO relationships pictures
    # 'relationships_with_photo'
    #overview:       'text'
    #category_code:  '' # TODO important
    #tag_list
