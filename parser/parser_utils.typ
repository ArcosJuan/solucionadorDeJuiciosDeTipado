// Getter
#let afirmacion(tree) = {
  if tree.head == "prueba" {
    return tree.args.at(1)

  } else if tree.head == "axioma" {
    return tree.args.at(0)

  }
}

// Devuelve el tipo prettier de un diccionario de tipo
#let limpiar-tipo(t) = {
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

// Devuelve el tipado prettier de un diccionario "tipa"
#let tipado(tipa) = {
  let raw-tipo = tipa.args.at(1)

  if type(raw-tipo) == content {
    return (
      nombre: "t-simple",
      args: (raw-tipo,)
    )

  } else if type(raw-tipo) == dictionary {
    assert.eq(raw-tipo.head,"t-abs")

    return (
      nombre: "t-abs",
      args: limpiar-tipo(raw-tipo),
    )
  }
}

// Getter
#let tipo-afirmacion(tree) = { return tipado(afirmacion(tree)) }

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


// Devuelve si el tipo pasado por parametro no puede ser simplificado.
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
  
  let sub-termino(raw-term) = {
    if type(raw-term) == content {
      return raw-term
    } else if type(raw-term) == dictionary {
      if raw-term.head == "group" {
        return sub-termino(raw-term.slots.body)
      } else if raw-term.head == "iff" {
        return (
          nombre: "if",
          condicion: sub-termino(raw-term.slots.condicion),
          if-true: sub-termino(raw-term.slots.if-true),
          if-false: sub-termino(raw-term.slots.if-false)
        )
      } else if raw-term.head == "app" {
        return (
          nombre: "app",
          abs: sub-termino(raw-term.args.at(0)),
          arg: sub-termino(raw-term.args.at(1)),
        )
      } else if raw-term.head == "abs" {
        return (
          nombre: "abs",
          ligada: {
            if raw-term.slots.ligada.head == "tipa" {
              (
                var: raw-term.slots.ligada.args.at(0),
                tipo: limpiar-tipo(raw-term.slots.ligada.args.at(1))
              )
            } else if raw-term.slots.ligada.head == "con" {
              raw-term.slots.ligada.args.map(
                tipa => (
                  var: tipa.args.at(0),
                  tipo: tipado(tipa),
                ) 
              )
            }
          },
          t-cuerpo: sub-termino(raw-term.slots.t-cuerpo)
        )
      }
    }
  }

  return sub-termino(termino)
}
