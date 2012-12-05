Vector = require './vector'
util = require './util'

module.exports = class EuclideanVector extends Vector
  constructor: (@arr) ->

  comp: (v) ->
    sum = 0
    for e2, i in v.arr
      e1 = @arr[i]
      diff = e2 - e1
      term = Math.pow(diff, 2)
      sum += term
    sum

  # returns center of a set of instances of this class
  @center: (points) ->
    sum = []
    for vec in points
      for y, i in vec.arr
        if sum[i]
          sum[i] += y
        else
          sum[i] = y
    result = sum.map (x) -> x / points.length
    new EuclideanVector(result)

  @parse: (buffer) ->
    data = JSON.parse(buffer)

  toString: -> @arr
