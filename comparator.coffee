module.exports = (type, point, centroid) ->
  switch type
    when 'array', 'number'
      point - centroid
      #delta = point - centroid
      #return 0 if delta is 0
      #denom = Math.abs(point) + Math.abs(centroid)
      #result = 1 - Math.abs(delta) / denom # HACK: why is this good? maps into [0, 1)
      #if isNaN(result)
      #  console.log 'ahhhh NaN in comparison', type
      #  console.log point, centroid
      #  process.exit()
      #result

    when 'boolean'
      if isNaN(point)
        console.log 'ahhhh'
        process.exit()
      1
