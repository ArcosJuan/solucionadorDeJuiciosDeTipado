#import "../parser/parser_tipabilidad.typ": *
#import "parser_test_utils.typ": *


// --- Tipos
// ⊢ M : tau tipa correctamente
#let eq = $tack M : alpha$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $alpha$))

// x: tau ⊢ M : tau tipa correctamente
#let eq = $x: tau tack M : alpha$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $alpha$))

// ⊢ M : tau->pi tipa correctamente
#let eq = $tack M : alpha->beta$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $alpha->beta$))

// x: tau ⊢ M : tau->pi tipa correctamente
#let eq = $x: tau tack M : alpha->beta$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $alpha->beta$))

// ⊢ M : alpha->beta->gamma tipa correctamente
#let eq = $tack M : alpha->beta->gamma$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $alpha->beta->gamma$))

// x: tau ⊢ M : alpha->beta->gamma tipa correctamente
#let eq = $x: tau tack M : alpha->beta->gamma$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $alpha->beta->gamma$))

// ⊢ M : (alpha->beta)->gamma tipa correctamente
#let eq = $tack m : (alpha->beta)->gamma$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $(alpha->beta)->gamma$))

// x: tau ⊢ M : (alpha->beta)->gamma tipa correctamente
#let eq = $x: tau tack m : (alpha->beta)->gamma$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $(alpha->beta)->gamma$))

//⊢ M : alpha->(beta->gamma) tipa correctamente
#let eq = $tack m : alpha->(beta->gamma)$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $alpha->(beta->gamma)$))

//x: tau ⊢ M : alpha->(beta->gamma) tipa correctamente
#let eq = $x: tau tack m : alpha->(beta->gamma)$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $alpha->(beta->gamma)$))

//⊢ M : ((alpha->beta)->gamma)->delta tipa correctamente
#let eq = $x: tau tack m : ((alpha->beta)->gamma)->delta$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $((alpha->beta)->gamma)->delta$))

//x: tau ⊢ M : ((alpha->beta)->gamma)->delta tipa correctamente
#let eq = $x: tau tack m : ((alpha->beta)->gamma)->delta$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert(afirmacion-tipa-con(tree, $((alpha->beta)->gamma)->delta$))

//alpha->beta->gamma->delta no simplifica
#let eq = $x: tau tack m : alpha->beta->gamma->delta$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(tipo2equation(simplificar-tipo(tipo-afirmacion(tree))),$alpha->beta->gamma->delta$))

//(alpha->beta->gamma)->delta no simplifica
#let eq = $x: tau tack m : (alpha->beta->gamma)->delta$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(tipo2equation(simplificar-tipo(tipo-afirmacion(tree))),$(alpha->beta->gamma)->delta$))

//alpha->(beta->gamma->delta) si simplifica
#let eq = $x: tau tack m : alpha->(beta->gamma->delta)$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(tipo2equation(simplificar-tipo(tipo-afirmacion(tree))),$alpha->beta->gamma->delta$))

//(alpha->(beta->gamma))->delta si simplifica
#let eq = $x: tau tack m : (alpha->(beta->gamma))->delta$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(tipo2equation(simplificar-tipo(tipo-afirmacion(tree))),$(alpha->beta->gamma)->delta$))

//alpha->(beta->(gamma->delta)) si simplifica
#let eq = $x: tau tack m : alpha->(beta->(gamma->delta))$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(tipo2equation(simplificar-tipo(tipo-afirmacion(tree))),$alpha->beta->gamma->delta$))

//((alpha->beta)->gamma)->delta no simplifica
#let eq = $x: tau tack m : ((alpha->beta)->gamma)->delta$
#let (tree, rest) = parsely.parse(eq, grammar)
#assert.eq(tipo2equation(simplificar-tipo(tipo-afirmacion(tree))),$((alpha->beta)->gamma)->delta$))



