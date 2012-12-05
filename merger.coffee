module.exports = (type, row) ->
  switch type
    when 'array'
      #row = row.filter (elem) -> not isNaN(elem)
      if row.length is 0
        console.log 'herere'
        process.exit()
      row.reduce(((x,y) -> x + y), 0) / row.length
