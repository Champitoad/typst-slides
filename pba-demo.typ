#import "@preview/polylux:0.3.1": *
#import "theme/metropolis.typ": *
#import "@local/svg-emoji:0.1.0": setup-emoji

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


#title-slide(
  author: [Pablo Donato],
  title: "Proof-by-Action",
  subtitle: "Building proofs by hand 👆 (literally)",
  date: datetime.today().display(),
  extra: [
    #set text(size: 16pt)
    Proof and Computation autumn school --- Fischbachau
  ]
)

#slide(title: [Textual vs. Graphical])[
  #set align(center)

  #let user = text(size: 35pt)[🙇]
  #let computer = text(size: 35pt)[💻]

  *State-of-the art:* build proofs by writing *textual* commands (_tactics_)

  #centerFocus[
    #uncover("2-")[
      #user : #quote[Please apply _this_ rule]
    ]

    #alternatives-match(position: center + horizon, (
      "3": [
        #computer : "#text(fill: olive)[*✅ OK*] here is the result!"
      ],
      "4-": [
        #computer : "#text(fill: red)[*❌ ERROR:*] dkfsljfjdklsfjdkfjsldjfkdlsfj"
      ]
    ))
  ]
  
  #uncover("5-")[
    #squareFocus[
      #grid(
        columns: (auto),
        align: left,
        inset: 8pt,
        [*1st contribution:* build proofs by #alert[direct manipulation] of _formulas_],
        [
          #thus  No need to _memorize_ the rules \
          #thus  More _straightforward_ interaction
        ]
      )
    ]
  ]
]

#focus-slide[_A #link("https://www.actema.xyz")[*demo*] is worth a thousand words!_]

#slide(title: [Symbolic vs. Iconic])[
  - *Symbols* are hard to:
    - _learn_ $=>$ purely conventional meaning
    - _manipulate_ $=>$ need for very precise gestures

  #pause
  
  - Formulas can *interact* by being _moved_ in the same #alert[space]
  
  #pause

  #v(1cm)
  #set align(center)
  #squareFocus[
    *2nd contribution:* replace logical symbols by #alert[geometrical diagrams]
  ]
]

#focus-slide[_A #link("https://www.lix.polytechnique.fr/Labo/Pablo.DONATO/flowerprover/")[*demo*] is worth a thousand words!_]

#slide(title: "For more details...")[
  - Foundations in #alert[deep inference] = recent branch of *structural proof theory*

    - DnD actions (1#super[st] demo): *Subformula Linking* @Chaudhuri2013 @donato:DnD
    - #sys[Flower#h(2mm)Prover] (2#super[nd] demo): *Flower Calculus* @donato:LIPIcs.FSCD.2024.5

  - Sound and *complete* for (intuitionistic) first-order logic

  #centerFocus[
  "_It's all written in my #strike[book] PhD thesis_"

  @donato:tel-04698985
  ]
]

#slide(title: [Bibliography])[
  #set cite(form: none)

  @donato:DnD
  @donato:LIPIcs.FSCD.2024.5
  @donato:tel-04698985
  
  #bibliography(
    "main.bib",
    style: "chicago-author-date",
  )
]
