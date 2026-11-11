#import "@preview/parsely:0.1.1" as parsely
#import parsely: slot

#let app = $med$
#let var = $thin$
#let iff = "if"
#let then = "then"
#let elsee = "else"


#let grammar = (
  group: (match: $(slot("body*"))$),
  tipa: (infix: $:$, prec: 1),
  t-abs: (infix: $->$, prec: 4),
  abs: (match: $lambda slot("ligada"): slot("t-ligada*?"). slot("t-cuerpo*"):$),
  con: (infix: $,$, prec: 1, assoc: true),
  iff: (match: $iff slot("condicion") then slot("if-true") elsee slot("if-false")$, prec: 3),
  app: (infix: $app$, prec: 4),
  var: (prefix: $var$, prec: 4),
  prueba: (infix: $tack$, prec: 0),
  axioma: (prefix: $tack$, prec: 0),
)


#let eq = $tack lambda x:tau->theta. lambda y: tau. x y : tau->theta$
#let (tree, rest) = parsely.parse(eq, grammar)



#tree

#eq

#parsely.render.waterfall(tree)
