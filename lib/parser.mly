%token <string> VAR
%token LAMBDA DOT LPAREN RPAREN SEMICO
%token DEFINE
%token EOF

%start <Procedure.procedure> procedure
%%

procedure:
  | VAR; DEFINE; t = term; SEMICO { Def($1, t) }
  | t = term; SEMICO { Use t }
  | EOF | SEMICO { Noop }

term:
  | var = atom { var }
  | abs = abs { abs }
  | app = app { app }

atom:
  | VAR { Var $1 }
  | LPAREN; t = term; RPAREN { t }

app:
  | s = term; t = term { App(s, t) }

abs:
  | LAMBDA; x = VAR; DOT; s = term { Abs(x, s) }
