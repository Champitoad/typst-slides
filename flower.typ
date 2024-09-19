#import "utils.typ": *

#let pistil_color = rgb("FFF344")

#let sheet(content) = rect(fill: pistil_color, inset: 5pt, content)

// Evaluate the bezier polynomial at t
#let beval(p1, c1, c2, p2, t) = {
  t * t * t * p1 + 3 * (1 - t) * t * t * c1 + 3 * (1 - t) * (1 - t) * t * c2 + (1 - t) * (1 - t) * (1 - t) * p2
}

#let bbeval(p1, c1, c2, p2) = {
  let a = 3 * p1 - 9 * c1 + 9 * c2 - 3 * p2
  let b = 6 * c1 - 12 * c2 + 6 * p2
  let c = 3 * c2 - 3 * p2
  let local_candidates = if calc.abs(a) < 1e-9 {
    if calc.abs(b) < 1e-9 {
      ()
    } else {
      (-c / b,)
    }
  } else {
    let delta = b * b - 4 * a * c
    let c1 = (-b - calc.sqrt(delta)) / (2 * a)
    let c2 = (-b + calc.sqrt(delta)) / (2 * a)
    (c1, c2)
  }
  let local = local_candidates.filter(x => 0 <= x and x <= 1)
  let candidates = (0, 1) + local
  let values = candidates.map(x => beval(p1, c1, c2, p2, x))
  (min: calc.min(..values), max: calc.max(..values))
}

#let cubic_bounding(p1, c1, c2, p2) = {
  let bounding_x = bbeval(p1.x.cm(), c1.x.cm(), c2.x.cm(), p2.x.cm())
  let bounding_y = bbeval(p1.y.cm(), c1.y.cm(), c2.y.cm(), p2.y.cm())
  (min: (x: cm(bounding_x.min), y: cm(bounding_y.min)), 
   max: (x: cm(bounding_x.max), y: cm(bounding_y.max)))
}

#let bounding_union(b1, b2) = {
  (min: (x: calc.min(b1.min.x, b2.min.x), y: calc.min(b1.min.y, b2.min.y)),
   max: (x: calc.max(b1.max.x, b2.max.x), y: calc.max(b1.max.y, b2.max.x)))
}

#let control_size(radius, a1, a2, l) = {
  let x = calc.cos(a1) + calc.cos(a2)
  let y = calc.sin(a1) + calc.sin(a2)
  let norm = calc.sqrt(x * x + y * y)
  let d = 8 * l / norm - 4 * radius
  d / 3
}

#let one(f, stroke: black, text_size: 20pt) = {
  let pistil = f.pistil
  let flower = (
    angle: mget(f, "angle", 0rad) + 180deg,
    petal_size: mget(f, "petal_size", mget(pistil, "size", 1cm) * 3),
    petal_color: mget(f, "petal_color", white.transparentize(100%)),
    pistil: (
      color: mget(pistil, "color", pistil_color),
      content: mget(pistil, "content", block(width: 0cm, height: 0cm)),
      size: mget(pistil, "size", 1cm)
    ),
    petals: mget(f, "petals", ((:), (:), (:)))
  )
  
  if flower.petals.len() < 3 {
    panic("Expected at least 3 petals, got " + str(flower.petals.len()))
  }

  let step = 2 * rad(calc.pi) / flower.petals.len()
  let start = flower.angle + (rad(calc.pi) - step) / 2
  let radius = flower.pistil.size

  let petals_rendered = range(flower.petals.len()).map(i => {
    let petal = flower.petals.at(i)
    if petal.keys().contains("name") {
      let a1 = start + i * step
      let a2 = start + (i + 1) * step
      let size = control_size(radius, a1, a2, flower.petal_size)
      let p1 = (x: calc.cos(a1) * radius, y: calc.sin(a1) * radius)
      let c1 = (x: p1.x + calc.cos(a1) * size, y: p1.y + calc.sin(a1) * size)
      let p2 = (x: calc.cos(a2) * radius, y: calc.sin(a2) * radius)
      let c2 = (x: p2.x + calc.cos(a2) * size, y: p2.y + calc.sin(a2) * size)

      let top = (
        x: beval(p1.x, c1.x, c2.x, p2.x, 0.5),
        y: beval(p1.y, c1.y, c2.y, p2.y, 0.5),
      )
      let border = (
        x: radius * calc.cos((a1 + a2) / 2),
        y: radius * calc.sin((a1 + a2) / 2),
      )
      let shift = mget(petal, "shift", 1)
      let center = (
        x: border.x + shift * (top.x - border.x) * 0.5,
        y: -(border.y + shift * (top.y - border.y) * 0.5),
      )

      let fill = mget(petal, "color", mget(f, "petal_color", none))      

      let color = mget(petal, "color", none)
      let curve = path(stroke: stroke, fill: color,
        ((p1.x, p1.y), (p1.x - c1.x, p1.y - c1.y)),
        ((p2.x, p2.y), (c2.x - p2.x, c2.y - p2.y))
      )
      let bb = cubic_bounding(p1, c1, c2, p2)
      (
        curve: curve,
        bounding: bb,
        top: top,
        center: center, 
        fill: fill,
        name: petal.name,
        content: mget(petal, "content", none)
      )
    } else {
      (:)
    }
  }).filter(x => x.keys().contains("curve"))

  let circle_bb = (min: (x: -flower.pistil.size, y: -flower.pistil.size),
                   max: (x: flower.pistil.size, y: flower.pistil.size))
  let bounding = petals_rendered.fold(circle_bb, (acc, v) => bounding_union(acc, v.bounding))
  let width = bounding.max.x - bounding.min.x
  let height = bounding.max.y - bounding.min.y
  let to_shift = (x: width/2, y: -height/2)

  let content = box(width: width, height: height)[
    #set text(size: text_size)
    
    #for petal in petals_rendered {
      place(dx: to_shift.x, dy: -to_shift.y, petal.curve)
      context {
        let content = petal.content
        let content_size = measure(content)
        let to_center = (x: -content_size.width / 2, y: content_size.height / 2)
        let to_shift = shift(petal.center, shift(to_shift, to_center))
        place(dx: to_shift.x, dy: -to_shift.y, content)
      }
    }

    #let center = -flower.pistil.size
    #place(dx: center + to_shift.x, dy: center + -to_shift.y, circle(
      radius: flower.pistil.size,
      fill: flower.pistil.color,
      stroke: stroke,
    ))
    #context {
      let content_size = measure(flower.pistil.content)
      let to_center = (x: -content_size.width / 2, y: content_size.height / 2)
      let to_shift = shift(to_shift, to_center)
      place(dx: to_shift.x, dy: -to_shift.y, flower.pistil.content)
    }
  ]

  let petals_coords = (:)
  for petal in petals_rendered {
    petals_coords.insert(petal.name, 
      (top: shift(petal.top, to_shift), center: shift(petal.center, to_shift)))
  }
  (content: content, center: to_shift, petals: petals_coords)
}

#let empty(n, pistil: (size: 1cm, color: pistil_color), petal_size: 3cm) = {
  let petals = ()
  for i in range(n) {
    petals.push((name: "p" + str(i)))
  }
  one((
    pistil: pistil,
    petals: petals
  ))
}

#let f = one((
  pistil: (color: yellow),
  petal_size: 3cm,
  petals: ((name: "p1"), (name: "p2"), (name: "p3"))
))

#f.content
