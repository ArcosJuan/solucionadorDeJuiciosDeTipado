// Getter
#let afirmacion(tree) = {
  if tree.head == "prueba" {
    return tree.args.at(1)

  } else if tree.head == "axioma" {
    return tree.args.at(0)

  }
}

// Getter
#let tipo-afirmacion(tree) = {
  let t-afirmacion = afirmacion(tree).args.at(1)

  if type(t-afirmacion) == content {
    return (
      nombre: "t-simple",
      tipo: t-afirmacion
    )

  } else if type(t-afirmacion) == dictionary {
    assert.eq(t-afirmacion.head,"t-abs")
    return (
      nombre: "t-abs",
      t-arg: t-afirmacion.args.at(0),
      t-ret: t-afirmacion.args.at(1),
    )
  }
}


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
// Devuelve el termino de un juicio de tipado
#let termino(tree) = {
  let termino = afirmacion(tree).args.at(0)

  if type(termino) == content {
    return (
      nombre: "var",
      variable: termino,
    )
  } else if type(termino) == dictionary {
    if termino.head == "iff" {
      return (
        nombre: "if",
        condicion: termino.slots.condicion,
        if-true: termino.slots.if-true,
        if-false: termino.slots.if-false
      )

    } else if termino.head == "app" {
      return (
        nombre: "app",
        abs: termino.args.at(0),
        arg: termino.args.at(1),
      )
    }

  }
}
