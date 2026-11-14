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
      args: (t-afirmacion,)
    )

  } else if type(t-afirmacion) == dictionary {
    assert.eq(t-afirmacion.head,"t-abs")

    let limpiar-tipo(t) = {
      if type(t) == content {
        return t;
      } else if type(t) == dictionary {
        if t.head == "t-abs" {
          return t.args.map(limpiar-tipo)
        } else if t.head == "group" {
          if t.args.len() == 1 {return t.args.at(0)}
          else {
            return (
              nombre: "group",
              args: t.slots.body.args.map(limpiar-tipo),
            )
          }
        }

      }
    }

    return (
      nombre: "t-abs",
      args: limpiar-tipo(t-afirmacion),
    )
  }
}

#let simplificar-tipo(tipo) = {
  if type(tipo) == content {return tipo}

  if tipo.args.len() == 1 {
    let elem = tipo.args.at(0);
    if type(elem) == content {return tipo}
    if type(elem) == dictionary and elem.nombre == "group" {
      return simplificar-tipo(
        (nombre: tipo.nombre, args: elem.args)
      )
    }
  } else {
    let lts-elem = tipo.args.last();
    if type(lts-elem) == content {
      return (
        nombre: tipo.nombre,
        args: tipo.args.slice(0, tipo.args.len()-1).map(simplificar-tipo) + (lts-elem,)
      )
    }
    if type(lts-elem) == dictionary and lts-elem.nombre == "group" {
      return (
        nombre: tipo.nombre,
        args: tipo.args.slice(0, tipo.args.len()-1).map(simplificar-tipo) + simplificar-tipo(lts-elem).args
      )
    }
  }
}

#let tipo2equation(tipo) = {
  if type(tipo) == content {return $tipo$}
  if tipo.nombre == "t-simple" {
    return tipo2equation(tipo.args.at(0))
  } else if tipo.nombre == "t-abs" {
    return $#tipo.args.map(eq => tipo2equation(eq).body).join(sym.arrow.r)$
  }
  if tipo.nombre == "group" {
    return $(#tipo.args.map(eq => tipo2equation(eq).body).join((sym.arrow.r)))$
  }
}


#let tipo-es-lo-mas-simple(tipo) = {
  return tipo == simplificar-tipo(tipo);
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
