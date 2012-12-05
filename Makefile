all: run

test:
	@NODE_PATH=. mocha \
		--require should \
		--compilers coffee:coffee-script

run:
	@NODE_PATH=. coffee main.coffee

.PHONY: test
