fs = require 'fs'
optimist = require 'optimist'
kmeans = require './kmeans'
util = require './util'

argv = optimist
  .usage('K-means clustering\ncoffee kmeans -k 3 -f euclidean.json')
  .demand('k')
  .describe('k','Number of clusters')
  .demand('f')
  .alias('f', 'file')
  .describe('f', 'json file containing data')
  .alias('v', 'vector')
  .describe('v', 'vector class implementation for data')
  .argv

# Vector implementation
Vector = require("./#{argv.vector}")

# read in data
buffer = fs.readFileSync(argv.file)
data = Vector.parse(buffer)

# Actually run k-means
{centers} = kmeans {data, k: argv.k, Vector}

# print result
console.log 'centroids:'
for center, i in centers
  if center.points[0].name
    console.log i, center.points.map (point) -> point.name
  else
    console.log center.centroid.toString()
