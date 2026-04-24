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


= 图像修复 Image Restoration
== 图像退化模型 Image Degradation Model
$ g(x, y) = cal(H){f(x, y)} + eta(x, y) $
- *空域模型*
$ g(x, y) = (h * f)(x, y) + eta(x, y) $
- *频域模型*
$ G(u, v) = H(u, v) F(u, v) + N(u, v) $

== 图像噪声 Image Noise
- *噪声模型* Noise Model
    - 随机噪声 Random
    - 脉冲噪声 Impulse Noise
    - 结构化噪声 Structured Noise
- *空域滤波器* Spatial Filter
- *频域滤波器* Frequency Filter


=== 噪声模型 Noise Model
#text(fill: red)[
    - *$x$ 为灰度等级！！！*
    - *$z$ 为复数空间坐标！！！*
]

==== 随机噪声 Random Noise
- *随机噪声主要源于：自然界中的热效应和光子效应【物理】*
1. 高斯噪声 Gaussian Noise
#grid(
    columns: (2fr, 1fr),
    [
        $ p(x) = 1/(sqrt(2pi) sigma) exp{-(x - overline(x))^2/(2sigma^2)} $
        $ E(p(x)) = overline(x) $
        $ D(p(x)) = sigma^2 $
    ],
    image("note_image/07-01-01.png", width: 100%)
)

2. 瑞利噪声 Rayleigh Noise
#grid(
    columns: (2fr, 1fr),
    [
        $ p(x) = (x - a)/sigma^2 exp{-(x - a)^2/(2sigma^2)}", " x >= a $
        $ E(p(x)) = a + (sqrt(2pi)sigma)/2 $
        $ D(p(x)) = 2sigma^2 - ((sqrt(2pi)sigma)/2)^2 $
    ],
    image("note_image/07-01-02.png", width: 100%)
)

3. 莱斯噪声 Rician Noise
$ I_"add" (z) = {I_r (z) + N_r (0, sigma^2)} + j{I_i (z) + N_i (0, sigma^2)} $
$ M(z) = M(z | I, sigma) = abs(I_"add" (z)) $
$ p(M | I, sigma) = M/(sigma^2) exp{-(M^2 + I^2)/(2sigma^2)} dot I_0 ((M I)/sigma^2) $
$
    I -> 0", " &p(M | I, sigma) -> p(x) "of Rayleigh Noise"\
    I -> +infinity", " &p(M | I, sigma) -> p(x) "of Gaussian Noise"
$
4. 伽马噪声 Gamma Noise
$ p(x) = (x/sigma)^{k-1} exp{-x/sigma}/(sigma Gamma(k)) $
5. 指数噪声 Exponential Noise
6. 平均噪声 Uniform Noise
==== 脉冲噪声 Impulse Noise
- *脉冲噪声主要源于：传感器故障和 or 图像传输错误【电气】*
1. 椒盐噪声 Salt-and-Pepper Noise
==== 结构化噪声 Structured Noise
- *结构化噪声主要源于：重影、运动、滤波、重建【系统】*
1. 周期性噪声 Periodic Noise

=== 空域滤波器 Spatial Filter
=== 频域滤波器 Frequency Filter
== 图像退化 Image Degradation
