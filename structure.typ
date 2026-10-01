#import "theme.typ": *

#let conf(
  title: none,
  subtitle: none,
  authors: none,
  affiliation: none,
  abstract: none,
  contents: false,
  coverpage: false,
  paper-size: "a4",
  page-margin: 1in,
  column-count: 2,
  body-size: sz.body,
  heading-size: sz.h1,
  double-space: false,
  course: none,
  date: none,
  doc,
) = {
  // Page Setup
  set page(
    paper: paper-size,
    margin: page-margin,
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        set text(font: display-font, size: sz.footer)
        if calc.even(page-num) {
          align(left)[#authors.keys().first()#if authors.len() > 1 [ et al.]]
        } else {
          align(right)[#title]
        }
      }
    },
    footer: context {
        let page-num = counter(page).get().first()
        set text(font: display-font, size: sz.footer)
        set align(center)
        page-num
    }
  )

  // Text and Heading Styles
  set document(title: title + ": " + subtitle, author: authors.keys())
  set text(font: body-font, size: body-size, lang: "en", region: "US")
  set text(top-edge: 0.8em, bottom-edge: -0.2em)
  set par(leading: if double-space { 1em } else { 0.2em },
    spacing: if double-space { 1.5em } else { 0.8em }, justify: false)
  set cite(style: bibliography-style)
  show cite: set text(style: "italic")
  show bibliography: set text(size: body-size)
  show bibliography: set par(leading: 0.2em, spacing: 0.9em)
  show figure.caption: set align(left)
  show figure.caption: set text(size: 10pt)
  show figure.caption: set par(leading: 0.2em, spacing: 0.2em)
  set figure(gap: 8pt)
  set heading(numbering: "1-1")
  show heading: it => {
    if it.numbering == none {
      block(above: 1em, below: 0.5em, sticky: true)[
        #set par(leading: 0.2em, spacing: 0.2em)
        #set text(font: display-font, weight: "bold", size: heading-size)
        #upper(it.body)
      ]
    } else {
      block(above: 1em, below: 0.5em, sticky: true)[
        #set par(leading: 0.2em, spacing: 0.2em)
        #set text(font: display-font, weight: "bold", size: heading-size)
        #counter(heading).display()
        #upper(it.body)
      ]
    }
  }

  // Title Block Layout
  align(left)[
    #set par(leading: 0.2em, spacing: 0.5em)
    #block(text(font: display-font, weight: "bold", size: sz.title, upper(title)))
    #block(text(font: display-font, size: sz.body)[#subtitle])
    #v(1.5em)
    
    #let unique-affiliations = authors.values().dedup()
    #block(
      authors.pairs().map(((name, affiliation)) => {
        let idx = unique-affiliations.position(a => a == affiliation) + 1
        text(font: display-font, size: sz.author)[*#upper(name)*#if unique-affiliations.len() > 1 { super(str(idx)) }]
      }).join(text(font: display-font, size: sz.author)[, ])
    )
    #v(0.5em)
    #block(
      unique-affiliations.enumerate().map(((i, affiliation)) => {
        text(font: display-font, size: sz.body)[#if unique-affiliations.len() > 1 { super(str(i + 1)) } #affiliation]
      }).join(linebreak())
    )
    #if course != none { block(text(font: body-font, size: sz.author)[#course]) }
    #if date != none { block(text(font: body-font, size: sz.author)[#date]) }
    #v(0.5em)
  ]

  if abstract != none [
    #heading(numbering: none, outlined: false, "ABSTRACT")
    #abstract
  ]

  // Table of Contents & Abstract (Keep these in 1-column)
  if contents == true {
    outline(title: "CONTENTS", depth: 2)
  }

  if coverpage == true {
    pagebreak()
  } else {
    v(1em)
  }

  // Preserve the template's two-column default; course documents select one.
  if column-count == 1 { doc } else { columns(column-count, doc) }

}