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


= 图像形态学 Image Morphology
- Binary Image
    - 
- Grey Scale Image


#h(0em)

Image A: 1000 $times$ 1000

Image B: 3 $times$ 3 $eq.triple$
structure element (SE) = convolution kernel
- 0
- 1
- x: not care


== 二值图像 Binary Image
- *$z eq.triple (x, y)$ shows the coordinate of a pixel *

=== 腐蚀 Erosion
- Erose the pixels in A with a width of `width(B)/2`, of which the value is $1$. $ A minus.o B = {z | (B)_z subset.eq A} $

=== 膨胀 Dilation
- Dilate the pixels in A with a width of `width(B)/2`, of which the value is $1$. $ A plus.o B = {z | (B)_z inter A eq.not diameter} $

#strong[
    Some Properties of Erosion and Dilation:
    - Translation: $ (A plus.o B)_z = A_z plus.o B $
    - Order Invarient: $ (A plus.o B) plus.o C = A plus.o (B plus.o C) $
]

=== 开 Opening
- Open A with B: $ A compose B = (A minus.o B) plus.o B $
- 关键是腐蚀 Erosion
- 连接处可能断开
- 内角不变、外角平滑

=== 闭 Closing
- Close A with B: $ A dot B = (A plus.o B) minus.o B $
- 关键是膨胀 Dilation
- 内部裂缝可能填充
- 内角平滑、外角不变

=== 命中与否 Hit-or-Miss
- Hit-or-Miss A with B: $ A dot.o B = (A minus.o B) inter (A^c plus.o B) $ $ A dot.o B = A inter B^* $

=== 边缘提取 Boundary Extraction
- Extract the boundary of A with a width of `width(B)/2`. $ beta(A) = A - A minus.o B $

=== 空洞填充 Hole Filling
- Fill the holes in A with B: $ X_k = (X_(k-1) plus.o B) inter A^c $ $ phi(A) = A union X_k $

=== 检测联通组件 Connected Component Detection
- Detect the structure in A with B: $ X_k = (X_(k-1) plus.o B) inter A $