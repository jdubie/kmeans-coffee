test:
	@NODE_PATH=. mocha \
		--require should \
		--compilers coffee:coffee-script

run:
	coffee kmeans.coffee

.PHONY: test
