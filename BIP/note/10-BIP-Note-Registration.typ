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


= 图像配准 Image Registration

解决问题：
- 一个月后复查，图像位置发生改变
- 检查过程中患者运动
- CT 和 PET
- 比较不同患者、患者和标准模板

== 线性配准 Linear Registration
=== 配准基础 Registration Basis
- Point-based methods
- Surface-based methods
- *Intensity-based methods*
    - Optimize the MSE between moving image and source image.

=== 配准框架 Registration Pipeline


== 非线性配准
== 标准工具和框架