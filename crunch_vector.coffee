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

    #competitions:         'array'
    #providerships:        'array'
    #acquisitions:         'array'
    #offices:              'array'
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

  constructor: (d) ->
    if d
      @name = d.name
      @d = {}
      for name, type of @constructor.features
        @d[name] = parser(type, d[name])

  comp: (v) ->
    dist = 0
    for name, type of @constructor.features
      delta = comparator(type, @d[name], v.d[name])
      dist += Math.pow(delta, 2)
    dist
    #comp: (v) ->
    #  sum = 0
    #  for e2, i in v.arr
    #    e1 = @arr[i]
    #    diff = e2 - e1
    #    term = Math.pow(diff, 2)
    #    sum += term
    #  sum

  @center: (points) ->
    result = {}
    for name, type of @features
      row = points.map (p) -> p.d[name]
      result[name] = merger(type, row)
    v = new CrunchVector()
    v.d = result
    v
  
  @parse: (buffer) ->
    data = buffer.toString('utf8')
    result = data.split('\n')

    # TODO: add try catch around JSON.parse
    result = result.filter (elem) -> elem isnt ''
    result = result.map (elem) -> JSON.parse(elem)
    result

  toString: ->
