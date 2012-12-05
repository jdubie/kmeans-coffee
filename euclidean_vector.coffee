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
    points = points.map (point) -> point.arr
    sumArrays = (x,y) ->
      result = []
      for xi, i in x
        yi = y[i]
        result[i] = xi + yi
      return result

    sum = points.reduce(sumArrays, util.zeros(points.length))
    result = sum.map (x) -> x / points.length
    new EuclideanVector(result)

  toString: -> @arr
