// Getter
#let afirmacion(tree) = {
  if tree.head == "prueba" {
    return tree.args.at(1)
  } else if tree.head == "axioma" {
    return tree.args.at(0)
  }
} 

// Getter
#let tipo-afirmacion(tree) = afirmacion(tree).args.at(1)


// Getter
// Devuelve una lista de tuplas (x, t) tal que x es una variable y t un tipo.
#let contexto-de-tipado(tree) = {
  assert.eq(tree.head, "prueba", message: "No hay contexto en axioma.")

  let contexto = tree.args.at(0)

  if contexto.head == "tipa" {
    return (contexto.args,)

  } else if contexto.head == "con" {
    return contexto.args.map(tipado => tipado.args)

  }
}

// Getter
// Devuelve el termino de un juicio
#let termino(tree) = {
  let termino = afirmacion(tree).args.at(0)

  if termino.head == "iff" {
    return (
      nombre: "if",
      condicion: termino.slots.condicion,
      if-true: termino.slots.if-true,
      if-false: termino.slots.if-false
    )
  }
  
}







