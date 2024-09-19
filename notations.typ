/********** Symbols **********/

#let thus = [
  #sym.arrow.curve
  #h(5pt)
]

#let limp = $=>$
#let ent = math.class("relation", sym.tack.r)
#let kent = math.class("relation", sym.tack.r.double)
#let csup = math.class("relation", "⫐")

#let eqdef = math.class("relation", sym.eq.delta)
#let simeq = scale(x: 150%, y: 150%, reflow: true, math.class("relation", sym.tilde.eq))
#let eqq = math.class("relation", sym.colon.double.eq)

#let nature = text(font: "DejaVu Sans", size: 26pt, "❀")
#let culture = text(font: "DejaVu Sans", size: 26pt, "✂")

#let hole = sym.square

/********** Operations **********/


#let cfill(ctx, content) = {
  ctx
  h(1pt)
  square(inset: 5pt, content)
}

#let subst(vt, vu, vx) = {
  $vt[vu\/vx]$
}

#let interp(x) = $bracket.l.double #x bracket.r.double$

/********** Notions **********/


// Proof system
#let sys(name) = text(font: "Fira Code", name)

// Inference rule name
#let irule(name) = text(font: "New Computer Modern Sans", name)