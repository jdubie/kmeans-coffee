Vector = require './vector'

module.exports = class EuclideanVector extends Vector
  constructor: ->
    @arr = arguments

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

  toString: ->
    @arr
