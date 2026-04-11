#import "@local/zju-typst-tplt:0.2.0": *

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2026-03-21" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Image Processing" // 课程名称
#let proj-name = "Exercises for Image Transformation" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

// ==================== 正文内容 ==================== //
#problem(1)[
    2D Spatial Affine Transform
    - Triangle A has vertices at $A_1(0, 0)$, $A_2(2, 0)$, $A_3(0, 1)$.
    - Triangle B has vertices at $B_1(2, 1)$, $B_2(2, 5)$, $B_3(3, 1)$.
    Tasks:
    - Design a sequence of $3 times 3$ affine transformation matrices(homogeneous coordinates).
    - 1. Define the matrices for Scaling(S), Rotation(R), and Translation(T) (Order: S $->$ R $->$ T).
    - 2. Calculate the overall transformation marix $M = T times R times S$.
]
#SOLUTION

1. Because $abs(A_1 A_3) = abs(B_1 B_3)$, and $2 times abs(A_1 A_2) = abs(B_1 B_2)$, we can consider the scaling of x-axis is $plus.minus 2$. Furthermore, the order of $triangle A_1 A_2 A_3$ is counter-clockwise, while the order of $triangle B_1 B_2 B_3$ is clockwise, so $s_x = -2$. That is:

$
  S = mat(s_x, , ; , s_y, ; , , 1) = mat(-2, , ; , 1, ; , , 1)
$

Transforming $triangle A_1 A_2 A_3$ to $triangle B_1 B_2 B_3$, it is rotated $90degree$ clockwise, so $theta = -90degree$. That is:

$
  R = mat(cos(theta), -sin(theta), ; sin(theta), cos(theta), ; , , 1) = mat( , 1, ; -1,  , ; , , 1)
$

Now, $A_1 = (0, 0)$ is going to be shifted to $B_1 = (2, 1)$, so the translation is 

$
  T = mat(1, , t_x; , 1, t_y; , , 1) = mat(1, , 2; , 1, 1; , , 1)
$

2. Finally, the overall transformation matrix is:

$
  M = T times R times S = mat(1, , 2; , 1, 1; , , 1) times mat( , 1, ; -1,  , ; , , 1) times mat(-2, , ; , 1, ; , , 1) = mat( , 1, 2; 2, , 1; , , 1)
$






#pagebreak()
#problem(2)[
    - Given two random variables $R$ and $Z$ with the following probablity density functions(PDFs):

        $R$ has a PDF $p_r (r)$, $p_r (r) = 2 - 2r$.

        $Z$ has a PDF $p_z (z)$, $p_z (z) = 3z^2$.
    - Find the intensity ransformation function $z = T(r)$ that maps the original intensity $r$ to the target intensity $z$, such that the transformed original image matches the target PDF $p_z (z)$.
]
#SOLUTION

Determine the cumulative distribution functions(CDFs) of $R$ and $Z$:

$
    F_r (r) = integral_0^r p_r (t) "d"t = integral_0^r (2 - 2t) "d"t = 2r - r^2
$

$
    F_z (z) = integral_0^z p_z (t) "d"t = integral_0^z 3t^2 "d"t = z^3
$

Let $F_r (r) = F_z (z)$, so we have:

$
    2r - r^2 = z^3
$

$
    z = T(r) = root(3, 2r - r^2)
$






#pagebreak()
#problem(3)[
    Discrete Hitogram Equalilzation & Matching, given a grayscal image($L = 8$, intensity levels $0 ~ 7$) with 100 pixels.\
    Intensity distribution ($n_k$) for $k = 0$ to $7: [40, 20, 15, 10, 5, 5, 3, 2]$\
    Target probability distrbution ($p_z$) for $z = 0$ to $7: [0, 0.07, 0.10, 0.26, 0.28, 0.15, 0.11, 0.03]$

    - 1. Pergorm Histogram Equalization on the original image to find the discrete mapping values $s_k$.
    - 2. Compute the transformation function $G(z)$ for the target histogram.
    - 3. Perform Histogram Matching to map original intensity $r_k$ to target intensity $z_q$.
        - In case of a tie, choos the snaller $z_q$.
]
#SOLUTION

1. $p_r (r_k)$ for 0 to 7 is:

$
    p_r (r_k) = [0.40, 0.20, 0.15, 0.10, 0.05, 0.05, 0.03, 0.02]
$

so the cumulative distribution function $T (r_k)$ is:

$
    T (r_k) = (L - 1) sum_(i = 0)^(k) p_r (r_i) = [2.80, 4.20, 5.25, 5.95, 6.30, 6.65, 6.86, 7.00]
$

and the discrete mapping values $s_k$ is:

$
  s_k = round(T (r_k) + 0.5) = [3, 4, 5, 6, 6, 7, 7, 7]
$


\
2. $p_z (z_k)$ for k = 0 to 7 is:

$
    p_z (z_k) = [0, 0.07, 0.10, 0.26, 0.28, 0.15, 0.11, 0.03]
$

so the cumulative distribution function $G (z_k)$ is:

$
    G (z_k) = (L - 1) sum_(i = 0)^(k) p_z (z_i) = [0, 0.49, 1.19, 3.01, 4.97, 6.02, 6.79, 7.00]
$

Round $G (z_k)$:

$
    G (z_k) = [0, 0, 1, 3, 5, 6, 7, 7]
$

\
3. Perform Histogram Matching to map original intensity $r_k$ to target intensity $z_q$:

$
  z_q(r_k) = [3, 3, 4, 5, 5, 6, 6, 6]
$






