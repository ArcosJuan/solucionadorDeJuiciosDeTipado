#import "../parser/parser_utils.typ": *


#let validar_juicio(juicio) = {
  let termino = termino(juicio)
  let tipo = tipo-afirmacion(juicio)

  if type(termino) == content {
    if termino == [true] or termino == [false] {
      if tipo.nombre == "t-simple" and tipo.args.at(0) == [bool] {
        return (
          resultado: "valido"
        )
      } else {
        return (
          resultado: "invalido",
          motivo: "True y False deben tipar como Bool"
        )
      }
    } else {
      
    }
  } 
}
