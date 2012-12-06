util = require './util'

module.exports = (type, row) ->
  switch type
    when 'frequency'
      result = {}
      for e in row
        for word, freq of e
          if result[word]
            result[word]++
          else
            result[word] = 1
      result
    when 'number'
      util.assert(row.length isnt 0, 'row length zero in merger')
      row.reduce(((x,y) -> x + y), 0) / row.length
