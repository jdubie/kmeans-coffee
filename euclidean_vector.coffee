module.exports = class EuclideanVector extends Vector
  constructor: (@arr) ->

  comp: (v) ->
    sum = 0
    for e2, i in v
      e1 = @arr[i]
      diff = e2 - e1
      sum += Math.pow(diff, 2)
    Math.sqrt(sum)

  toString: ->
    @arr
