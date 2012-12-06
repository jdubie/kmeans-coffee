module.exports = (type, point, centroid) ->
  switch type
    when 'array', 'number'
      Math.pow(point - centroid, 2)
