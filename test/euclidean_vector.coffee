EuclideanVector = require '../euclidean_vector'

describe 'EuclideanVector', ->
  describe '#comp', ->
    it 'should work for two small vectors', ->
      v1 = new EuclideanVector(1, 2)
      v2 = new EuclideanVector(-1, -2)
      v1.comp(v2)
    it 'should be communitive', ->
      v1 = new EuclideanVector(1, 2)
      v2 = new EuclideanVector(-1, -2)
      v1.comp(v2).should.eql v2.comp(v1)
