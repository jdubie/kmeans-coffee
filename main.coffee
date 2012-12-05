fs = require 'fs'
optimist = require 'optimist'
kmeans = require './kmeans'

argv = optimist
  .usage('K-means clustering\ncoffee kmeans -k 3 -f euclidean.json')
  .demand('k')
  .describe('k','Number of clusters')
  .default('k', 3)
  .demand('f')
  .alias('f', 'file')
  .describe('f', 'json file containing data')
  .default('f', 'euclidean.json')
  .alias('v', 'vector')
  .default('t', 'euclidean_vector')
  .alias('t', 'type')
  .describe('t', 'vector class implementation for data')
  .argv

# Vector implementation
Vector = require("./#{argv.type}")

# read in data
set = fs.readFileSync(argv.file)
set = JSON.parse(set)
data = set.map (i) -> new Vector(i)

# Actually run k-means
{centers} = kmeans {data, k: argv.k, Vector}

# print result
console.log 'centroids', centers.map (c) -> c.centroid
