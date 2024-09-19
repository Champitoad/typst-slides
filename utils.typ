// Unit constructors
#let cm(x) = x * 1cm
#let rad(x) = x * 1rad

// Default getter for dictionary fields
#let mget(dict, field, default) = {
  dict.at(field, default: default)
}

// Shift a point represented by its coordinates in a dictionary (x: float, y: float)
// by the amount of a vector also specified by its coordinates
#let shift(point, vec) = (
  x: point.x + vec.x,
  y: point.y + vec.y
)

// Add horizontal space around operator
#let spar(op, spacing: 2em) = {
  h(spacing)
  op
  h(spacing)
}

// Additional info on right of slide title
#let title-right(content) = {
  place(right, dy: -3mm, content)
}

// Highlight alert
#let halert(content) = {
  block(fill: rgb("#ec8d33").transparentize(75%), outset: 8pt, content)
}

// Phantom text, like the \phantom LaTeX macro
#let phantom(txt) = {
  text(fill: white.transparentize(100%), txt)
}

// Position content relative to its center instead of top-left corner
#let move_to_center(content) = context {
  let content_size = measure(content)
  let to_center = (x: -content_size.width / 2, y: -content_size.height / 2)
  move(dx: to_center.x, dy: to_center.y, content)
}

#let squareFocus(content) = rect(inset: 15pt, content)

#let centerFocus(content, size: 22pt) = [
  #set align(center)
  #set text(size)
  #v(1em)
  #content
  #v(1em)
]