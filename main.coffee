EuclideanVector = require 'euclidean_vector'
kmeans = require 'kmeans'

k = 3

set = [
  [0, 1]
  [1, 2]
  [1, 3]
  [8, 4]
  [9, 3]
  [8, 2]
  [8, 8]
  [8, 6]
  [5, 8]
  [7, 7]
  [4, 7]
  [3, 8]
  [2, 9]
  [6, 9]
]

data = set.map (i) -> new EuclideanVector(i)

{centers} = kmeans {data, k, Vector: EuclideanVector}

console.log 'centroids', centers.map (c) -> c.centroid
