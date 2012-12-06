util = require './util'

module.exports = (row) ->
  util.assert(row.length isnt 0, 'row length zero in merger')
  row.reduce(((x,y) -> x + y), 0) / row.length
