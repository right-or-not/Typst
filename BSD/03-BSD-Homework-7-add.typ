#import "@local/zju-typst-tplt:0.2.0": *

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2026-04-17" // 日期，格式为 YYYY-MM-DD
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
#problem(9)[
    对于一个空气介质的平板电容传感器，其中一块极板偏离原位向上平移了 $0.05"mm"$ 后，两极板间的有效重叠面积为 $A = 20"mm"^2$，初始极板间距为 $1.00"mm"$。空气的相对介电常数 $epsilon_r = 1$，真空介电常数 $epsilon_0 = 8.854 times 10^(-12)$F/m。
    1. 请计算该传感器的位移灵敏度 $K$？
    2. 画图讨论该传感器的位移灵敏度的线性的要求和特点。
    #image("image/03-16.png", width: 60%)
]
#SOLUTION

1. *请计算该传感器的位移灵敏度 $K$？*
先计算初始电容 $C_0$：
$ C_0 = (epsilon_0 epsilon_r A)/d_0 = (8.854 times 10^(-12) times 1 times 20 times 10^(-6))/(1 times 10^(-3)) = 0.1771 "pF" $
在极板偏移后，电容 $C$ 为：
$ C = (epsilon_0 epsilon_r A)/(d_0 + d) $
得到：
$ (Delta C)/C_0 = (C - C_0)/C_0 = 1/(1 + d"/"d_0) - 1 approx d/d_0 + (d/d_0)^2 + (d/d_0)^3 + dots $
认为 $d"/"d_0$ 很小，所以可以近似为：
$ (Delta C)/C_0 approx d/d_0 $
因此能够计算得到位移灵敏度 $K$：
$ K = (Delta C)/d approx C_0/d_0 = (epsilon_0 epsilon_r A)/(d_0^2) = 177.1 "pF/m" $
相对位移灵敏度 $K'$ 为：
$ K' = (Delta C"/"C_0)/d approx 1/d_0 = 1000 "m"^(-1) $


2. *画图讨论该传感器的位移灵敏度的线性的要求和特点。* #image("image/03-15.jpg", width: 60%)

    1. 传感器的位移灵敏度的线性的要求: $d"/"d_0 << 1$，可以近似认为曲线是线性的。
    2. 特点：
        - 灵敏度随极板距离增大而减小
        - 具有非线性误差（曲线本来就不是线性的）