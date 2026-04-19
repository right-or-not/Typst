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
    #image("image/03-1.png", width: 80%)
]
#SOLUTION

先计算初始电容 $C_0$：
$ C_0 = (epsilon S_0)/d = (50 times 30 times 20)/10 times 10^(-3) mu"F" = 3 mu"F" $

再计算电容的变化量 $Delta C$：
$ Delta C = (epsilon b Delta x)/d = (50 times 10 times 20)/10 times 10^(-3) mu"F" = 1 mu"F" $

传感器灵敏度 $K$ 为：
$ K = (Delta C)/(Delta x) = (1 mu"F")/(10 "mm") = 0.1 mu"F/mm" $
相对灵敏度 $K'$ 为：
$ K' = (Delta C"/"C_0)/(Delta x) = (1 mu"F/"3 mu"F")/(10 "mm") = 1/30 "mm"^(-1) $


#pagebreak()
#problem(8)[
    参见图 5，以下为电容式液位计的测量原理图。请根据该测量系统画出测量电路图，并要求输出电压 $U_0$ 必须与液位 $h$ 成线性关系。
    #image("image/03-2.png", width: 40%)
]
#SOLUTION

先分析该电容传感器，其初始电容 $C_0$ 为：
$ C_0 = (2pi epsilon H)/(ln(D"/"d)) $
当液位为 $h$ 时，电容 $C$ 为：
$ C = (2pi epsilon_1 h)/(ln(D"/"d)) + (2pi epsilon (H - h))/(ln(D"/"d)) $
可以发现：
$ Delta C = C - C_0 = (2pi (epsilon_1 - epsilon) h)/(ln(D"/"d)) prop h $
因为要求 $U_0 prop h$，所以需要有 $U_0 prop Delta C$。据此设计测量电路，采用双T电桥电路:
#image("image/03-4.jpg", width: 50%)
此时：
$ U_0 = U_i f M Delta C = U_i f (3R^2 R_L)/((R + R_L)^2)  dot (2pi(epsilon_1 - epsilon)h)/ln(D"/"d) prop h $

#pagebreak()
#problem(9)[
    对于一个空气介质的平板电容传感器，其中一块极板偏离原位向上平移了 $0.5"mm"$ 后，两极板间的有效重叠面积为 $20"mm"^2$，极板间距为 $1"mm"$。空气的相对介电常数 $epsilon_r = 1$，真空介电常数 $epsilon_0 = 8.854 times 10^(-12)$F/m。请计算该传感器的位移灵敏度 $K$？
]
#SOLUTION

先计算初始电容 $C_0$：
$ C_0 = (epsilon_0 epsilon_r S)/d_0 = (8.854 times 10^(-12) times 1 times 20 times 10^(-6))/(1 times 10^(-3)) = 0.1771 "pF" $
在极板偏移后，电容 $C$ 为：
$ C = (epsilon_0 epsilon_r S)/(d_0 + d) $
得到：
$ (Delta C)/C_0 = (C - C_0)/C_0 = 1/(1 + d"/"d_0) - 1 approx d/d_0 + (d/d_0)^2 + (d/d_0)^3 + dots $
认为 $d/d_0$ 很小，所以可以近似为：
$ (Delta C)/C_0 approx d/d_0 $
因此能够计算得到位移灵敏度 $K$：
$ K = (Delta C)/d approx C_0/d_0 = (epsilon_0 epsilon_r S)/(d_0^2) = 177.1 "pF/m" $
相对位移灵敏度 $K'$ 为：
$ K' = (Delta C"/"C_0)/d approx 1/d_0 = 1000 "m"^(-1) $


#pagebreak()
#problem(10)[
    请画出压电传感器的两种等效电路。
]
#SOLUTION
1. 等效成为电压源
#image("image/03-5.png", width: 30%)
对应的实际等效电路为：
#image("image/03-6.png", width: 70%)

2. 等效成为电荷源
#image("image/03-7.png", width: 30%)
对应的实际等效电路为：
#image("image/03-8.png", width: 70%)

#pagebreak()
#problem(11)[
    电荷放大器的核心问题是什么？请推导其输入与输出之间的关系。
]
#SOLUTION

1. 电荷放大器的核心问题：消除连接电缆的分布电容（$C_c$）对测量的影响

2. 电荷放大器输入与输出之间的关系：
$ U_o = -A U_i &= -A dot Q/(C_a + C_c + C_i + C'_f) \ &= -A dot Q/(C_a + C_c + C_i + (1 + A)C_f) approx (-A Q)/((1 + A)C_f) approx -Q/C_f $
因此：
$ U_o approx -Q/C_f prop Q $


#pagebreak()
#problem(12)[
    请简述开磁路的磁电感应式传感器的工作原理，并指出其与恒定磁通式（闭磁路）的区别？
]
#SOLUTION

1. 开磁路的磁电感应式传感器的工作原理

线圈和磁铁静止不动，测量齿轮固定在被测旋转体上，齿轮转动过程中会引起磁阻的变化，从而改变磁通量，进而产生感生电动势。也就是磁阻变化 $->$ 磁通变化 $->$ 感生电动势变化，实现对被测旋转体的速度、位移和加速度的测量。

2. 开磁路的磁电感应式传感器和恒定磁通式（闭磁路）磁电传感器的区别
    - *开磁路的磁电感应式传感器*：
        - 磁通量随被测信号变化而变化
        - 输出为脉冲信号
        - 被测物体运动 $->$ 运动磁阻变化 $->$ 磁通变化 $->$ 感生电动势变化
    - *恒定磁通式（闭磁路）的磁电传感器*：
        - 磁通量保持恒定
        - 输出信号为连续模拟电压信号
        - 被测物体运动 $->$ 切割磁感线 $->$ 动生电动势变化


#pagebreak()
#problem(13)[
    请结合电路图解释磁电感应式传感器如何测量速度、位移和加速度。
]
#SOLUTION
1. 测量速度
#image("image/00-2-5-3.png", width: 30%)
磁电感应式传感器，尤其是闭磁路，本身就是一个速度传感器。传感器输出电流表达式如下：
$ I = E/(R + R_f) = (n B_0 L v)/(R + R_f) prop v $
可以通过直接测量负载两端电压，实现对速度的测量：
$ U_o = I R_f = (n B_0 L R_f)/(R + R_f) dot v prop v $

2. 测量位移
因为磁电感应式传感器本身就是一个速度传感器，所以可以通过对输出信号进行积分来实现位移的测量：
#image("image/03-9.png", width: 50%)
$ I_i = U_i/R_i $
$ U_o_2 = 1/C integral I_i "d"t = 1/(C R_i) integral U_i "d"t = 1/(C R_i) integral (n B_0 L R_f)/(R + R_f) dot ("d"x)/("d"t) "d"t = -1/(C R_i) dot (n B_0 L R_f)/(R + R_f) dot x $
也就是：
$ U_o_2 prop x $
实现了对位移 $x$ 的测量。

3. 测量加速度
同样地，可以通过对输出信号进行微分来实现加速度的测量：
#image("image/03-10.png", width: 50%)
$ U_o_2 = -R_o dot I_i = -R_o dot C ("d"u)/("d"t) = -C R_o dot (n B_0 L R_f)/(R + R_f) dot ("d"v)/("d"t) = -C R_o dot (n B_0 L R_f)/(R + R_f) dot a $
也就是：
$ U_o_2 prop a $
实现了对加速度 $a$ 的测量。


#pagebreak()
#problem(14)[
    请描述霍尔传感器的工作原理，并给出响应信号与被测信号之间的数学方程式。
]
#SOLUTION

- 霍尔传感器的工作原理：霍尔效应
当载流导体或半导体处于与电流相垂直的磁场中时，在其两端将产生电位差（霍尔电动势）。

- 响应信号与被测信号之间的数学方程式：
$ F_l = e B v = e dot U_H/b = e dot E_H = F_E $
$ U_H = b B v = b B dot (I)/(n e S) = (B I)/(n e d) $
如果使用霍尔系数 $R_H$，则可以得到：
$ U_H = R_H dot (B I)/d $


#pagebreak()
#problem(15)[
    什么是霍尔传感器的零位误差？如何利用测量电路消除或补偿它？
]
#SOLUTION

1. 霍尔传感器的零位误差：当霍尔元件的激励电流为零时，若元件所处位置磁感应强度为零，则它的霍尔电势应该为零，但实际情况下这个值通常不为零，这时测得的空载霍尔电势称不等位电势，也就是零位误差。

2. 消除或补偿零位误差的方法：在桥臂上并联电阻，如下图所示。
#image("image/00-2-6-2.jpg", width: 90%)



#pagebreak()
#problem(16)[
    霍尔传感器使用时为什么要进行温度误差？请分析下图 6 所示的温度补偿电路的原理？
    #image("image/03-3.png", width: 40%)
]
#SOLUTION

1. 霍尔传感器使用时为什么要进行温度补偿？

霍尔元件是采用半导体材料制成的，它们的许多参数都具有较大的温度系数。当温度变化时，霍尔元件的载流子浓度、迁移率、电阻率及霍尔系数等都将发生变化，从而使霍尔元件产生温度误差。为了保证传感器在不同环境温度下都能提供准确、稳定的测量结果，需要进行温度补偿。

2. 温度补偿电路的原理：

霍尔元件的灵敏系数 $K_H$ 是温度的函数,它随温度的变化引起霍尔电势的变化:
$ K_(H) = K_(H_0) (1 + alpha Delta T) $
先选定 $T = T_0$，此时 $K_H = K_(H_0)$, $Delta T = 0$，则有：
$ I_H_0 = (R_P_0 I_s)/(R_P_0 + R_i_0) $
其中，旁路电阻 $R_P$ 和 输入电阻 $R_i$ 都是温度的函数：
$ R_P = R_P_0 (1 + beta Delta T) $
$ R_i = R_i_0 (1 + delta Delta T) $
代入后可以得到：
$ I_H = (R_P I_s)/(R_P + R_i) = (R_P_0 (1 + beta Delta T) I_s)/(R_P_0 (1 + beta Delta T) + R_i_0 (1 + delta Delta T)) $
由于需要实现温度补偿，也就是:
$ U_H = K_H I_H B = K_(H_0) I_H_0 B = U_H_0 $
即：
$ K_H I_H = K_(H_0) I_H_0 $
代入可以计算得到：
$ R_P_0 approx (delta - beta - alpha)/alpha dot R_I_0 $
也就是说，只要选取合适的旁路电阻 $R_P$ 就可以实现温度补偿，使得输出电压 $U_H$ 不受温度变化的影响。当霍尔元件的输入电阻随温度升高而增加时，旁路分流电阻 $R_P$ 自动地加强分流，减少了霍尔元件的激励电流 $I$ ，从而达到补偿的目的。