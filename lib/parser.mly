%token <string> VAR
%token LAMBDA DOT LPAREN RPAREN SEMICO
%token DEFINE
%token EOF

%start <Program.procedure> procedure
%%

procedure:
  | VAR; DEFINE; t = term; SEMICO { Def($1, t) }
  | t = term; SEMICO { Use t }
  | SEMICO { Noop }
  | EOF { Eof }

term:
  | t = atom { t }
  | atom; nonempty_list(atom) {
    match $2 with
      | h :: t -> List.fold_left (fun acc t -> Terms.App(acc, t)) (App($1, h)) t
      | _ -> failwith "how did we get here?"
    }

atom:
  | VAR { Var $1 }
  | LPAREN; t = term; RPAREN { t }
  | LAMBDA; v = VAR; DOT; t = term { Terms.Abs(v, t) }
