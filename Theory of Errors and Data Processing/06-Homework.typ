#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-12-29" // 日期，格式为 YYYY-MM-DD
#let course = "误差理论与数据处理" // 课程名称
#let proj-name = "Exercise for Chapter 6" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(6.1)[
  材料的抗剪强度与材料承受的正应力有关。对某种材料试验的数据如下：
  #image("images/6_1.png", width: 100%)
  假设正应力的数值是精确的，求：
  1. 抗剪强度与正应力之间的线性回归方程；
  2. 当正应力为 24.5 Pa 时，抗剪强度的估计值是多少？
]
#SOLUTION

1. 线性回归方程如下：
$
  hat(y) = hat(a) + hat(b)x
$
根据表格中的数据可知：
$
  overline(x) &= 1/N sum_(i = 1)^N x_i = 25.967 \
  overline(y) &= 1/N sum_(i = 1)^N y_i = 24.767 \
  l_(x x) &= sum_(i = 1)^N (x_i - overline(x))^2 = sum_(i = 1)^N x_i^2 - N dot overline(x)^2 = 42.84 \
  l_(x y) &= sum_(i = 1)^N (x_i - overline(x))(y_i - overline(y)) = sum_(i = 1)^N x_i y_i - N dot overline(x) dot overline(y) = -29.74 \
  l_(y y) &= sum_(i = 1)^N (y_i - overline(y))^2 = sum_(i = 1)^N y_i^2 - N dot overline(y)^2 = 46.95
$
由此可以计算得到：
$
  hat(b) = (l_(x y))/(l_(x x)) = -29.74 / 42.84 = -0.69 \
  hat(a) = overline(y) - hat(b) dot overline(x) = 24.767 - (-0.69) dot 25.967 = 42.68
$
因此，抗剪强度与正应力之间的线性回归方程为：
$
  hat(y) = 42.68 - 0.69x
$

2. 当正应力为 24.5 Pa 时，抗剪强度的估计值为：
$
  hat(y) = 42.68 - 0.69 dot 24.5 = 25.46 "Pa"
$ 


#pagebreak()
#problem(6.2)[
  下表给出在不同质量下弹簧长度的观测值（设质量的观测值无误差）：
  #image("images/6_2.png", width: 100%)
  1. 作散点图，观察质量与长度之间是否呈线性关系；
  2. 求弹簧的刚性系数和自由状态下的长度。
]
#SOLUTION

1. 根据观测数据绘制的散点图如下所示：
#let data = (
  (5, 7.25),
  (10, 8.12),
  (15, 8.95),
  (20, 9.90),
  (25, 10.9),
  (30, 11.8),
)

#align(center)[
  #cetz.canvas({
    plot.plot(
      size: (10, 6),
      axis-style: "scientific",
      x-min: 0,
      x-max: 40,
      y-min: 0,
      y-max: 15,
      x-tick-step: 5,
      y-tick-step: 3,
      x-format: v => [],
      x-label: [],
      y-label: [长度 $L$ (cm)],
      x-grid: true,
      y-grid: true,
      {
        plot.add(
          data,
          style: (stroke: none),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: blue, stroke: blue),
        )
        plot.annotate({
           for x in range(0, 41, step: 5) {
             cetz.draw.content((x, -0.5), [#x], anchor: "north", padding: 0.3)
           }
           cetz.draw.content((20, -2), [质量 $m$ (kg)])
        })
      }
    )
  })
]

2. 假设弹簧的长度 $L$ 与质量 $m$ 之间存在线性关系：
$
  L = a + b dot m
$
根据表格中的数据可知：
$
  sum_(i = 1)^N m_i = 105 \
  sum_(i = 1)^N L_i = 56.92 \
  sum_(i = 1)^N m_i^2 = 2275 \
  sum_(i = 1)^N m_i L_i = 1076.2 \
  sum_(i = 1)^N L_i^2 = 554.6594 \
$
由以上数据可得：
$
  overline(m) &= 1/N sum_(i = 1)^N m_i = 17.5 \
  overline(L) &= 1/N sum_(i = 1)^N L_i = 9.4867 \
  l_(m m) &= sum_(i = 1)^N (m_i - overline(m))^2 = sum_(i = 1)^N m_i^2 - N dot overline(m)^2 = 437.5 \
  l_(m L) &= sum_(i = 1)^N (m_i - overline(m))(L_i - overline(L)) = sum_(i = 1)^N m_i L_i - N dot overline(m) dot overline(L) = 80.0965 \
  l_(L L) &= sum_(i = 1)^N (L_i - overline(L))^2 = sum_(i = 1)^N L_i^2 - N dot overline(L)^2 = 14.6745
$
由此可以计算得到：
$
  hat(b) = (l_(m L))/(l_(m m)) = 80.0965 / 437.5 = 0.1831 \
  hat(a) = overline(L) - b dot overline(m) = 9.4867 - 0.1831 dot 17.5 = 6.2824
$
因此，弹簧的长度与质量之间的线性回归方程为：
$
  hat(L) = 6.2824 + 0.1831 dot m
$
取 $m = 0$ kg, 可得自由状态下的长度为：
$
  L_0 = hat(L)(0) = 6.2824 "cm"
$

弹簧的刚性系数约为 $0.1831$ cm/kg，自由状态下的长度 $L_0$ 约为 $6.2824$ cm。



#pagebreak()
#problem(6.4)[
  在一元线性回归分析中，若规定回归方程必须过坐标系的原点，试建立这一类回归问题的数学模型并推导回归方程系数的计算公式。
]
#SOLUTION

我们知道，一元线性回归模型的一般形式为：
$
  hat(y) = hat(a) + hat(b)x
$
该模型必定过点 $(overline(x), overline(y))$。若要求回归方程过坐标系的原点 $(0, 0)$，则必须有：
$
  (overline(x), overline(y)) = (0, 0)
$
即：
$
  overline(x) = 1/N sum_(i = 1)^N x_i = 0 \
  overline(y) = 1/N sum_(i = 1)^N y_i = 0
$
此时：
$
  l_(x x) &= sum_(i = 1)^N (x_i - overline(x))^2 = sum_(i = 1)^N x_i^2 - N dot overline(x)^2 = sum_(i = 1)^N x_i^2 \
  l_(x y) &= sum_(i = 1)^N (x_i - overline(x))(y_i - overline(y)) = sum_(i = 1)^N x_i y_i - N dot overline(x) dot overline(y) = sum_(i = 1)^N x_i y_i \
  l_(y y) &= sum_(i = 1)^N (y_i - overline(y))^2 = sum_(i = 1)^N y_i^2 - N dot overline(y)^2 = sum_(i = 1)^N y_i^2
$
因此，回归系数的计算公式简化为：
$
  hat(b) &= (l_(x y))/(l_(x x)) = display(sum_(i = 1)^N x_i y_i) / display(sum_(i = 1)^N x_i^2) \
  hat(a) &= hat(y) - hat(b) dot hat(x) = 0
$