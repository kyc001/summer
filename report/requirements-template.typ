// Typst template for a software requirements specification document.

#let title-font = ("STZhongsong", "SimSun")
#let body-font = ("FangSong", "STFangsong", "SimSun")
#let heading-font = ("SimHei", "Microsoft YaHei", "KaiTi")
#let code-font = ("Consolas", "Courier New")
#let accent = rgb("#245f8f")
#let table-stroke = 0.45pt + luma(72%)

#let cover-field(label, value) = {
  grid(
    columns: (3.5cm, 1fr),
    column-gutter: 0.6cm,
    align: horizon,
    text(font: body-font, size: 14pt, weight: "bold")[#label],
    box(width: 100%, inset: (bottom: 3pt), stroke: (bottom: 0.65pt + black))[
      #text(font: body-font, size: 14pt)[#value]
    ],
  )
}

#let info-line(label, value) = {
  par(first-line-indent: 0em)[
    #text(weight: "bold")[#label：]#value
  ]
}

#let priority-color(priority) = {
  if priority == "高" {
    rgb("#b33a3a")
  } else if priority == "中" {
    rgb("#9a6b1f")
  } else {
    rgb("#3f7352")
  }
}

#let srs-box(title, box-accent, body) = {
  block(
    width: 100%,
    inset: 9pt,
    fill: box-accent.lighten(88%),
    stroke: 0.7pt + box-accent.lighten(16%),
    radius: 3pt,
  )[
    #set par(first-line-indent: 0em)
    #text(font: heading-font, weight: "bold", fill: box-accent.darken(30%))[#title]
    #v(0.35em)
    #body
  ]
}

#let requirement-card(id, title, priority: "中", body) = {
  block(
    width: 100%,
    inset: 9pt,
    fill: accent.lighten(92%),
    stroke: 0.6pt + accent.lighten(25%),
    radius: 3pt,
  )[
    #set par(first-line-indent: 0em, leading: 1.35em)
    #grid(
      columns: (1fr, auto),
      align: horizon,
      text(font: heading-font, weight: "bold", fill: accent.darken(25%))[
        #id #h(0.5em) #title
      ],
      box(fill: priority-color(priority), inset: (x: 6pt, y: 2pt), radius: 2pt)[
        #text(size: 9pt, fill: white, weight: "bold")[#priority]
      ],
    )
    #v(0.35em)
    #body
  ]
}

#let requirements-spec(
  project-id: "",
  project-name: "",
  classification: "需求规格说明",
  version: "V1.0",
  department: "",
  author: "",
  finish-date: "",
  use-department: "",
  leader: "",
  maintainer: "",
  user: "",
  reviewer: "",
  review-date: "",
  abstract: none,
  keywords: "",
  body,
) = {
  set page(
    paper: "a4",
    margin: (
      top: 2.45cm,
      bottom: 2.45cm,
      left: 3.05cm,
      right: 2.85cm,
    ),
    header: align(left)[
      #text(font: body-font, size: 9pt, fill: luma(45%))[#project-name]
    ],
    footer: context align(center)[
      #text(font: body-font, size: 9pt, fill: luma(45%))[第 #counter(page).display("1") 页]
    ],
  )

  set text(font: body-font, size: 12pt)
  set par(justify: true, first-line-indent: 2em, leading: 1.5em)
  show figure: set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])

  align(center)[
    #v(0.5cm)
    #image("./img/NKU-name.png", width: 46%)
    #v(1.3cm)
    #text(font: title-font, size: 30pt, weight: "bold")[需求规格说明书]
    #v(0.25cm)
    #text(font: code-font, size: 12pt)[Software Requirements Specification]
    #v(0.25cm)
    #text(font: body-font, size: 13pt)[Version: #version]
    #v(1.2cm)
  ]

  align(center)[
    #box(width: 86%)[
      #stack(
        dir: ttb,
        spacing: 1.0em,
        cover-field("项目编号", project-id),
        cover-field("项目名称", project-name),
        cover-field("分类", classification),
        cover-field("项目承担部门", department),
        cover-field("撰写人", author),
        cover-field("完成日期", finish-date),
      )
    ]
  ]

  v(1.6cm)

  align(center)[
    #box(width: 86%)[
      #stack(
        dir: ttb,
        spacing: 0.75em,
        cover-field("本文档使用部门", use-department),
        cover-field("主管领导", leader),
        cover-field("维护人员", maintainer),
        cover-field("用户", user),
        cover-field("评审负责人", reviewer),
        cover-field("评审日期", review-date),
      )
    ]
  ]

  pagebreak()

  align(center)[#text(font: title-font, size: 22pt)[文档控制信息]]
  v(1em)
  figure(
    table(
      columns: (3.2cm, 1fr, 3.2cm, 1fr),
      inset: 7pt,
      stroke: table-stroke,
      align: (center, left, center, left),
      [文档名称], [需求规格说明书], [版本号], [#version],
      [项目编号], [#project-id], [密级], [内部],
      [项目名称], [#project-name], [分类], [#classification],
      [撰写人], [#author], [完成日期], [#finish-date],
      [使用部门], [#use-department], [维护人员], [#maintainer],
      [评审负责人], [#reviewer], [评审日期], [#review-date],
    ),
    kind: table,
    caption: [文档基本信息],
  )

  v(0.8em)
  figure(
    table(
      columns: (2.4cm, 3.3cm, 3.6cm, 1fr),
      inset: 7pt,
      stroke: table-stroke,
      align: (center, center, center, left),
      table.header([版本], [日期], [作者], [说明]),
      [V0.1], [#finish-date], [#author], [形成需求规格说明书初稿，覆盖项目范围、功能需求、非功能需求和数据字典。],
      [V1.0], [评审后更新], [项目组], [根据评审意见补充约束、接口、验收标准和风险说明。],
    ),
    kind: table,
    caption: [修订记录],
  )

  if abstract != none {
    v(1em)
    align(center)[#text(font: title-font, size: 18pt)[摘   要]]
    v(0.7em)
    abstract
    if keywords != "" {
      v(0.6em)
      par(first-line-indent: 0em)[
        #text(weight: "bold")[关键词：]#keywords
      ]
    }
  }

  pagebreak()

  align(center)[#text(font: title-font, size: 22pt)[目   录]]
  v(1em)
  outline(title: none, depth: 3)

  pagebreak()

  set heading(numbering: "1.1")
  show heading: it => {
    if it.level == 1 {
      v(0.85em)
      set text(font: heading-font, size: 15pt, weight: "bold")
      set par(first-line-indent: 0em)
      [#counter(heading).display("1")#h(0.6em)#it.body]
      v(0.35em)
    } else if it.level == 2 {
      v(0.55em)
      set text(font: heading-font, size: 13pt, weight: "bold")
      set par(first-line-indent: 0em)
      [#counter(heading).display("1.1")#h(0.6em)#it.body]
      v(0.2em)
    } else {
      v(0.4em)
      set text(font: body-font, size: 12pt, weight: "bold")
      set par(first-line-indent: 0em)
      [#counter(heading).display("1.1.1")#h(0.6em)#it.body]
      v(0.15em)
    }
  }

  body
}
