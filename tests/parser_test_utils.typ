#import "../parser/parser_utils.typ": *
#import "../parser/parser_tipabilidad.typ": *

// Devuelve si una afirmación tipa con un tipo dado.
// -> bool
#let afirmacion-tipa-con(tree, tipo) = {
  if tipo.func() == math.equation { tipo = tipo.body }

  let tipos-coinciden = false
  let t-afirmacion = tipo-afirmacion(tree)

  if t-afirmacion.nombre == "t-simple" {
    tipos-coinciden = repr(t-afirmacion.tipo) ==  repr(tipo)

  } else if tipo-afirmacion(tree).nombre == "t-abs" {
    let (tree, rest) = parsely.parse(tipo, grammar)
    tipos-coinciden = repr(tree.args.at(0)) == repr(t-afirmacion.t-arg)
    tipos-coinciden = tipos-coinciden and repr(tree.args.at(1)) ==  repr(t-afirmacion.t-ret)
  }

  return tipos-coinciden
}


// Devuelve si una variable tipa con un tipo dado.
// -> bool
#let variable-tipa-con(tree, var, tipo) = {
  assert.eq(tree.head, "prueba")

  let contexto = contexto-de-tipado(tree)

  let tipado-encontrado = contexto.find(
    tipado => repr(tipado.at(0)) == repr(var) and repr(tipado.at(1)) == repr(tipo)
  )

  if tipado-encontrado == none {
    return false
  } else {
    return repr(tipado-encontrado.at(1)) == repr(tipo)
  }

}
