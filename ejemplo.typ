#import "parser/parser_tipabilidad.typ": *
#import "parser/parser_utils.typ": *
#import "tests/parser_test_utils.typ": *



#let eq = $tack (lambda x:tau, y:(pi->delta)->gamma. x): theta$
#let (tree, rest) = parsely.parse(eq, grammar)

#eq

#tree

#pagebreak()

#termino(tree)

