util = require './util'

module.exports = (type, point, centroid) ->
  switch type
    when 'frequency'
      sum = 0
      for word, freq of point
        sum += freq * centroid[word] if centroid[word]
      mag = util.mag(point) * util.mag(centroid)
      return 100 if sum is 0
      mag / sum
    when 'number'
      Math.pow(point - centroid, 2)
    else util.assert(false, 'bad type in comparator')

