util = {}

# randomIndex
#
# @param n {Number}
util.randomN = (n) ->
  Math.floor(Math.random()*n)

# randomWithReplacement
#
# @param k {Number}
# @param n {Number}
util.randomWithReplacement = (n,k) ->
  result = []
  for i in [0...k]
    while true
      index = util.randomN(n)
      break unless index in result
    result.push(index)
  result


# argmin
#
# @param arr {Array.<Number>}
util.argmin = (arr) ->
  arr.indexOf(util.min(arr))

#
util.min = (arr) ->
  Math.min(arr...)

# zeros
#
# @description returns an array 0 of length n
# @param n {Number}
util.zeros = (n) -> [0...n].map -> 0

module.exports = util
