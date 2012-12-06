natural = require 'natural'
natural.PorterStemmer.attach()

module.exports = (task, value) ->
  switch task
    when 'html'
      value.tokenizeAndStem()
    when 'dash-tags'
      dash_tags = value.filter (tag) -> tag.match /-/
      value = value.concat(d.split('-')) for d in dash_tags
      value
    when 'uniary'
      [value]
    when 'tags'
      result = {}
      result[k] = 0 for k in value
      result[k]++ for k in value # unnecessary reloop but looks nicer
      result
