#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2"

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2026-04-02" // 日期，格式为 YYYY-MM-DD
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
    - For a image with size $M times N$, prove that multiplying the image with $(-1)^(x + y)$ and applying Fourier transform, the DC component of the result frequency spectrum will in the center $[M"/"2, N"/"2]$
    - What will happen to the spectrum if we replace the $(-1)^(x + y)$ to $(-1)^x$
    #image("image/05-01.png", width: 90%)
]
#SOLUTION

- Perform Fourier transform on the image $f(x, y)$, we have:
$
  F(u, v) = 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) e^(-j 2 pi (u x"/"M + v y"/"N))
$
Now we multiply the image with $(-1)^(x + y)$, and let the result be $g(x, y) = f(x, y) (-1)^(x + y)$, then we have:
$
  G(u, v) 
  &= 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) g(x, y) e^(-j 2 pi (u x"/"M + v y"/"N)) \
  &= 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) dot (-1)^(x + y) e^(-j 2 pi (u x"/"M + v y"/"N)) \
$
because:
$
  (-1)^(x + y) = (j^2)^(x + y) = e^(j pi (x + y)) = e^(j 2 pi (x"/"2 + y"/"2))
$
therefore:
$
  G(u, v)
  &= 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) dot exp[j (2 pi) (x/2 + y/2)] dot exp[-j (2 pi) (u/M x + v/N y)] \
  &= 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) dot exp{-j (2 pi) [(u/M - 1/2) x + (v/N - 1/2) y]} \
  &= 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) dot exp{-j (2 pi) [(u - M"/"2)/M dot x + (v - N"/"2)/N dot y]} \
  &= F(u-M"/"2, v-N"/"2)
$
Furthermore, the DFT of $f(x, y)$ and $g(x, y)$ have periodicity, which means:
$
    F(u, v) = F(u + M, v) = F(u, v + N) = F(u + M, v + N)
$
So we have:
$
    G(u, v) =
    cases(
    F(u-M"/"2, v-N"/"2)             &"," u > M"/"2 and v > N"/"2,
    F(u-M"/"2 + M, v-N"/"2)         &"," u <= M"/"2 and v > N"/"2,
    F(u-M"/"2, v-N"/"2 + N)         &"," u > M"/"2 and v <= N"/"2,
    F(u-M"/"2 + M, v-N"/"2 + N)     &"," u <= M"/"2 and v <= N"/"2
    )
$
which is equals to $F(u, v)$ with the DC component shifted to the center $[M"/"2, N"/"2]$.

所以说把 $f(x, y)$ 和 $(-1)^(x + y)$ 相乘相当于在频域上把 $F(u, v)$ 的 DC 分量（也就是低频部分）移动到了频谱的中心位置 $[M"/"2, N"/"2]$，而高频部分则被移到了频谱的四个角落。

按照信号课的逻辑，$f(x, y)$ 经过 DFT 后的频谱 $F(u, v)$，应该只是在 $0 <= u < M and 0 <= v < N$ 范围内的一个剪影（相当于在整个频率域加了一个小范围的 mask）。在信号课中，全频率域的信号（也就是 $F(u, v)$ 的无数个周期延拓）会表示为 $tilde(F)(u, v)$，不太清楚在 2D 情况下怎么表示的，上面就直接用了 $F(u, v)$ 来表示全频率域的信号了。可能不太严谨，但是应该是可以理解的。


#v(2em)
- If we replace $(-1)^(x + y)$ to $(-1)^x$, just like the previous proof, we can get:
$
    h(x, y) = f(x, y) (-1)^x
$
and perform Fourier transform on $h(x, y)$, we have:
$
    H(u, v) = F(u-M"/"2, v)
$
which means the spectrum will be shifted to the center along x-axis, but not along y-axis.

也就是说低频部分被移到了 u 轴的中心位置，而 v 轴的频谱没有发生变化（还是在 v 轴的两端）。






#pagebreak()
#problem(2)[
    Consider the images shown.
    - The image was obtained by:
    (a) computing the DFT adn shift DC componet to center\
    (b) inverse the magnitude\
    (c) computing the inverse DFT
    - Explain(mathematically) why the image on the right appers as it does.
    #image("image/05-02.png", width: 90%)
]
#SOLUTION

要解释这种现象，其实就是把 DFT 的公式写一下。假设原图像的强度函数为 $f(x, y)$，进行一系列操作后的图像的强度函数为 $g(x, y)$。直接写 DFT 的结果：
$
  F(u, v) = 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) e^(-j 2 pi (u x"/"M + v y"/"N))
$
$
  G(u, v) = 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) g(x, y) e^(-j 2 pi (u x"/"M + v y"/"N))
$
根据题目的描述，$g(x, y)$ 是通过对 $F(u, v)$ 进行逆变换得到的，也就是：
$
  G(u, v) = -F(u, v)
$
所以就有：
$
  G(u, v) = 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) -f(x, y) e^(-j 2 pi (u x"/"M + v y"/"N))
$
显然：
$
  g(x, y) = -f(x, y)
$
也就是原图像的强度函数取了相反数，所以图像的亮度就被反转了，原来亮的部分变暗了，原来暗的部分变亮了。

不过可能 show 图像的时候要限定一下强度范围？不知道负数的强度怎么显示。感觉归一化是不错的方法。反正一定不要用 abs 函数就是了（取绝对值，刚反向过来的强度又反向回去了，有点地狱）。







#pagebreak()
#problem(3)[
    - Proving that for real image $f(x, y)$, the DFT result $F(u, v)$ satisfies property: $F(u, v) = F^*(-u, -v)$
    - For a 2D MR image, if the $"FOV"_x = "FOV"_y = 240$mm, and $max(k_x) = max(k_y) = 120$rad/m. Calculate the total number of full sampling pixels (total k-space sampling points) required according to Nyquist criterion.
    - If we use conjugate symmetry property, calculate the minimun nuber of required k-space sampling pixels for problem 2.
    #image("image/05-03.jpg", width: 90%)
]
#SOLUTION
- 证明 $F(u, v) = F^*(-u, -v)$，其实就是证明 $f(x, y)$ 是实函数，在正常的世界这是显然的。可以把 DFT 公式展开写一下：
$
    F(u, v) = 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) e^(-j 2 pi (u x"/"M + v y"/"N))
$
$
    F(-u, -v) = 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) e^(j 2 pi (u x"/"M + v y"/"N))
$
对 $F(u, v)$ 取共轭，由于$f(x, y)$ 是实函数：
$
  F^*(-u, -v) = 1/(M N)sum_(x = 0)^(M-1) sum_(y = 0)^(N-1) f(x, y) e^(-j 2 pi (u x"/"M + v y"/"N)) = F(u, v)
$

#v(2em)
- 先考虑 $x$ 方向，$"FOV"_x$ = 240mm，根据 Nyquist criterion:
$
  Delta k_x <= (2pi)/"FOV"_x = 1/0.24 m = (25pi)/3 "rad/m"
$
而在 $x$ 方向上 $max(k_x) = 120$rad/m，所以需要的采样点数为：
$
  N_x = ceil((2 max(k_x))/(Delta k_x)) = ceil((2 times 120) / (25pi"/"3)) = ceil(9.167) = 10
$
对于 $y$ 方向同理：
$
  N_y = ceil((2 max(k_y))/(Delta k_y)) = ceil((2 times 120) / (25pi"/"3)) = ceil(9.167) = 10
$
所以总的采样点数为：
$
  N_("total") = N_x times N_y = 10 times 10 = 100
$

#v(2em)
- 考虑共轭对称性的话，$F(u, v) = F^*(-u, -v)$，所以在 $k$ 空间中只需要采样一半的点就可以了，一共有：
$
    N_("half") = N_("total") / 2 = 50
$

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    
    // 1. 绘制网格 (0,0) 到 (9,9)
    grid((0, 0), (9, 9), step: 1, stroke: (paint: gray, dash: "dotted", thickness: 0.5pt))
    
    // ==========================================
    // 2. [新增] 绘制满足 u = -v 的直线
    // 在逻辑坐标系中，这对应从 (0, 9) 到 (9, 0) 的直线
    // ==========================================

    for x in range(10) {
      for y in range(10) {
        // 如果点在直线上或直线右上方 (即 x + y >= 9)
        if y >= 5 {
          circle((float(x), float(y)), radius: 3pt, fill: red, stroke: none)
        }
      }
    }

    for x in range(10) {
      for y in range(10) {
        // 如果点在直线上或直线右上方 (即 x + y >= 9)
        if y < 5 {
          circle((float(x), float(y)), radius: 3pt, fill: blue, stroke: none)
        }
      }
    }
    
    // 3. 绘制 u 轴 (横轴)
    line((-0.5, 4.5), (9.5, 4.5), mark: (end: ">"), stroke: 1.5pt)
    content((9.8, 4.5), [$u$])
    
    // 4. 绘制 v 轴 (纵轴)
    line((4.5, -0.5), (4.5, 9.5), mark: (end: ">"), stroke: 1.5pt)
    content((4.5, 9.8), [$v$])
    
    // 5. 标注中心交点 O (坐标 4.5, 4.5)
    content((4.2, 4.2), [$O$])
  })
]

红色标注的点即为要采样的点；蓝色的表示不需要采样，通过计算即可得到的点。