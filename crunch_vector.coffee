Vector     = require './vector'
util       = require './util'
parser     = require './parser'
comparator = require './comparator'
merger     = require './merger'

module.exports = class CrunchVector extends Vector
  @features:
    # arrays
    products: 'array'
    relationships: 'array'
    competitions: 'array'
    providerships: 'array'
    funding_rounds: 'array'
    investments: 'array'
    acquisitions: 'array'
    offices: 'array'
    milestones: 'array'
    video_embeds: 'array'
    screenshots: 'array'
    external_links: 'array'

    # numbers
    number_of_employees: 'number'

    #ipo:                  'boolean'
    #screenshots:          'array'
    #email_address:        'boolean'
    #number_of_employees:  'number'
    #relationships:        'array'

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
    #total_money_raised: 'money'

  constructor: (@d, name) ->
    @name = @d.name
    delete @d.name

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
    matrix = data.map (elem) ->
      e = {}
      for field, type of features
        e[field] = parser(type, elem[field])
      new Vector(elem)

    # interpolate missing values
    @interpolate(matrix)

    # divide by means and log
    @normalize(matrix)

    result

  @interpolate: (points) ->
    # numbers find means
    for name, type of @features
      switch type
        when 'number'
          numbers = points.map (vec) -> point.get(name)
          console.log numbers
          mean = util.mean(numbers)
          points.forEach (point) ->
            point.set(name, mean) unless point.get(name)
  
  @center: (points) ->
    result = {}
    for name, type of @features
      row = points.map (p) -> p.get(name)
      result[name] = merger(type, row)
    v = new CrunchVector()
    v.d = result
    v

  toString: ->
