util = require './util'

# do actual kmeans algorith
module.exports = ({data, k, n, Vector}) ->
  n ?= 100

  # initialize centers
  # TODO user heuristics to get distant initial points
  centers = util.randomWithReplacement(data.length, k)
  console.log centers
  centers = centers.map (center) -> centroid: data[center]

  # iterate til converge or n times
  for i in [0...n]
    centers.forEach (center) -> center.points = [] # reintialize point assigments
     
    # compute distances to all centers
    errors = []
    for vec in data
      dists = centers.map (center) -> vec.comp(center.centroid)
      centers[util.argmin(dists)].points.push(vec)
      errors.push Math.min(dists...)

    _error = errors.reduce(((x,y) -> x + y), 0)
    break if error is _error
    error = _error
    console.log 'iteration', i, 'error', error

    # reassign centers
    centers.forEach (center) -> center.centroid = Vector.center(center.points)

  {centers}


