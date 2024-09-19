#import "utils.typ": *

#let juxt = h(1em)

#let get_colors(inv) = {
  let fg = if inv { white } else { black }
  let bg = if inv { black } else { white }
  (fg: fg, bg: bg)
}

#let cut(eg, inv: false, inset: 5pt) = {
  let (fg, bg) = get_colors(inv)
  circle(fill: bg, stroke: none, inset: inset)[
    #set text(fill: fg)
    #eg
  ]
}

#let sheet(eg, inv: false) = {
  let (fg, bg) = get_colors(inv)
  rect(inset: 8pt, stroke: fg, fill: bg, {
    set text(fill: fg)
    set square(stroke: fg)
    eg
  })
}

#let nscroll(inv: true, fontsize: auto, outloop: (:), inloops: ()) = {
  let n = inloops.len()
  let r = mget(outloop, "size", 3cm)
  let default_outloop_size = r / 4
  let j = r / 24 // Join point radius
  let θ = -calc.pi / 2
  let (fg, bg) = get_colors(inv)
  
  let inloops_data = (:)
  for i in range(n) {
    let outloop = inloops.at(i)
    let default_name = str(i)
    let name = mget(outloop, "name", default_name)
    let content = mget(outloop, "content", none)
    let p = mget(outloop, "size", default_outloop_size)

    let μ = 2 * i * calc.pi / n + θ
    let angle = (x: calc.cos(μ), y: calc.sin(μ))

    // Compute coordinates of outloop center and join point
    let center = (x: (r - p) * angle.x, y: (r - p) * angle.y)
    let join = (x: r * angle.x, y: r * angle.y)

    // Shift coordinates for #place
    let center_coords = shift(center, (x: r - p, y: r - p))
    let join_coords = shift(join, (x: r - j, y: r - j))
    
    let (inloop_circle, inloop_join) = {
      if content != none {(
        // Draw the outloop circle
        circle(radius: p, fill: fg, stroke: none)[
          #set text(fill: bg)
          #set align(alignment.center + horizon)
          #content
        ],
        // Draw the outloop join point
        circle(radius: j, fill: orange, stroke: none)
      )} else {
        (none, none)
      }
    }
    
    // Save drawings and coordinates in a dictionary, for returning later
    inloops_data.insert(name, (
      circle: (element: inloop_circle, coords: center_coords),
      join: (element: inloop_join, coords: join_coords)
    ))
  }

  // Draw the outloop circle
  let inloop_circle = circle(radius: r, fill: bg, stroke: fg)[
    #set text(fill: fg)
    #set align(center + horizon)
    #mget(outloop, "content", none)
  ]

  // Join outloop and inloops in a box
  let size = 2 * r
  let content = box(width: size, height: size)[
    #set text(size:
      if fontsize == auto { default_outloop_size }
      else { fontsize }
    )
    #place(inloop_circle)
    #for (name, (circle, join)) in inloops_data {
      place(circle.element, dx: circle.coords.x, dy: circle.coords.y)
      place(join.element, dx: join.coords.x, dy: join.coords.y)
    }
  ]
  
  // Return content and inloops data
  (content: content, inloops: inloops_data)
}

#let curl = nscroll(outloop: (content: $a$, size: 6cm), inloops: (
  (content: $b$), (content: $c$), (content: $d$), (content: $e$), (content: $f$), 
))

#curl.content
#curl.inloops