// Typst template for the Nankai undergraduate internship report structure.

#let title-font = ("STZhongsong", "SimSun")
#let body-font = ("FangSong", "STFangsong", "SimSun")
#let heading-font = ("STKaiti", "KaiTi", "FangSong")

#let cover-field(label, value) = {
  grid(
    columns: (4.2cm, 1fr),
    column-gutter: 0.6cm,
    align: horizon,
    text(font: body-font, size: 16pt, weight: "bold")[#label],
    box(width: 100%, inset: (bottom: 3pt), stroke: (bottom: 0.7pt + black))[
      #text(font: body-font, size: 18pt, weight: "bold")[#value]
    ],
  )
}

#let internship-report(
  title: "南开大学本科实习报告",
  stu-num: "",
  stu-name: "",
  grade: "",
  major: "",
  department: "",
  course: "",
  instructor: "",
  date: "",
  abstract: none,
  keywords: "",
  body,
) = {
  set page(
    paper: "a4",
    margin: (
      top: 2.54cm,
      bottom: 2.54cm,
      left: 3.17cm,
      right: 3.22cm,
    ),
  )

  set text(font: body-font, size: 12pt)
  set par(justify: true, first-line-indent: 2em, leading: 1.5em)
  show figure: set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])

  show heading: it => {
    if it.level == 1 {
      v(0.9em)
      set text(font: heading-font, size: 14pt)
      set par(first-line-indent: 0em)
      counter(heading).display("1")
      [、]
      it.body
      v(0.35em)
    } else {
      v(0.45em)
      set text(font: body-font, size: 12pt, weight: "bold")
      set par(first-line-indent: 0em)
      it.body
      v(0.2em)
    }
  }

  show raw: it => {
    block(
      width: 100%,
      inset: 8pt,
      fill: luma(96%),
      stroke: 0.4pt + luma(80%),
      radius: 2pt,
      text(font: ("Consolas", "Courier New"), size: 9pt, it),
    )
  }

  align(center)[
    #v(0.6cm)
    #image("./img/NKU-name.png", width: 48%)
    #v(0.8cm)
    #text(font: title-font, size: 36pt)[#title]
    #v(2.6cm)
  ]

  align(center)[
    #box(width: 88%)[
      #stack(
        dir: ttb,
        spacing: 1.05em,
        cover-field("学号", stu-num),
        cover-field("姓名", stu-name),
        cover-field("年级", grade),
        cover-field("专业", major),
        cover-field("所属院（系）", department),
        cover-field("实习课程名称", course),
        cover-field("指导教师", instructor),
      )
    ]
    #v(2.2cm)
    #text(font: body-font, size: 15.5pt, weight: "bold")[#date]
  ]

  pagebreak()

  if abstract != none {
    align(center)[#text(font: title-font, size: 22pt)[摘   要]]
    v(1.1em)
    abstract
    if keywords != "" {
      v(0.8em)
      par(first-line-indent: 0em)[
        #text(weight: "bold")[关键词：]#keywords
      ]
    }
    pagebreak()
  }

  align(center)[#text(font: title-font, size: 22pt)[目   录]]
  v(1em)
  outline(title: none, depth: 2)

  pagebreak()

  align(center)[#text(font: title-font, size: 22pt)[说   明]]
  v(1.2em)

  set heading(numbering: "1.1")
  body
}

#let info-line(label, value) = {
  par(first-line-indent: 0em)[
    #text(weight: "bold")[#label：]#value
  ]
}

#let report-card(title, accent, body) = {
  block(
    width: 100%,
    inset: 9pt,
    fill: accent.lighten(88%),
    stroke: 0.7pt + accent.lighten(15%),
    radius: 3pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: accent.darken(35%))[#title]
    #v(0.35em)
    #body
  ]
}
