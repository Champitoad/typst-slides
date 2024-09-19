#new-section-slide[Contributions]

#slide(title: [Textual vs. #titleWord[Graphical]])[
  #set align(center)

  #let user = text(size: 35pt)[🙇]
  #let computer = text(size: 35pt)[💻]

  *State-of-the art:* build proofs by writing *textual* commands

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

// #slide(title: [Classical vs. Intuitionistic])[
//   - *Classical* logic: is this statement true?

//   - *Intuitionistic* logic: _how_ is this statement true?
// ]

