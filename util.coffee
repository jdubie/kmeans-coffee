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

module.exports = util
