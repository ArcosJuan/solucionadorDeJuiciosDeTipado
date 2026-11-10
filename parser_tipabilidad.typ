#import "@preview/parsely:0.1.1" as parsely
#import parsely: slot

#let app = $med$
#let iff = "if"
#let then = "then"
#let elsee = "else"


#let grammar = (
  group: (match: $(slot("body*"))$),
  tipa: (infix: $:$, prec: 2),
  con: (infix: $,$, prec: 1, assoc: true),
  iff: (match: $iff slot("condicion") then slot("if-true") elsee slot("if-false")$, prec: 3),
  app: (infix: $app$, prec: 4),
  prueba: (infix: $tack$, prec: 0),
  axioma: (prefix: $tack$, prec: 0),
)


#let eq = $a: theta, b: alpha tack x : a$
#let (tree, rest) = parsely.parse(eq, grammar)



#tree

#parsely.render.waterfall(tree)
