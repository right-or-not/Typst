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


= 图像分割 Image Segmentation
- *定义 Definition*
- *不连续性 Discontinuity*
    - 点检测 Point detection
    - 线检测 Line detection
    - 边缘检测 Edge detection
    - 角点检测 Corner detection
- *相似性 Similarity*
    - 阈值划分 Thresholding
    - 区域方法 Region Methods
    - 聚类方法 Clustering Methods
    - 移动对象 Moving Object


== 定义 Definition
== 不连续性 Discontinuity
=== 数学回顾 Math Review
=== 点检测 Point Detection
=== 线检测 Line Detection
=== 边缘检测 Edge Detection
=== 边缘连接 Edge Connection
== 相似性 Similarity
=== 阈值划分 Thresholding
==== 全局阈值 Global Thresholding
==== 自适应阈值 Adaptive Thresholding

=== 区域方法 Region Methods
=== 聚类方法 Clustering Methods
==== K-means
==== SLIC Superpixel
=== 移动对象 Moving Object
