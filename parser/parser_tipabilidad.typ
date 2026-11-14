#import "@preview/parsely:0.1.1" as parsely
#import parsely: slot

#let app = $med$
#let iff = "if"
#let then = "then"
#let elsee = "else"


#let grammar = (
  prueba: (infix: $tack$, prec: 0),
  axioma: (prefix: $tack$, prec: 1),

  tipa: (infix: $:$, prec: 1),
  abs: (match: $(lambda slot("ligada*"). slot("t-cuerpo*"))$),

  con: (infix: $,$, prec: 0, assoc: true),
  t-abs: (infix: $->$, prec: 4, assoc: true),

  iff: (match: $iff slot("condicion") then slot("if-true") elsee slot("if-false")$, prec: 3),
  app: (infix: $app$, prec: 4),

  group: (match: $(slot("body*"))$),
)
