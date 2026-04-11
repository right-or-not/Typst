#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-12-09" // 日期，格式为 YYYY-MM-DD
#let course = "误差理论与数据处理" // 课程名称
#let proj-name = "Exercise for Chapter 4" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#let r = 3.132
#let sigma_r = 0.005
#problem(4.1)[
  某圆球的半径为 $r$，若重复 10 次测量得 $r plus.minus sigma_r = (#r plus.minus #sigma_r)$ cm，试求该圆球最大截面的圆周和面积及圆球体积的测量不确定度。（置信概率 $P = 99%$）。
]
#SOLUTION

// 1. 截面周长
1. *圆球最大截面的圆周：*先写出计算公式
$
  L = 2 pi r = 19.68"cm"
$
所以可以得到圆球最大截面的圆周的合成不确定度 $u_c_L = sigma_L$ 为
$
  u_c_L = sqrt(((partial L)/(partial r))^2 dot sigma_r^2) = abs((partial L)/(partial r)) dot sigma_r = 2 pi dot sigma_r = 0.031"cm"
$
以上不确定度 $u_c_L$ 由贝塞尔公式求得，因此自由度 $nu = n-1 = 9$。取置信概率 $P = 99%$，查表可得：$k = t_p (nu) = t_(99%)(nu) = 3.25$。因此圆球最大截面的圆周的展伸不确定度为：
$
  U_L = k dot u_c_L = 3.25 times 0.031 = 0.102"cm" approx 0.10"cm"
$
#h(2em) 综上，圆球最大截面的圆周的展伸不确定度 $U_L = k dot u_c_L = 0.10"cm"$，是由合成标准不确定度 $u_c_L = 0.031"cm"$ 及包含因子 $k = 3.25$ 确定的，对应的置信概率 $P = 99%$，自由度 $nu = 9$。\
\

// 2. 截面面积
2. *圆球最大截面的面积：*先写出计算公式
$
  S = pi r^2 = 30.82"cm"^2
$
所以可以得到圆球最大截面的面积的合成不确定度 $u_c_S = sigma_S$ 为
$
  u_c_S = sqrt(((partial S)/(partial r))^2 dot sigma_r^2) = abs((partial S)/(partial r)) dot sigma_r = 2pi r dot sigma_r = 0.098"cm"^2
$
同(1)理，取 $k = 3.25$，得圆球最大截面的面积的展伸不确定度为：
$
  U_S = k dot u_c_S = 3.25 times 0.098 = 0.320"cm"^2 approx 0.32"cm"^2
$
#h(2em) 综上，圆球最大截面的面积的展伸不确定度 $U_S = k dot u_c_S = 0.32"cm"^2$，是由合成标准不确定度 $u_c_L = 0.098"cm"^2$ 及包含因子 $k = 3.25$ 确定的，对应的置信概率 $P = 99%$，自由度 $nu = 9$。\
\

// 3. 圆球体积
3. *圆球的体积：*先写出计算公式
$
  V = 4/3 pi r^3 = 128.7"cm"^3
$
所以可以得到圆球体积的合成不确定度 $u_c_V = sigma_V$ 为
$
  u_c_V = sqrt(((partial V)/(partial r))^2 dot sigma_r^2) = abs((partial V)/(partial r)) dot sigma_r = 4pi r^2 dot sigma_r = 0.62"cm"^3
$
同(1)理，取 $k = 3.25$，得圆球最大截面的面积的展伸不确定度为：
$
  U_V = k dot u_c_V = 3.25 times 0.62 = 2.003"cm"^3 approx 2.0"cm"^3
$
#h(2em) 综上，圆球最大截面的圆周的展伸不确定度 $U_V = k dot u_c_V = 2.0"cm"^3$，是由合成标准不确定度 $u_c_V = 0.62"cm"^3$ 及包含因子 $k = 3.25$ 确定的，对应的置信概率 $P = 99%$，自由度 $nu = 9$。\



#pagebreak()
#problem(4.2)[
  望远镜的放大率 $D = f_1"/"f_2$，已测得物镜主焦距 $f_1 plus.minus sigma_1 = (19.80 plus.minus 0.10)$ cm，目镜的主焦距 $f_2 plus.minus sigma_2 = (0.800 plus.minus 0.005)$ cm，求放大率测量中由 $f_1$、$f_2$ 引起的不确定度分量和放大率 $D$ 的不准确度。
]
#SOLUTION

先计算放大率的估计值：
$
  D = (f_1)/(f_2) = 24.75
$


1. *$f_1$ 引起的不确定度分量：*
$
  u_1 = sqrt(((partial D)/(partial f_1))^2 dot sigma_1^2) = abs((partial D)/(partial f_1)) dot sigma_1 = 1/(f_2) dot sigma_1 = 0.125 approx 0.12
$

2. *$f_2$ 引起的不确定度分量：*
$
  u_2 = sqrt(((partial D)/(partial f_2))^2 dot sigma_2^2) = abs((partial D)/(partial f_2)) dot sigma_2 = (f_1)/(f_2^2) dot sigma_2 = 0.1547 approx 0.15
$

3. *放大率 $D$ 的合成不准确度：*
$
  u_c = sqrt(u_1^2 + u_2^2) = 0.192 approx 0.19
$
#h(2em) 
综上，
$f_1$ 引起的不确定度分量 $u_1 = 0.12$，
$f_2$ 引起的不确定度分量 $u_2 = 0.15$，
放大率 $D$ 的合成不准确度 $u_c = 0.19$。





#pagebreak()
#problem(4.4)[
  某校准证书说明，标称值 $10Omega$ 的标准电阻器的电阻 $R$ 在 $20℃$ 时为 $10.000742 Omega plus.minus 129 mu Omega$（$P = 99%$），求该电阻器的标准不确定度，并说明属于哪一类评定的不确定度。
]
#SOLUTION

由题意可知：极限误差区间半宽 $a = 129 mu Omega$，取置信概率 $P = 99%$，查标准正态分布表可知：$k_p = 2.58$。则该电阻器的标准不确定度：
$
  u_c = a/(k_p) = 129/2.58 mu Omega = 50mu Omega
$
显然，该类评定不确定度的方法是一局“校准证书”，因此为*B类标准不确定度评定*。





#pagebreak()
#let l_1 = 40
#let l_2 = 10
#let l_3 = 2.5
#problem(4.5)[
  在光学计上用 $#{l_1 + l_2 + l_3}$ mm 的量块组作为标准件测量圆柱体直径，量块组由三块量块研合而成，其尺寸分别是：$l_1 = #l_1$mm，$l_2 = #l_2$mm，$l_3 = #l_3$mm，量块按“级”使用，经查手册得其研合误差分别不超过 $plus.minus 0.45 mu$m、$plus.minus 0.30 mu$m、$plus.minus 0.25 mu$m（取置信概率 $P = 99.73%$ 的正态分布），求该量块引起的测量不确定度。
]
#SOLUTION

由题意可知：量块组的合成公式为：
$
  L = l_1 + l_2 + l_3
$
极限误差区间半宽 
$a_1 = 0.45 mu m$，
$a_2 = 0.30 mu m$，
$a_3 = 0.25 mu m$
取置信概率 $P = 99.73%$，查标准正态分布表可知：$k_p = 3$。则每块量块的标准不确定度为：
$
  u_l_1 = (a_1)/(k_p) = 0.45/3 mu m = 0.15 mu m \
  u_l_2 = (a_2)/(k_p) = 0.30/3 mu m = 0.10 mu m \
  u_l_3 = (a_3)/(k_p) = 0.25/3 mu m = 0.083 mu m approx 0.08 mu m \
$
则每块量块的不确定度引起的不确定度分量为：
$
  u_1 = abs((partial L)/(partial l_1)) dot u_l_1 = 0.15 mu m \
  u_2 = abs((partial L)/(partial l_2)) dot u_l_2 = 0.10 mu m \
  u_3 = abs((partial L)/(partial l_3)) dot u_l_3 = 0.08 mu m \
$
该量块的合成标准不确定度为：
$
  u_c = sqrt(u_1^2 + u_2^2 + u_3^2) = 0.197 mu m approx 0.20 mu m
$



