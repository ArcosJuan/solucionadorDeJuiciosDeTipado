#import "parser/parser_tipabilidad.typ": *
#import "parser/parser_utils.typ": *
#import "tests/parser_test_utils.typ": *



#let eq = $tack x: theta$
#let (tree, rest) = parsely.parse(eq, grammar)

#tree

#let tipo = tipo-afirmacion(tree)
#let tipo-simple = simplificar-tipo(tipo)

#pagebreak()

#tipo

#repr(tipo2equation(tipo))

#repr($tau->pi->theta$)

#{tipo2equation(tipo) == $theta$}

#tipo-simple

#eq

#parsely.render.waterfall(tree)
