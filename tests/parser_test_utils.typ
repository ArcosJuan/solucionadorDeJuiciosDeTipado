#import "../parser/parser_utils.typ": *

// Devuelve si una afirmación tipa con un tipo dado.
// -> bool
#let afirmacion-tipa-con(tree, tipo) = {
  return tipo2equation(tipo-afirmacion(tree)) == tipo
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
