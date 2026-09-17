
#import "@preview/basic-report:0.5.0": *

#show: it => basic-report(
  body-font: "DejaVu Sans",
  heading-font: "DejaVu Sans",
  doc-category: "",
  doc-title: "Lorem",
  author: "Noah Schiro",
  affiliation: "Harvard",
  logo: "", // we can attach a small image here if we want with image("./path_to_image")
  language: "en",
  compact-mode: true,
  it
)

= Introduction
short problem statement here

== Background and motivation
#lorem(100)

= Data
source and description here.

= Problem statement
#lorem(100)

= Scope
#lorem(100)

= Methods
#lorem(100)

= Concerns and limitations
#lorem(100)
