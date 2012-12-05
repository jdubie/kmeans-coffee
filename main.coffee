fs = require 'fs'
optimist = require 'optimist'
kmeans = require './kmeans'

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
data = data.map (i) -> new Vector(i)

# Actually run k-means
{centers} = kmeans {data, k: argv.k, Vector}

# print result
console.log 'centroids:'
for center, i in centers
  console.log 'center', i, (center.points.map (p) -> p.name)
