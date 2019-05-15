# aalci

An OCaml library for lexing, parsing, interpreting, and executing lambda
expressions and "programs" written using lambda expressions.

For an in-depth explanation of "program" syntax, see the [process paper][paper].

## Dependencies

- [dune][dune] is required to build the project.
- [Menhir][menhir] is required to build the parser.

## Usage

```
dune exec src/main.exe [file]
```

If no file is provided, input will be read from `stdin`.

An example input file [example.lmda][examplein] is provided with the source.

## Tests

A small set of regression tests can be found in [test/](test).

[ppx_inline_test][inlinetest] is required to compile the tests.

Compile and run the tests using dune:

```sh
$ make runtest
dune runtest
    ocamlopt test/.aalci_test.inline-tests/run.exe
```

## Toplevel integration

To play around with the library, build and run the interactive toplevel:

```sh
$ make toplevel
dune utop
[...]

ocaml # open Aalci.Terms;;
[...]
```

[dune]: https://dune.build/
[menhir]: http://gallium.inria.fr//~fpottier/menhir/
[inlinetest]: https://github.com/janestreet/ppx_inline_test
[examplein]: example.lmda
[paper]: paper/report.pdf
