natural = require 'natural'
natural.PorterStemmer.attach()

module.exports = (task, value) ->

  switch task
    when 'currency'
      return unless value
      input = value
      [__, amount, unit] = input.match(/\C?[$£€]([0-9\.]+)([BMk]?)/)
      amount = parseFloat(amount)
      switch unit
        when ''  then amount
        when 'k' then amount * 1000
        when 'M' then amount * 1000*1000
        when 'B' then amount * 1000*1000*1000
    when 'boolean'
      if value? then 1 else 0
    when 'html'
      return [] if value is '' or not value?
      value.tokenizeAndStem()
    when 'dash-tags'
      return [] if value is '' or not value?
      value = value.split(', ')
      dash_tags = value.filter (tag) -> tag.match /-/
      value = value.concat(d.split('-')) for d in dash_tags
      value
    when 'uniary'
      return [] if value is '' or not value?
      value = value.split(', ')
      [value]
    when 'array'
      value.length
    when 'tags'
      result = {}
      result[k] = 0 for k in value
      result[k]++ for k in value # unnecessary reloop but looks nicer
      result
