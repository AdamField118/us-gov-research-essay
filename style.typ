// Course settings for Adam Field's WPI template.
#import "structure.typ": conf
#import "theme.typ": bibliography-style

#let paper(
  kind: "Research Essay, Draft 1",
  title: "Who Controls American Science?",
  subtitle: "Federal Funding and the Struggle Between Congress and the Executive Branch",
  proposal: false,
  date: "September 24, 2026",
  body,
) = conf(
  title: title,
  subtitle: subtitle,
  authors: ("Adam Field": "Department of Physics, WPI"),
  course: "GOV 1301 -- " + kind,
  date: date,
  paper-size: "us-letter",
  page-margin: 1in,
  column-count: 1,
  body-size: 12pt,
  heading-size: 13pt,
  double-space: true,
  abstract: none,
  contents: false,
  coverpage: false,
  body,
)

#let references(title: "References") = bibliography(
  "references.bib",
  title: title,
  style: bibliography-style,
)
