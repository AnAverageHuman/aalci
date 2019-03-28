DUNE ?= dune

.PHONY: all test toplevel clean

all:
	$(DUNE) build

test:
	$(DUNE) runtest

toplevel:
	$(DUNE) utop

clean:
	$(DUNE) clean
