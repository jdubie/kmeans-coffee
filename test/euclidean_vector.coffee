EuclideanVector = require 'euclidean_vector'

describe 'EuclideanVector', ->
  describe '#comp', ->
    it 'should work for two small vectors', ->
      v1 = new EuclideanVector([1, 1])
      v2 = new EuclideanVector([0, -1])
      v1.comp(v2).should.eql 5
    it 'should be communitive', ->
      v1 = new EuclideanVector([1, 2])
      v2 = new EuclideanVector([-1, -2])
      v1.comp(v2).should.eql v2.comp(v1)
  describe '@center', ->
    it 'should center two simple points', ->
      v1 = new EuclideanVector([4, -1])
      v2 = new EuclideanVector([2, 3])
      EuclideanVector.center([v1, v2]).arr.should.eql [3,1]
