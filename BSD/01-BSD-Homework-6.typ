#import "@local/zju-typst-tplt:0.2.0": *

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2026-04-10" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Sensing and Detection" // 课程名称
#let proj-name = "Exercises for Chapter 3" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
    first-line-indent-all: true,
)

#set par(first-line-indent: 2em)


// ==================== 正文内容 ==================== //
#problem(1)[
  图1为一直流应变电桥，其中 $E = 4"V", R_1 = R_2 = R_3 = R_4 = 120Omega$。请回答以下问题：
  1. 如果 $R_1$ 为金属应变片，其余为外接电阻，当 $R_1$ 的增量为 $Delta R_1 = 1.2Omega$ 时，输出电压 $U_0$ 是多少？
  2. 如果 $R_1, R_2$ 为同批号的应变片，能感受相同方向和大小的应变，其余为外接电阻。输出电压 $U_0$ 是多少？
  3. 在问题（2）中，如果 $R_1, R_2,$ 感受相反方向的应变，且 $abs(Delta R_1) = abs(Delta R_2) = 1.2Omega$，输出电压 $U_0$ 是多少？
]
#SOLUTION




#pagebreak()
#problem(2)[
  图2为一等强度梁测力系统。$R_1$ 为电阻应变片，其灵敏度系数 $K = 2.05$。无应变时 $R_1 = 120Omega$。受力 $F$ 时应变片的平均应变 $epsilon = 800 mu"m/m"$（即 $800mu epsilon$），则：
  1. 应变片电阻的变化量 $Delta R_1$ 是多少？电阻相对变化量 $Delta R_1 "/" R_1$ 是多少？
  2. 若将该电阻应变片 $R_1$ 接入单臂电桥，供电电压为直流 3V，电桥的输出电压和非线性误差是多少？
  3. 减小非线性误差的措施是什么？分析该电桥的输出电压和非线性误差。
]
#SOLUTION




#pagebreak()
#problem(3)[
  变气隙式电感传感器的输出特性与哪些因素有关？如何改善其非线性？如何提高其灵敏度？
]
#SOLUTION





#pagebreak()
#problem(4)[
  请简述相敏检波器的工作原理。保证其可靠工作的条件是什么？
]
#SOLUTION




#pagebreak()
#problem(5)[
  参见教材图3.3.1，已知气隙电感传感器的截面积 $S = 1.5"cm"^2$，磁路长度 $L = 20"cm"$，相对磁导率 $\mu_r = 5000$，气隙 $delta_0 = 0.5"cm"$，$Delta delta = plus.minus 0.1"mm"$，真空磁导率 $mu_0 = 4pi times 10^(-7) "H/m"$，线圈匝数 $W = 3000$。请问单端传感器的灵敏度 $Delta L "/" Delta delta$ 是多少？如果做成差动形式，传感器的灵敏度将如何变化？
]
#SOLUTION




#pagebreak()
#problem(6)[
  什么是电涡流效应？如何利用它来测量位移？
]
#SOLUTION