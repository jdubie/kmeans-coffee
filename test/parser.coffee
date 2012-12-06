parser = require 'parser'

describe 'parser', ->
  describe '#currency', ->
    it 'should parse 0', ->
      parser('currency', '$0').should.equal(0)
    it 'should parse thousands', ->
      parser('currency', '$400k').should.equal(400000)
    it 'should parse millions', ->
      parser('currency', '$5M').should.equal(5000000)
    it 'should parse billions', ->
      parser('currency', '$2.34B').should.equal(2340000000)

