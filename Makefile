DUNE ?= dune
NAME := main

.PHONY: all test toplevel clean

all:
	$(DUNE) build

run:
	$(DUNE) exec src/$(NAME).exe

runtest:
	$(DUNE) runtest

toplevel:
	$(DUNE) utop

clean:
	$(DUNE) clean
