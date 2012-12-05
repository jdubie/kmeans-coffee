module.exports = (type, row) ->
  switch type
    when 'number', 'array', 'boolean'
      row = row.filter (elem) -> not isNaN(elem)
      row.reduce(((x,y) -> x + y), 0) / row.length
