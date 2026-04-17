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
#problem(7)[
    参见图 4，对于一个变面积式电容传感器，极板间距为 $10$mm，介电常数 $epsilon = 50mu$F/m。两块极板形状相同，尺寸为 $30"mm" times 20"mm" times 5"mm"$。在受到外力作用下，动极板向左移动了 $10$mm。请计算电容的变化量 $Delta C$ 以及传感器的灵敏度 $K$？
    #image("image/03-1.png", width: 40%)
]
#SOLUTION



#pagebreak()
#problem(8)[
    参见图 5，以下为电容式液位计的测量原理图。请根据该测量系统画出测量电路图，并要求输出电压 U_0 必须与液位 $h$ 成线性关系。
    #image("image/03-2.png", width: 40%)
]
#SOLUTION


#pagebreak()
#problem(9)[
    对于一个空气介质的平板电容传感器，一块极板偏离原位移动了 $15$mm。两极板间的有效重叠面积为 $20"mm"^2$，极板间距为 $1"mm"$。空气的相对介电常数 $epsilon_r = 1$，真空介电常数 $epsilon_0 = 8.854 times 10^{-12}$F/m。请计算该传感器的位移灵敏度 $K$？
]
#SOLUTION



#pagebreak()
#problem(10)[
    请画出电压传感器的两种等效电路。
]
#SOLUTION


#pagebreak()
#problem(11)[
    电荷放大器的核心问题是什么？请推导其输入与输出之间的关系。
]
#SOLUTION


#pagebreak()
#problem(12)[
    请简述开磁路的磁电感应式传感器的工作原理，并指出其与恒定磁通式（闭磁路）的区别？
]
#SOLUTION


#pagebreak()
#problem(13)[
    请结合电路图解释磁电感应式传感器如何测量速度、位移和加速度。
]
#SOLUTION



#pagebreak()
#problem(14)[
    请描述霍尔传感器的工作原理，并给出响应信号与被测信号之间的数学方程式。
]
#SOLUTION



#pagebreak()
#problem(15)[
    什么是霍尔传感器的零位误差？如何利用测量电路消除或补偿它？
]
#SOLUTION



#pagebreak()
#problem(16)[
    霍尔传感器使用时为什么要进行温度误差 ？请分析下图 6 所示的温度补偿电路的原理？
    #image("image/03-3.png", width: 40%)
]
#SOLUTION
