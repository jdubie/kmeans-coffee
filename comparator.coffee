module.exports = (type, point, centroid) ->
  switch type
    when 'array', 'number'
      delta = point - centroid
      return 1 if isNaN(delta)
      denom = Math.abs(point) + Math.abs(centroid)
      result = 1 - Math.abs(delta) / denom # HACK: why is this good? maps into [0, 1)
      if isNaN(result)
        console.log 'ahhhh', type
        process.exit()
      result

    when 'boolean'
      if isNaN(point)
        console.log 'ahhhh'
        process.exit()
      1
