#import "@preview/polylux:0.3.1": *
#import "@preview/xarrow:0.3.0": xarrow

#import "theme/metropolis.typ": *
#import "./svg-emoji/lib.typ": setup-emoji

#import "flower.typ"
#import "eg.typ": *
#import "notations.typ": *
#import "utils.typ": *


/********** PREAMBLE **********/


#show: metropolis-theme.with()

// Font config
#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math", weight: "light")
#set strong(delta: 100)
#show link: underline.with(offset: 3pt)
#show: setup-emoji

// Layout config
#set par(justify: true)
#set list(spacing: 1.5em)

// Useful shortcuts
#let mt = spar($|->$)
#let to = spar($->$)
#let xrule(content) = spar(spacing: 1em, xarrow(sym: sym.arrow.r, irule(content)))

// Theorem and definition environements
#import "@preview/ctheorems:1.1.2": *
#show: thmrules

#let definition = thmbox(
  "definition", "Definition",
  fill: blue.lighten(90%),
).with(numbering: none)

#let theorem = thmbox(
  "theorem", "Theorem",
  fill: red.lighten(90%),
).with(numbering: none)

#let corollary = thmbox(
  "corollary", "Corollary",
  fill: green.lighten(90%),
).with(numbering: none)

#let proof = thmproof("proof", "Proof")


/********** CONTENT **********/


// #title-slide(
//   author: [Pablo Donato],
//   title: "The Flower Calculus",
//   date: datetime.today().display(),
//   extra: [
//     SYCO 12, Birmingham
//     #set text(size: 18pt)
//     #v(1em)
//     Based on #link("https://arxiv.org/abs/2402.15174")[arXiv:2402.15174]
//   ]
// )

#slide()[]

#slide(title: [A change of viewpoint])[
  // - Goal: intuitive *GUI* for _interactive theorem provers_
  //   // - Replace textual *proof* language (e.g. tactics)
  //   // - Replace textual *statement* language (symbolic formulas)
  // #pause
  // - Methodology:
  // $ underbrace("Direct manipulation", #text(size: 24pt)[Proofs])
  //   "of"
  //   underbrace(#text[
  //     #only("1-4")[Diagrams]
  //     #only("5-")[Flowers #emoji.flower.hibiscus]
  //   ], #text(size: 24pt)[Statements]) $
    
  // #pause

  // - Focus on common heart of _all_ proof assistants:
  // #align(center)[
  //   #text(fill: purple)[Intuitionistic] #text(fill: eastern)[First-order] Logic
  // ]
  
  - #text(fill: red)[$or$] solved, but #text(fill: blue)[$#limp$] still *non-invertible*!


  #v(2em)
  #pause
  #align(center)[
    #set text(size: 26pt)
    Key idea: #alert[*space*] is _polarized_, not *objects*
  ]
  #v(2em)

  #pause
  
  - (Peirce, 1896): *existential graphs (EGs)* for _classical_ logic
  
  #pause
  
  - @oostra_graficos_2010@minghui_graphical_2019: EGs for _intuitionistic_ logic

  #pause
  
  #thus *Flower calculus*: intuitionistic variant that is #alert[analytic]

  // #uncover("6")[
  //   #v(1em)
  //   #align(center)[
  //     #text(fill: red)[*Disclaimer:* no _category theory_ in this talk!]
  //   ]
  // ]
]

// #slide(title: [Outline of this talk])[
//   #metropolis-outline
// ]


#new-section-slide([*Classical Logic*: Existential Graphs])

#slide(title: [Existential Graphs #title-right[(Peirce, 1896)]])[
  Three #alert[diagrammatic] proof systems for *classical* logic:

  #v(1em)

  #alternatives[
    - *#sys[Alpha]:* _propositional_ logic
  ][
    #halert[
    - *#sys[Alpha]:* _propositional_ logic
    ]
  ]
  
  - *#sys[Beta]:* _first-order_ logic
  
  - *#sys[Gamma]:* _higher-order_ and _modal_ logics
]

#slide(title: [The three icons of #sys[Alpha]])[
  - *Sheet of assertion* #pause
  $
    #uncover("2-")[$a$] #pause
    #uncover("3-")[$&#mt #text[$a$ is true]$] \ #pause
    #uncover("4-")[$&#mt top #text(size: 14pt)[(no assertion)]$] \ #pause
  $

  - *Juxtaposition*
  $
    #uncover("5-")[$G #juxt H$] #pause
    #uncover("6-")[$&#mt #text[$G #alert[and] H$ are true]$] #pause
  $
  
  - *Cut*
  $
    #uncover("7-")[$#cut(inv: true, $G$)$] #pause
    #uncover("8-")[$&#mt #text[$G$ is #alert[not] true]$]
  $
]

#slide(title: [Relationship with formulas])[
  #set align(center)
  
  // #side-by-side(gutter: 2em)[
    #grid(
      columns: (1fr, 1fr, 1fr),
      inset: 20pt,
      align: center,
      cut(inv: true, inset: 4mm, $$),
      grid.vline(),
      cut(inv: true, $#cut($A$) #cut($B$)$),
      grid.vline(),
      cut(inv: true, $A #h(5mm) #cut($B$)$),
      grid.hline(),
      $bot$,
      $A or B$,
      $A #limp B$,
    )
  // ][
    // #pause

    // - Juxtaposition is naturally:

    //   - *variadic*
    //   - *associative*
    //   - *commutative*

    // #thus normal form for ${top, and, not}$-formulas
  // ]
]

#slide(title: [Illative transformations])[
  #set align(center)
  #set text(19pt)
  #let to = spar(spacing: 1.25em, $->$)
  #let frto = spar(spacing: 1.25em, $<->$)
  
  #v(-0.5em)
  Only 4 #alert[edition] principles! #pause
  
  #grid(
    columns: (auto, auto, auto, auto),
    inset: 15pt,
    align: center,
    uncover("2-")[*Iteration* (copy-paste)],
    grid.vline(),
    uncover("3-")[*Deiteration* (unpaste)],
    grid.vline(),
    uncover("4-")[*Insertion*],
    grid.vline(),
    uncover("5-")[*Deletion*],
    grid.hline(),
    uncover("2-")[
      $ G #juxt #cfill($H$, phantom($G$)) #to G #juxt #cfill($H$, $G$) \
        #sheet(inv: true)[$
        G #juxt #cfill($H$, phantom($G$)) #to G #juxt #cfill($H$, $G$)
        $]
      $
    ],
    uncover("3-")[
      $ G #juxt #cfill($H$, $G$) #to G #juxt #cfill($H$, phantom($G$)) \
        #sheet(inv: true)[$
        G #juxt #cfill($H$, $G$) #to G #juxt #cfill($H$, phantom($G$))
        $]
      $
    ],
    uncover("4-")[
      $ #sheet(inv: true)[$#to G$] $
    ],
    grid.vline(),
    uncover("5-")[
      $ G #to $
    ],
  )

  #uncover("6-")[
    and a #alert[space] principle, the *Double-cut* law:
    $ #cut(inv: true, cut($G$)) #frto G #h(4em)
      #sheet(inv: true)[$
      #cut(cut(inv: true, $G$)) #frto G
      $]
    $
  ]
]

#slide(title: [Example: _modus ponens_])[
  $
    #uncover("1-")[$a #juxt #cut(inv: true, $a #juxt #cut($b$)$)$]
    #uncover("2-")[$#xrule[Deit] a #juxt #cut(inv: true, $#phantom[a #juxt] #cut($b$)$)$]
    #uncover("3-")[$#xrule[Dcut] a #juxt b$]
    #uncover("4-")[$#xrule[Del] b$]
  $
]


#new-section-slide([*Intuitionistic Logic*: Flowers])

#slide(title: [The scroll])[
  #set text(size: 18pt)
  
  #side-by-side(gutter: 2em, columns: (1fr, 2fr))[
    #set align(center)
    #image("images/scroll.png", width: 80%)
    #uncover("2-")[
      $ A and B #limp C and D $
    ]
    #only("3-")[
      #nscroll(
        fontsize: 20pt,
        outloop: (content: align(top)[$A #juxt B$], size: 2.2cm),
        inloops: ((:), (content: $C #juxt D$, size: 1.2cm))
      ).content
    ]
  ][
    #quote(block: true, attribution: [@peirce_prolegomena_1906[pp.~533-534]])[
      #set text(size: 16pt)
      I thought I ought to take the general form of
      argument as the basal form of composition of signs in my
      diagrammatization; and this necessarily took the form of a
      “scroll”, that is [...] a curved line without contrary flexure
      and returning into itself after once crossing itself.
    ]
    
    #only("2-")[
      #pause
      #v(1em)
      - "conditional de inesse" = *classical* implication
    ]
    #only("3-")[
      #thus scroll $=$ two _nested cuts_
    ]
    
    // #only("4-")[
    //   #v(1em)
    //   - Icons of #sys[Alpha] #alert[deduced] from the scroll
    // ]
    
    #only("4-")[
      #pause
      #v(1em)
      - Peirce also introduced #limp in logic!
        ~#text(size: 14pt)[@Lewis1920-LEWASO-4[p.~79]]
    ]
  ]
]

#slide(title: [The $n$-ary scroll #title-right[@oostra_graficos_2010]])[
  #set align(center)

  #uncover("4-")[
    #alert[Continuity!]
  ]
  #only("5-")[
    _Generalizes_ Peirce's *scroll* #only("6-")[and *cut*]
  ]

  #only("4", place(dx: 7.2cm, dy: 2.5cm, text(size: 50pt, sym.eq.not)))
  #only("5", place(dx: 18.7cm, dy: 2.5cm, text(size: 50pt, sym.eq.not)))

  #grid(
    columns: (1fr, 2fr, 1fr),
    inset: 10pt,
    align: center,
    uncover("2-")[
      #only("2-3")[Classical]
      
      #only("4-")[Intuitionistic]
      
      #cut(inv: true, inset: -5pt, $#cut($b$) #h(5mm) #cut($c$)$)
    ],
    [
      #only("1-3")[
        #nscroll(outloop: (content: $a$, size: 3cm), inloops: (
          (content: $b$), (content: $c$), (content: $d$), (content: $e$), (content: $f$), 
        )).content
      ]
      
      #only("4", nscroll(outloop: (size: 3cm), inloops: (
        (:), (content: $c$), (:), (content: $b$)
      )).content)
  
      #only("5", nscroll(outloop: (content: $a$, size: 3cm), inloops: (
        (:), (content: $b$), (:), (:)
      )).content)
      
      #only("6", nscroll(outloop: (content: $a$, size: 3cm), inloops: (
      )).content)
    ],
    uncover("2-")[
      #only("2-4")[Classical]
      
      #only("5-")[Intuitionistic]
      
      #box(cut(inv: true, $a #h(5mm) #cut($b$)$))
    ],
    [
      #only("2-3")[$b or c$]
      #only("4-")[$not (not b and not c)$]
    ],
    [
      #only("3")[$a #limp b or c or d or e or f$]
      #only("4", $ b or c $)
      #only("5", $ a #limp b $)
      #only("6", $ not a #eqdef a #limp bot $)
    ],
    [
      #only("2-4")[$a #limp b$]
      #only("5-")[$not (a and not b)$]
    ]
  )

  #only("1-3")[$ n = 5 $]
  #only("4")[$ n = 2 $]
  #only("5")[$ n = 1 $]
  #only("6")[$ n = 0 $]
]

#slide(title: [Blooming #title-right[(Me, 2022)]])[
  #set align(center)
  #let emoji_size = 35pt

  #v(-0.6em)

  #side-by-side(gutter: 0cm, columns: (auto, auto))[
    #grid(
      columns: (1fr, 1.25fr),
      only("2-", image("images/cylinder.jpg", fit: "cover", width: 100%)),
      grid(
        columns: (auto),
        inset: 0.3em,
        only("2-", text(size: emoji_size, emoji.pistol)),
        v(0.1em),
        nscroll(outloop: (content: $a$, size: 2.75cm), inloops: (
          (content: $b$), (content: $c$), (content: $d$), (content: $e$), (content: $f$), 
        )).content,
        only("2-", text(size: emoji_size, font: "Noto Color Emoji", "☹️")),
      )
    )
  ][
    #grid(
      columns: (1.25fr, 1fr),
      only("3-", grid(
        columns: (auto),
        inset: 0.3em,
        only("4-", text(size: emoji_size, emoji.flower)),
        v(0.1em),
        flower.one((
          pistil: (content: $a$),
          petal_size: 3cm,
          petals: ((name: "p1", content: $b$), (name: "p2", content: $c$), (name: "p3", content: $d$), (name: "p4", content: $e$), (name: "p5", content: $f$))
        )).content,
        only("4-", text(size: emoji_size, font: "Noto Color Emoji", emoji.face.happy)),
      )),
      only("4-", image("images/flower.jpg", fit: "cover", width: 100%)),
    )
  ]

  #only("3")[
    Turn *inloops* into #alert[petals].
  ]
  #only("4")[
    #link("https://en.wikipedia.org/wiki/Make_love,_not_war")[_"Make love, not war"_]
  ]
]

#slide(title: [Corollaries])[
  #quote(block: true, attribution: [Peirce, MS 514 (1909)~~~#text(size: 14pt)[@peirce_corolla]])[
    The original "theorems" of geometry were those propositions that Euclid proved, while the *corollaries* were simple deductions from the theorems inserted by Euclid’s commentators and editors. They are said to have been marked the figure of a little garland (or #alert[corolla]), in the origin.
  ]
  
  #set align(center)
  #pause
  #v(1em)
  Petals = (possible) *corolla*-ries of pistil!
]


// #new-section-slide([*Predicate Logic*: Gardens])

#let binder_color = fuchsia

// #slide(title: [Lines of Identity])[
//   #set align(center)
//   #set text(size: 19pt)

//   #only("1-3")[
//     In #sys[Beta], *quantifiers* and *variables* are represented with #alert[lines].~~~#text(size: 18pt)[(cf. Alessandro's talk)]
//   ]
//   #only("4-")[
//     #v(-0.65em)
//     #text(fill: red)[*Problem*]: no *De Morgan duality* in #alert[intuitionistic] logic
//   ]
    
//   #let dot = circle(radius: 5pt, fill: binder_color)
//   #let R(len: 10mm) = $R #only("2-", move(dx: 6pt, dot)) #line(length: len, stroke: 2pt + white) #h(0pt)$
//   #let S = $#h(-2.5mm) #line(length: 10mm, stroke: 2pt + black) S$
  
//   #grid(
//     columns: (40%, 40%),
//     column-gutter: 1em,
//     inset: 1em,
//     $P #only("2-", move(dx: 6pt, dot)) #line(length: 2cm, stroke: 2pt + black) Q$,
//     [
//       #only("1-3")[
//         $#cut(inv: true, inset: -7pt, $#R() #cut(inset: 0pt, S)$)$
//       ]
//       #only("4")[
//         #nscroll(
//           fontsize: 19pt,
//           outloop: (content: $#R(len: 25mm)$, size: 2.35cm),
//           inloops: ((:), (content: $#S$, size: 0.9cm), (:), (:))
//         ).content
//       ]
//     ],
//     [
//       #uncover("3-")[
//         #v(-6mm)
//         $ exists x. P(x) and Q(x) $
//         #set text(size: 18pt)
//         #alert[existential] graphs!
//       ]
//     ],
//     [
//       #let big(op) = spar(spacing: 13pt, text(size: 28pt, op))
//       #only("3", $&forall x. R(x) #limp S(x) \ big(tilde.equiv) &not exists x. R(x) and not S(x)$)
//       #only("4-", text(fill: red, $&forall x. R(x) #limp S(x) \ big(tilde.equiv.not) &not exists x. R(x) and not S(x)$))
//     ],
//   )
  
//   #only(2)[quantifier location $=$ #text(fill: binder_color)[*outermost* point]]
//   #only("3-")[quantifier type $=$ #text(fill: binder_color)[outermost point *polarity*]]
// ]

// #slide(title: [Intuitionistic quantification])[
//   #set align(center)
//   #set text(size: 19pt)

//   #v(-1.4em)
//   #text(fill: olive)[*Solution*]: #alert[polarity-invariant] interpretation
  
//   #let dot = circle(radius: 5pt, fill: binder_color)
//   #let R(len: 10mm, color: white) = $R #move(dx: 5pt, dot) #line(length: len, stroke: 2pt + color) #h(-1mm)$
//   #let S(color: black) = $#h(-2.5mm) #line(length: 10mm, stroke: 2pt + color) S$

//   #let outloop_size = 2cm
  
//   #grid(
//     columns: (40%, 40%),
//     column-gutter: 1em,
//     inset: 1em,
//     [
//       #only("1", nscroll(
//         fontsize: 19pt,
//         outloop: (size: outloop_size),
//         inloops: ((:), (content: $P #move(dx: 5pt, dot) #line(length: 60% * outloop_size, stroke: 2pt + black) Q$, size: 90% * outloop_size), (:), (:))
//       ).content)
//       #only("2", cut(inv: true, inset: -3pt, nscroll(inv: false,
//         fontsize: 19pt,
//         outloop: (size: outloop_size),
//         inloops: ((:), (content: $P #move(dx: 5pt, dot) #line(length: 60% * outloop_size, stroke: 2pt + white) Q$, size: 90% * outloop_size), (:), (:))
//       ).content))
//       #only("3")[
//         #v(-2em)
//         #move(dx: -2.2cm, flower.one((
//           pistil: (size: 0.5cm),
//           angle: 1rad / 3,
//           petal_size: 5cm,
//           petals: ((:), (name: "p", content: $P #move(dx: 5pt, dot) #line(length: 60% * outloop_size, stroke: 2pt + black) Q$), (:), (:), (:))
//         )).content)
//         #v(-2em)
//       ]
//       #only("4")[
//         #flower.one((
//           pistil: (size: 3.15cm, content:
//             move(dx: -2.2cm, flower.one((
//               pistil: (color: white, size: 0.5cm),
//               angle: 1rad / 3,
//               petal_size: 5cm,
//               petals: ((:), (name: "p", content: $P #move(dx: 5pt, dot) #line(length: 60% * outloop_size, stroke: 2pt + black) Q$), (:), (:), (:))
//             )).content)
//           )
//         )).content
//       ]
//     ],
//     [
//       #only("1", nscroll(
//         fontsize: 19pt,
//         outloop: (content: $#R(len: 25mm)$, size: outloop_size),
//         inloops: ((:), (content: $#S()$, size: 0.9cm), (:), (:))
//       ).content)
//       #only("2", cut(inv: true, inset: -3pt, nscroll(inv: false,
//         fontsize: 19pt,
//         outloop: (content: $#R(len: 25mm, color: black)$, size: outloop_size),
//         inloops: ((:), (content: $#S(color: white)$, size: 0.9cm), (:), (:))
//       ).content))
//       #only("3")[
//         #v(-2em)
//         #move(dx: -1.35cm, flower.one((
//           pistil: (size: 1.25cm, content: $R #move(dx: 5pt, dot)  #line(length: 1cm) #h(-9mm)$),
//           angle: 1rad / 3,
//           petal_size: 4cm,
//           petals: ((:), (name: "p", content: $#h(-18mm) #move(dy: -0.5mm, line(length: 1.6cm)) S$), (:), (:), (:))
//         )).content)
//         #v(-2em)
//       ]
//       #only("4")[
//         #v(-2em)
//         #flower.one((
//           pistil: (size: 3.15cm, content:
//             move(dx: -1.35cm, flower.one((
//               pistil: (color: white, size: 1.25cm, content: $R #move(dx: 5pt, dot)  #line(length: 1cm) #h(-9mm)$),
//               angle: 1rad / 3,
//               petal_size: 4cm,
//               petals: ((:), (name: "p", content: $#h(-18mm) #move(dy: -0.5mm, line(length: 1.6cm)) S$), (:), (:), (:))
//             )).content)
//           )
//         )).content
//         #v(-2em)
//       ]
//     ],
//     [
//       #only("1,3", $exists x. P(x) and Q(x)$)
//       #only("2,4", $not (exists x. P(x) and Q(x))$)
//     ],
//     [
//       #only("1,3", $forall x. R(x) #limp S(x)$)
//       #only("2,4", $not (forall x. R(x) #limp S(x))$)
//     ],
//   )

//   $forall$/$exists$ $=$
//   #text(fill: binder_color)[*
//     #only("1-2")[outloop/inloop]
//     #only("3-4")[pistil/petal]
//   *]
// ]

// #slide(title: [Spaghetti statements])[
//   #align(center)[
//     #text(fill: red)[*Problem:*] cables _all over the place_
//   ]
//   #image("images/quine_loi.png")
//   #quote(block: true, attribution: [@quine_loi[p.~70]])[
//     [These diagrams are] too cumbersome to recommend themselves as a practical notation.
//   ]
// ]

#let binder(x) = text(fill: binder_color, x)
#let var(x) = text(fill: purple, x)

// #slide(title: [Gardens])[
//   #set align(center)
  
//   #text(fill: olive)[*Solution:*] replace lines with #binder[binders] and #var[variables]
  

//   #grid(
//     columns: (40%, 40%),
//     column-gutter: 1em,
//     inset: 1em,
//     [
//       #v(-2em)
//       #move(dx: -2.2cm, flower.one((
//         pistil: (size: 0.5cm),
//         angle: 1rad / 3,
//         petal_size: 5cm,
//         petals: ((:), (name: "p", content: $#move(dx: 1.6cm, binder[$x$]) \ #move(dx: 0.1cm)[$P(#var($x$)) #juxt Q(#var[$x$])$]$), (:), (:), (:))
//       )).content)
//       #v(-2em)
//     ],
//     [
//       #v(-2em)
//       #move(dx: -1.35cm, flower.one((
//         pistil: (size: 1.45cm, content: $#move(dx: 4.5mm, binder[$x$]) \ R(#var[$x$])$),
//         angle: 1rad / 3,
//         petal_size: 4cm,
//         petals: ((:), (name: "p", content: $S(#var[$x$])$), (:), (:), (:))
//       )).content)
//       #v(-2em)
//     ],
//     $exists x. P(x) and Q(x)$,
//     $forall x. R(x) #limp S(x)$,
//   )

//   #alert[garden] $=$ content of an area (binders + flowers)
// ]

#slide(title: [Gardens])[
  #set align(center)
  
  $exists$/$forall$ $=$ #binder[binder] in petal/pistil

  #let var(x) = x

  #grid(
    columns: (40%, 40%),
    column-gutter: 1em,
    inset: 1em,
    [
      #v(-2em)
      #move(dx: -2.2cm, flower.one((
        pistil: (size: 0.5cm),
        angle: 1rad / 3,
        petal_size: 5cm,
        petals: ((:), (name: "p", content: $#move(dx: 1.6cm, binder[$x$]) \ #move(dx: 0.1cm)[$P(#var($x$)) #juxt Q(#var[$x$])$]$), (:), (:), (:))
      )).content)
      #v(-2em)
    ],
    [
      #v(-2em)
      #move(dx: -1.35cm, flower.one((
        pistil: (size: 1.45cm, content: $#move(dx: 4.5mm, binder[$x$]) \ R(#var[$x$])$),
        angle: 1rad / 3,
        petal_size: 4cm,
        petals: ((:), (name: "p", content: $S(#var[$x$])$), (:), (:), (:))
      )).content)
      #v(-2em)
    ],
    $exists x. P(x) and Q(x)$,
    $forall x. R(x) #limp S(x)$,
  )

  #alert[garden] $=$ content of an area (binders + flowers)
]



#new-section-slide([*Reasoning* with Flowers])

#slide(title: [Iteration and Deiteration])[
  #set align(center)

  #let (source_color, sink_color) = (blue, red)  
  #let source = circle(radius: 3pt, fill: source_color, stroke: none)
  #let sink = circle(radius: 3pt, fill: sink_color, stroke: none)

  Justify a #text(fill: sink_color)[target] flower by a #text(fill: source_color)[source] flower

  #grid(
    columns: (auto, auto),
    gutter: 1.5em,
    align: bottom,
    image("images/cross-pollination.png", height: 70%),
    image("images/self-pollination.png", height: 48%),
    [cross-pollination],
    [self-pollination],
  )
]

#let rebase = box.with(baseline: 50%)

#slide(title: [Iteration and Deiteration])[
  #set align(center)

  Works at *arbitrary* #alert[depth]!
  
  #let f1 = flower.one((
    pistil: (content: only(1, $a$)),
    petals: ((:), (:), (name: "p1", content: only(4, $b$)), (:))
  )).content
  #let f = rebase(flower.one((
    pistil: (content: $b$, size: 1.5cm),
    petal_size: 8cm,
    petals: ((:), (name: "p", content: move(dy: -1cm, f1)), (:), (:))
  )).content)
  
  #v(-2em)
  $ a #juxt #f $
  #v(-2em)

  #only("1-2")[Cross-pollination]
  #only("3-4")[Self-pollination]
]

#slide(title: [Insertion and Deletion])[
  #set align(center)

  #v(-0.5em)
  Split in two: 

  #let make_flower(n, color: flower.pistil_color) = {
    rebase(flower.empty(n, pistil: (size: 0.4cm, color: color), petal_size: 1.2cm).content)
  }

  #let make_with_petals(color: flower.pistil_color, petals) = {
    let pets = ()
    let letters = ($a$, $b$, $c$, $d$, $e$, $f$, $g$, $h$)
    for i in range(petals.len()) {
      let petal = petals.at(i)
      if petal == 1 {
        pets.push((name: "foo", content: letters.at(i+1)))
      } else {
        pets.push((:))
      }
    }
    rebase(flower.one(text_size: 12pt, (
      pistil: (size: 0.4cm, color: color, content: letters.at(0)),
      petal_size: 1.2cm,
      petals: pets
    )).content)
  }
  
  #let grow_left = none
  #let grow_right = make_with_petals((1, 1, 1, 1, 1))
  
  #let crop_left = flower.sheet(make_with_petals((1, 1, 1, 1, 1), color: white))
  #let crop_right = flower.sheet(square(size: 2.2cm, stroke: none))
  
  #let pull_left = make_with_petals((1, 1, 1, 1, 1))
  #let pull_right = make_with_petals((0, 1, 1, 1, 1))
  
  #let glue_left = flower.sheet(make_with_petals((0, 1, 1, 1, 1), color: white))
  #let glue_right = flower.sheet(make_with_petals((1, 1, 1, 1, 1), color: white))

  // #v(1em)
  #grid(
    columns: (1fr, 1fr),
    inset: 1em,
    align: center + horizon,
    
    [*Flower*],
    grid.vline(),
    [*Petal*],
    grid.hline(),
    
    $#grow_left &#xrule[grow] #grow_right \
     #crop_left &#xrule[crop] #crop_right
    $,
    $#glue_left &#xrule[glue] #glue_right \
     #pull_left &#xrule[pull] #pull_right
    $
  )

  #alert[Backward] reading:~~~~ $"conclusion" #xrule[#h(1cm)] "premiss"$
]

#slide(title: [Scrolling])[
  #set align(center)
  Intuitionistic restriction of *double-cut* principle:

  $ 
    a
    #xrule[epis]
    #move(dx: -1.2em, rebase(flower.one((
      pistil: (size: 0.75cm),
      petals: ((:), (name: "p", content: $a$), (:), (:))
    )).content))
  $
]

#let make_flower = flower.one.with(text_size: 16pt)

#slide(title: [Instantiation])[
  #let ipis_left = rebase(make_flower((
    pistil: (size: 0.9cm, color: white, content: $x #h(6pt) a(x)$),
    petals: ((name: "p1", content: $b(x)$), (name: "p2", content: $c(x)$), (name: "p3", content: $d(x)$), (name: "p4", content: $e(x)$), (name: "p5", content: $f(x)$))
  )).content)
  
  #let ipis_right = rebase(make_flower((
    pistil: (size: 0.9cm, color: white, content: $a(t)$),
    petals: ((name: "p1", content: $b(t)$), (name: "p2", content: $c(t)$), (name: "p3", content: $d(t)$), (name: "p4", content: $e(t)$), (name: "p5", content: $f(t)$))
  )).content)
  
  #let ipet_left = rebase(make_flower((
    pistil: (size: 0.9cm, content: $a$),
    petal_size: 3cm,
    petals: ((name: "p1", content: $x #h(6pt) b(x)$), (name: "p2", content: $c$), (name: "p3", content: $d$), (name: "p4", content: $e$), (name: "p5", content: $f$))
  )).content)
  
  #let ipet_right = rebase(make_flower((
    pistil: (size: 0.9cm, content: $a$),
    petal_size: 3cm,
    angle: -1/6 * calc.pi * 1rad,
    petals: ((name: "p1", content: $b(t)$), (name: "p2", content: $x #h(6pt) b(x)$), (name: "p3", content: $c$), (name: "p4", content: $d$), (name: "p5", content: $e$), (name: "p6", content: $f$))
  )).content)

  $ #flower.sheet(ipis_left) &#xrule[ipis] #flower.sheet[
      #v(0.5em)
      $#ipis_right #juxt #ipis_left$
    ] \
    #ipet_left &#xrule[ipet] #ipet_right $
]

#slide(title: [Abstraction])[
  #let make_flower = flower.one.with(text_size: 16pt)
  
  #let ipis_left = rebase(make_flower((
    pistil: (size: 0.9cm, content: $x #h(6pt) a(x)$),
    petals: ((name: "p1", content: $b(x)$), (name: "p2", content: $c(x)$), (name: "p3", content: $d(x)$), (name: "p4", content: $e(x)$), (name: "p5", content: $f(x)$))
  )).content)
  
  #let ipis_right = rebase(make_flower((
    pistil: (size: 0.9cm, content: $a(t)$),
    petals: ((name: "p1", content: $b(t)$), (name: "p2", content: $c(t)$), (name: "p3", content: $d(t)$), (name: "p4", content: $e(t)$), (name: "p5", content: $f(t)$))
  )).content)
  
  #let ipet_left = rebase(make_flower((
    pistil: (size: 0.9cm, content: $a$, color: white),
    petal_size: 3cm,
    petals: ((name: "p1", content: $x #h(6pt) b(x)$), (name: "p2", content: $c$), (name: "p3", content: $d$), (name: "p4", content: $e$), (name: "p5", content: $f$))
  )).content)
  
  #let ipet_right = rebase(make_flower((
    pistil: (size: 0.9cm, content: $a$, color: white),
    petal_size: 3cm,
    petals: ((name: "p1", content: $b(t)$), (name: "p3", content: $c$), (name: "p4", content: $d$), (name: "p5", content: $e$), (name: "p6", content: $f$))
  )).content)

  #set align(center)
  $#ipis_right &#xrule[apis] #ipis_left$
  #v(5pt)
  $#flower.sheet[
      #v(0.5em)
      $#ipet_right &#xrule[apet] #ipet_left$
    ]$
]


#slide(title: [Case reasoning])[
  #set align(center)

  #let rflower(pistil_color) = scale(y: -100%, flower.one((
    pistil: (color: pistil_color, size: 0.45cm),
    angle: 1/5 * calc.pi * 1rad,
    petals: (
      (name: "1", color: aqua),
      (name: "1", color: aqua),
      (name: "1", color: aqua),
      (name: "1", color: aqua),
      (name: "1", color: aqua),
    ))
  ).content)

    #v(-2.5em)
    $
      rebase(#flower.one((
        pistil: (
          size: 3cm,
          color: aqua.lighten(50%),
          content: flower.one((
            pistil: (size: 0.75cm, color: white),
            petals: (
              (name: "1", color: red.lighten(5%)),
              (name: "1", color: red.lighten(20%)),
              (name: "1", color: red.lighten(35%)),
              (name: "1", color: red.lighten(50%)),
              (name: "1", color: red.lighten(65%)),
            )
          )).content
        ),
        petal_size: 5cm,
        petals: (
          (name: "1", color: aqua),
          (name: "1", color: aqua),
          (name: "1", color: aqua),
          (name: "1", color: aqua),
          (name: "1", color: aqua),
        )
      )).content)

      #xrule[srep]

      #move(dy: -4cm, scale(y: -100%, rebase(flower.one((
        pistil: (size: 0.7cm, color: aqua.lighten(50%)),
        petal_size: 11cm,
        petals: (
          (name: "p", content: rebase(move(dy: -0.9cm, scale(y: -100%, flower.one(stroke: none, (
            pistil: (color: none, size: 1.3cm),
            // angle: 1/5 * calc.pi * 1rad,
            petals: (
              (name: "1", content: rflower(red.lighten(5%))),
              (name: "1", content: rflower(red.lighten(20%))),
              (name: "1", content: rflower(red.lighten(35%))),
              (name: "1", content: rflower(red.lighten(50%))),
              (name: "1", content: rflower(red.lighten(65%))),
            )
          )).content)))), (:), (:), (:))
      )).content)))
    $
    // #v(0.5em)
    // (color for emphasis, fill with any content/polarity)
]

#slide(title: [Ex falso quodlibet])[
    #v(-2.5em)
    $
      rebase(#flower.one((
        pistil: (
          size: 3cm,
          color: aqua.lighten(50%),
          content: flower.one((
            pistil: (size: 0.75cm, color: white),
          )).content
        ),
        petal_size: 5cm,
        petals: (
          (name: "1", color: aqua),
          (name: "1", color: aqua),
          (name: "1", color: aqua),
          (name: "1", color: aqua),
          (name: "1", color: aqua),
        )
      )).content)

      #xrule[srep]

      #move(dy: -4cm, rotate(180deg, rebase(flower.one((
        pistil: (size: 0.7cm, color: aqua.lighten(50%)),
        petal_size: 11cm,
        petals: (
          (name: "p", content: rebase(move(dy: -0.9cm, flower.one(stroke: none, (
            pistil: (color: none, size: 1.3cm),
            angle: 1/5 * calc.pi * 1rad,
          )).content))), (:), (:), (:))
      )).content)))
    $
]

#slide(title: [QED])[
  $
    #rebase(flower.one((
      pistil: (size: 1cm, content: $a$),
      petals: ((name: "p1", content: $$), (name: "p2", content: $c$), (name: "p3", content: $d$), (name: "p4", content: $e$), (name: "p5", content: $f$))
    )).content)
    #xrule[epet]
  $
]

// #slide(title: [Example])[
//   #let make_flower(f) = rebase(flower.one(f).content)
  
//   #alternatives[
//     #make_flower((
//       pistil: (size: 4cm, content: make_flower((
//         pistil: (color: white, content: $x$),
//         petals: ((:), (name: "p2", content: $q(x)$), (:), (name: "p1", content: make_flower((
//           pistil: (color: white, size: 0.8cm, content: $p(x)$),
//         ))))
//       ))),
//       petals: ((:), (name: "p", content: move(dy: -1cm, make_flower((
//         pistil: (size: 2cm, content: $y #juxt p(y)$),
//         petals: ((:), (:), (name: "q", content: $q(y)$), (:))
//       )))), (:), (:))
//     ))
//   ]
// ]


#new-section-slide([*Metatheory*: Nature vs. Culture])

#slide(title: [Flowers as nested sequents])[
  // #show math.equation: set text(font: "STIX Two Math")
  #let lbl(name) = [#h(1cm) (#name)]

  #side-by-side[
    - *Sets* of variables $arrow(x)$
    - *Multisets* of flowers $Phi$
    - *Multisets* of petals $Delta$
    
    #set align(center)
    
    #v(1em)
    $
      phi, psi &eqq gamma csup Delta &#lbl[Flower] \
      gamma, delta &eqq arrow(x) dot.c Phi &#lbl[Garden] \
      \
      Phi, Psi &eqq phi_1, dots, phi_n &#lbl[Bouquet] \
      Gamma, Delta &eqq gamma_1; dots; gamma_n #h(0.8cm) &#lbl[Corolla] \
    $
  ][
    $
      arrow(x) dot.c Phi csup arrow(y_1) dot.c Psi_1; dots; arrow(y_n) dot.c Psi_n
    $
    #v(0.25cm)
    $
      #scale(x: 80%, y: 80%, reflow: true, rebase(flower.one((
        pistil: (size: 1.5cm, content: $accent(x, arrow) #h(8pt) Phi$),
        petal_size: 5cm,
        petals: (
          (name: "1", content: $accent(y_1, arrow) #h(8pt) Psi_1$),
          (name: "1", content: $accent(y_2, arrow) #h(8pt) Psi_2$),
          (name: "1", content: $accent(y_3, arrow) #h(8pt) Psi_3$),
          (name: "1", content: $accent(y_(i-1), arrow) #h(8pt) Psi_(n-1)$),
          (name: "1", content: $accent(y_n, arrow) #h(8pt) Psi_n$),
        )
      )).content)) \
    $
    #set text(size: 22pt)
    $
      forall arrow(x). (and.big Phi #limp or.big_i exists arrow(y_i). Psi_i)
    $
  ]
]

#slide(title: [Natural rules #nature])[
  $
    #nature =
    underbrace("(De)iteration", {#irule[poll$arrow.b$],#irule[poll$arrow.t$]}) union
    underbrace("Instantiation", {#irule[ipis],#irule[ipet]}) union
    underbrace("Scrolling", {#irule[epis]}) union
    underbrace("QED", {#irule[epet]}) union
    underbrace("Case reasoning", {#irule[srep]})
  $

  #pause

  #v(1em)

  // Let $Phi, Psi$ be _bouquets_, i.e. multisets of flowers.
  
  All rules are:

  - *Invertible*: if $Phi --> Psi$ then $Psi$ equivalent to $Phi$
  #pause
  #thus "Equational" reasoning

  #pause
  
  - #alert[*Analytic*]: if $Phi --> Psi$ and $a$ occurs in $Psi$ then $a$ occurs in $Phi$
  #pause
  #thus Reduces proof-search space
]

#slide(title: [Cultural rules #culture])[
  $
    #culture =
    underbrace("Insertion", {#irule[grow],#irule[glue]}) union
    underbrace("Deletion", {#irule[crop],#irule[pull]}) union
    underbrace("Abstraction", {#irule[apis],#irule[apet]})
  $

  #pause

  #v(1em)

  - All rules are *non-invertible*
  
  - Some rules are *non-analytic*
]

#slide(title: [Hypothetical provability])[
  - Remember our paradigm:
  #align(center)[*proving $=$ erasing*]

  #pause
  
  - This works in arbitrary #alert[contexts] $X$ (i.e. one-holed bouquets)

  #pause
  
  - Formally:

  #definition[
    For any bouquets $Phi$ and $Psi$, $Psi$ is _provable_ from $Phi$, written $Phi #ent Psi$, if for any context $X$ in which $Phi$ occurs and _pollinates_ the hole of $X$, we have
    $ #cfill($X$, $Psi$) --> #cfill($X$, phantom($Phi$)) $
  ]
]

#slide(title: [Cult-elimination])[
  #theorem("Soundness")[
    If $Phi --> Psi$ then $Psi #kent ^cal(K) Phi$ in every Kripke structure $cal(K)$.
  ]
  #pause
  #v(-1em)
  #theorem("Completeness")[
    If $Phi #kent ^cal(K) Psi$ in every Kripke structure $cal(K)$, then $Phi #ent ^#nature Psi$.
  ]
  #pause
  #v(-1em)
  #corollary([Admissibility of #culture])[
    If $Phi #ent Psi$ then $Phi #ent ^#nature Psi$.
  ]
  #pause
  #align(center)[
    *Completeness* of #alert[analytic] fragment #nature!
  ]
]


#new-section-slide([*The Flower Prover*])

#focus-slide[
  _A *#link("http://www.lix.polytechnique.fr/Labo/Pablo.DONATO/flowerprover")[demo]* is worth a thousand pictures!_
]

#slide(title: [Paradigm])[
  Another instance of *Proof-by-Action*:

  - *Direct manipulation* of the _goals_ themselves
  
  #pause
  
  - *Formulas* still supported, but #alert[superfluous]
  
  #pause
  
  - *Modal* interface to interpret click and DnD:

  $
    #text(fill: eastern.darken(20%))[Proof] #text[mode] &arrow.l.r.double.long #text(fill: eastern.darken(20%))[Natural] #text[(invertible and analytic) rules] \
    #text(fill: red.darken(20%))[Edit] #text[mode] &arrow.l.r.double.long #text(fill: red.darken(20%))[Cultural] #text[(non-invertible) rules] \
    #text(fill: purple.darken(20%))[Navigation] #text[mode] &arrow.l.r.double.long #text(fill: purple.darken(20%))[Contextual] #text[closure (functoriality)] \
  $

  #pause
  
  - Possible actions immediately visible:
  #thus *discoverable* and *touch-friendly*
]

#let step(name) = {
  pause
  h(1cm)
  xrule(name)
  h(-1cm)
}

#slide(title: [Towards Curry-Howard])[
  #v(-4em)
  
  #scale(x: 75%, y: 75%, $
    #rebase(flower.one((
      pistil: (size: 2cm, content: $
        #move(dx: -0.75cm, dy: 0.1cm, flower.one((
          pistil: (color: white, size: 0.75cm, content: $A$),
          angle: 1rad / 2,
          petals: ((:), (name: "1", content: $B$), (:), (:), (:), (:)),
        )).content) \
        #move(dy: -0.6cm, $A$)
      $),
      angle: 1rad / 2,
      petal_size: 4cm,
      petals: ((:), (name: "1", content: $B$), (:), (:), (:), (:)),
    )).content)

    #step[poll$arrow.b$]

    #rebase(flower.one((
      pistil: (size: 2cm, content: $
        #move(dx: -0.75cm, dy: 0.1cm, flower.one((
          pistil: (color: white, size: 0.75cm, content: $$),
          angle: 1rad / 2,
          petals: ((:), (name: "1", content: $B$), (:), (:), (:), (:)),
        )).content) \
        #move(dy: -0.6cm, $A$)
      $),
      angle: 1rad / 2,
      petal_size: 4cm,
      petals: ((:), (name: "1", content: $B$), (:), (:), (:), (:)),
    )).content)

    #step[srep]

    #h(-1em)
    #rebase(flower.one((
      pistil: (size: 1cm, content: $A$),
      petal_size: 4.5cm,
      petals: ((:), (name: "1", content: move(dx: -0.75cm, flower.one((
        pistil: (size: 0.75cm, content: $B$),
        angle: 1rad / 2,
        petals: ((:), (name: "a", content: $B$), (:), (:), (:), (:))
      )).content)), (:), (:)),
    )).content)

    #h(1em)
    #step[poll$arrow.b$]

    #h(-1em)
    #rebase(flower.one((
      pistil: (size: 1cm, content: $A$),
      petal_size: 4.5cm,
      petals: ((:), (name: "1", content: move(dx: -0.75cm, flower.one((
        pistil: (size: 0.75cm, content: $B$),
        angle: 1rad / 2,
        petals: ((:), (name: "a", content: $$), (:), (:), (:), (:))
      )).content)), (:), (:)),
    )).content)

    #h(1em)
    #step[epet]
  $)

  #set align(center)

  #pause
  #v(-1em)
  Where is the proof *object*??

  #pause
  #v(1em)
  $ underbrace(overbracket("Direct manipulation", "Dynamic"), #text(size: 24pt)[#only(7)[Proofs] #only(8)[Construction]])
    "of"
    underbrace(overbracket(#text[Flowers #emoji.flower.hibiscus], "Static"),
      #text(size: 24pt)[Statements #only(8)[$+$ Proofs]]) $

  #v(1em)
  #uncover(8)[#alert[Curry-Howard] style *proof-term* annotations]
]

#slide(title: [Towards Curry-Howard])[
  #v(-4em)
  
  #move(dx: -1em, scale(x: 75%, y: 75%, $
    #rebase(flower.one((
      pistil: (size: 2.5cm, content: $f : 
        #move(dx: -0.75cm, dy: 0.1cm, flower.one((
          pistil: (color: white, size: 0.75cm, content: $A$),
          angle: 1rad / 2,
          petals: ((:), (name: "1", content: $B$), (:), (:), (:), (:)),
        )).content) \
        #move(dx: 0cm, dy: -0.6cm, $x : A$)
      $),
      angle: 1rad / 2,
      petal_size: 4.5cm,
      petals: ((:), (name: "1", content: $B$), (:), (:), (:), (:)),
    )).content)

    #step[poll$arrow.b$]

    #rebase(flower.one((
      pistil: (size: 2.5cm, content: $f x : 
        #move(dx: -0.75cm, dy: 0.1cm, flower.one((
          pistil: (color: white, size: 0.75cm, content: $$),
          angle: 1rad / 2,
          petals: ((:), (name: "1", content: $B$), (:), (:), (:), (:)),
        )).content) \
        #move(dx: 0.4cm, dy: -0.6cm, $x : A$)
      $),
      angle: 1rad / 2,
      petal_size: 4.5cm,
      petals: ((:), (name: "1", content: $B$), (:), (:), (:), (:)),
    )).content)

    #step[srep]

    #h(-1em)
    #rebase(flower.one((
      pistil: (size: 1cm, content: $x : A$),
      petal_size: 5cm,
      petals: ((:), (name: "1", content: $
        #move(dy: 8mm, $"case"(f x) :$) \
        #move(dx: -0.75cm, flower.one((
          pistil: (size: 0.85cm, content: $y : B$),
          angle: 1rad / 2,
          petals: ((:), (name: "a", content: $B$), (:), (:), (:), (:))
        )).content)
      $), (:), (:)),
    )).content)

    #h(1.5em)
    #step[poll$arrow.b$]

    #h(-1.5em)
    #rebase(flower.one((
      pistil: (size: 1cm, content: $x : A$),
      petal_size: 5cm,
      petals: ((:), (name: "1", content: $
        #move(dy: 8mm, $"case"(f x) :$) \
        #move(dx: -0.75cm, flower.one((
          pistil: (size: 0.85cm, content: $y : B$),
          angle: 1rad / 2,
          petals: ((:), (name: "a", content: $y : B$), (:), (:), (:), (:))
        )).content)
      $), (:), (:)),
    )).content)
  $))
  
  #v(-2em)

  #set align(center)

  #pause
  
  #thus Proof steps recorded _inside_ statements~~#text(size: 16pt)[(but no dependent types!)]

  #pause
  
  #rect(inset: 1em)[
    $#text(fill: blue)[$t$] : #text(fill: red)[$phi$]$
    
    #text(fill: red)[
      #only(6)[Flower = Type = Normal term]
      #only("7-")[Flower = $#halert[Type = Normal term]$]
    ]
    
    #text(fill: blue)[
      Proof step = Neutral term
    ]
  ]

  #show quote.where(block: false): it => {
    ["] + h(0pt, weak: true) + it.body + h(0pt, weak: true) + ["]
    if it.attribution != none [ #it.attribution]
  }
  #uncover("7-")[
    #quote(attribution: [@miquel_implicative_2020])[
      Blurring the frontier between proofs and types
    ]
  ]
]

#slide(title: [Related works (non-exhaustive)])[
  // #set text(size: 19pt)
  
  // - *Intuitionistic existential graphs:*
  //   - @oostra_graficos_2010: original idea
  //   - @minghui_graphical_2019: variant on Oostra's graphs
    
  // #pause

    - *Structural proof theory:*
      - @guenot_nested_2013: rewriting-based *nested sequent* calculi
      - @lyon_refining_2021 @girlando_intuitionistic_2023: *fully invertible* labelled sequent calculi
      
    // #pause
    
    - *Proof assistants:*
      - @ayers_thesis: #sys[Box] datastructure similar to flowers
      
    // #pause
    
    - *Categorical logic:*
      - @Johnstone2002-rm: #alert[coherent/geometric formulas] in *topos theory*
      - @bonchi_diagrammatic_2024: algebra of #sys[Beta] ~~#text(size: 16pt)[(previous talk!)]
]

#slide(title: [Bibliography])[
  #set cite(form: none)  
  
  @Chaudhuri2013
  #cite(label("DBLP:conf/cade/Chaudhuri21"))
  @clouston-annotation-free-2013
  #cite(label("10.1145/3497775.3503692"))
  @guenot_nested_2013
  @Guglielmi1999ACO
  
  #bibliography(
    "main.bib",
    style: "chicago-author-date",
  )
]
