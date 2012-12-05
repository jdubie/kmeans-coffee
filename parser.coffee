parser = {}

#
# non-nullable types
#

parser.array = (input) -> input.length
parser.number = (input) -> input

#
# nullable types
#

parser.boolean = (input) -> if input then 1 else 0


#city
#country_code
#latitude
#longitude
#state_code
#zip_code

module.exports = (type, input) ->
  switch type
    when 'array', 'number'
      return NaN if input is null

  parser[type](input)
