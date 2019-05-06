DUNE ?= dune

.PHONY: all test toplevel clean

all:
	$(DUNE) build

runtest:
	$(DUNE) runtest

toplevel:
	$(DUNE) utop

clean:
	$(DUNE) clean
