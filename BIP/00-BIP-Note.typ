#import "@local/zju-typst-tplt:0.2.0": *

#show: BL

// information for notes
#let ymd = "2026-04-16"
#let course = "Biomedical Image Processing"
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



