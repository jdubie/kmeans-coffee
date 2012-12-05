util = {}

# randomIndex
#
# @param arr {Array}
util.randomIndex = (arr) ->
  arr[Math.floor(Math.random()*arr.length)]

# argmin
#
# @param arr {Array.<Number>}
util.argmin = (arr) ->
  arr.indexOf(Math.min(arr...))

# zeros
#
# @description returns an array 0 of length n
# @param n {Number}
util.zeros = (n) -> [0...n].map -> 0

module.exports = util
