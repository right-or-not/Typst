#let box_title(title, body) = {
  block(
    breakable: false, 
    width: 100%, 
    spacing: 0.5em, 
    stack(
      dir: ttb,
      spacing: 0.5em,
      
      text(
        font: ("Segoe UI", "SimHei", "Microsoft YaHei"),
        fill: red, 
        weight: "bold", 
        size: 1.2em, 
        stroke: 0.15pt + red,
        title
      ),
      
      body
    )
  )
}

#let cheat_sheet(body) = {
  let font_size = 5pt
  let col_count = 4
  let page_margin = 0.2cm
  let col_gutter = 0.8em 
  
  set page(
    paper: "a4",
    flipped: true, 
    margin: page_margin,
    
    // Grid 背景逻辑保持不变
    background: {
      set text(size: font_size)
      pad(x: page_margin, y: page_margin, 
        grid(
          columns: (1fr, col_gutter) * (col_count - 1) + (1fr,),
          rows: 100%, 
          stroke: none, 
          ..range(col_count * 2 - 1).map(i => {
            if calc.even(i) { [] } else {
              align(center, line(start: (0pt, 0pt), end: (0pt, 100%), stroke: 0.5pt + gray.lighten(50%)))
            }
          })
        )
      )
    }
  )

  
  set text(
    font: ("Segoe UI", "SimSun"), 
    size: font_size, 
    stroke: 0.02pt + black,
    lang: "zh"
  )
  set par(leading: 0.7em, justify: true)
  set block(spacing: 0.7em)

  show heading: set text(
    font: ("Segoe UI", "SimHei", "Microsoft YaHei"), 
    fill: black, 
    weight: "bold"
  )
  
  show heading: set block(above: 1.2em, below: 0.8em)
  show heading: set par(leading: 0.6em)

  show heading.where(level: 1): set text(size: 1.1em, stroke: 0.1pt + black) 
  show heading.where(level: 2): set text(size: 1.05em, stroke: 0.1pt + black) 
  show heading.where(level: 3): set text(size: 1.02em, stroke: 0.1pt + black) 

  show strong: it => {
    text(
      stroke: 0.1pt,
      it
    )
  }

  columns(col_count, gutter: col_gutter, body)
}

