all: crunch

test:
	@NODE_PATH=. mocha \
		--require should \
		--compilers coffee:coffee-script

euclidean:
	coffee main -k 3 -f euclidean.json -v euclidean_vector

crunch:
	coffee main -k 3 -f crunch.json -v crunch_vector

.PHONY: test
