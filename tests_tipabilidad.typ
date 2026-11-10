#import "parser_tipabilidad.typ": *
#import "parser_test_utils.typ": *


// tipado de axioma devuelve axioma y tipa dentro
#let eq = $tack "true" :"bool"$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(tree.head, "axioma")
#assert.eq(tree.args.at(0).head, "tipa")

// --- T-VAR
// var tipa correctamente
#let eq = $tack x : a$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, [a]))

// var con variable x tiene variable x
#let eq = $tack x : a$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(termino(tree).variable)

// --- T-TRUE
// Parser separa contexto individual de true: bool
#let eq = $x:"bool" tack "true" :"bool"$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(variable-tipa-con(tree, [x], [bool]))
#assert(afirmacion-tipa-con(tree, [bool]))

// Parser separa contexto largo de true: bool
#let eq = $x:"bool", y:"bool", z:"bool" tack "true" :"bool"$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(variable-tipa-con(tree, [x], [bool]))
#assert(variable-tipa-con(tree, [y], [bool]))
#assert(variable-tipa-con(tree, [z], [bool]))
#assert(afirmacion-tipa-con(tree, [bool]))



// --- T-IF
// if tipa correctamente
#let eq = $tack iff M then N elsee P :"bool"$
#let (tree, rest) = parsely.parse(eq, grammar)
#afirmacion-tipa-con(tree, [bool])


// tipado de if devuelve 3 partes de if
#let eq = $tack iff M then N elsee P :"bool"$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(repr(termino(tree).condicion), repr([M]))
#assert.eq(repr(termino(tree).if-true), repr([N]))
#assert.eq(repr(termino(tree).if-false), repr([P]))










