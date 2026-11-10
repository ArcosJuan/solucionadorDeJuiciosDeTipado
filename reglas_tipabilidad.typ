#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

#let t-true(contexto) = {
  prooftree(
    rule(
      name: [T-TRUE],
      $#contexto tack "true" : "bool"$,
    )
  )
}
