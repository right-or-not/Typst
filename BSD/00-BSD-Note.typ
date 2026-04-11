#import "@local/zju-typst-tplt:0.2.0": *

#show: BL

// information for notes
#let ymd = "2026-03-26"
#let course = "Biomedical Sensing and Detection"
#let proj-name = "Notes for Course"

// Homework template for note
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
    first-line-indent-all: true,
)

#set par(first-line-indent: 2em)

= 绪论

== 生物医学传感（传感器）

== 生物医学检测技术