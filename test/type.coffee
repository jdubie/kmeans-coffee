type = require 'type'

describe 'type', ->
  it 'should complete html task', ->
    type('html', '<p>I would like to go fast</p>')
  it 'should complete dash-tags task', ->
    type('dash-tags', ['tag', 'dash-tag']).should.eql ['tag', 'dash-tag', 'dash', 'tag']
  it 'should complete uniary task', ->
    type('uniary', 'foo').should.eql ['foo']
  it 'should complete tags task', ->
    type('tags', ['foo', 'foo', 'bar']).should.eql foo: 2, bar: 1
