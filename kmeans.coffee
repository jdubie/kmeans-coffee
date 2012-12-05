util = require './util'

# do actual kmeans algorith
module.exports = ({data, k, n, Vector}) ->
  n ?= 100

  # initialize centers
  # TODO user heuristics to get distant initial points
  #centers = [0...k].map -> centroid: util.randomIndex(data)
  centers = [0...k].map (i) -> centroid: data[i+2] # TODO remove this

  # iterate til converge or n times
  for i in [0...n]
    centers.forEach (center) -> center.points = [] # reintialize point assigments
     
    # compute distances to all centers
    errors = []
    for vec in data
      dists = centers.map (center) -> vec.comp(center.centroid)
      centers[util.argmin(dists)].points.push(vec)
      errors.push Math.min(dists...)

    error = errors.reduce(((x,y) -> x + y), 0)
    console.log 'iteration', i, 'error', error

    # reassign centers
    centers.forEach (center) -> center.centroid = Vector.center(center.points)

  # TODO real return value
  {centers}


