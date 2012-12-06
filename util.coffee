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

# mean
#
# @param arr {Array.<Number>}
util.mean = (arr) ->
  arr = arr.filter (elem) -> elem?
  console.log arr
  util.assert(arr.length isnt 0, 'Trying to take mean of empty array')
  arr.reduce(util.sum, 0) / arr.length

# sum
#
# @param x {Number}
# @param y {Number}
util.sum = (x, y) -> x + y

util.assert = (condition, message) ->
  unless condition
    console.error(message)
    process.exit()

module.exports = util
