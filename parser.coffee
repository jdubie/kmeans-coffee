parser = {}

#
# non-nullable types
#

parser.array = (input) -> input.length
parser.number = (input) -> input
parser.currency = (input) ->
  [__, amount, unit] = input.match(/\$([0-9\.]+)([BMk]?)/)
  amount = parseFloat(amount)
  switch unit
    when ''  then amount
    when 'k' then amount * 1000
    when 'M' then amount * 1000*1000
    when 'B' then amount * 1000*1000*1000



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
  return unless input
  parser[type](input)
