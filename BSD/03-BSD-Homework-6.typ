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
  #image("./image/02-1.png", width: 40%)
]
#SOLUTION

$
  U_o = E times (R_2/(R_1 + R_2) - R_4/(R_3 + R_4))
$

1. $R_1 -> R_1 + Delta R_1$，可以计算得到输出电压为：
$
  U_o 
  &= E dot (R_2/(R_1 + Delta R_1 + R_2) - R_4/(R_3 + R_4)) \ \
  &= 3 times (120/(120 + 1.2 + 120) - 120/(120 + 120)) "V"\ \
  &= -9.95"mV"
$

2. $R_1 -> R_1 + Delta R_1, R_2 -> R_2 + Delta R_2, Delta R_1 = Delta R_2$，可以计算得到输出电压为：
$
  U_o 
  &= E dot [(R_2 + Delta R_2)/(R_1 + Delta R_1 + R_2 + Delta R_2) - R_4/(R_3 + R_4)] \ \
  &= 3 times [(120 + 1.2)/(120 + 1.2 + 120 + 1.2) - 120/(120 + 120)] "V"\ \
  &= 0
$

3. $R_1 -> R_1 + Delta R_1, R_2 -> R_2 - Delta R_2, abs(Delta R_1) = abs(Delta R_2)$，可以计算得到输出电压为：
$
  U_o
  &= E dot [(R_2 - Delta R_2)/(R_1 + Delta R_1 + R_2 - Delta R_2) - R_4/(R_3 + R_4)] \ \
  &= 3 times [(120 - 1.2)/(120 + 1.2 + 120 - 1.2) - 120/(120 + 120)] "V"\ \
  &= -0.02"V" = -20"mV"
$




#pagebreak()
#problem(2)[
  图2为一等强度梁测力系统。$R_1$ 为电阻应变片，其灵敏度系数 $K = 2.05$。无应变时 $R_1 = 120Omega$。受力 $F$ 时应变片的平均应变 $epsilon = 800 mu"m/m"$（即 $800mu epsilon$），则：
  1. 应变片电阻的变化量 $Delta R_1$ 是多少？电阻相对变化量 $Delta R_1 "/" R_1$ 是多少？
  2. 若将该电阻应变片 $R_1$ 接入单臂电桥，供电电压为直流 3V，电桥的输出电压和非线性误差是多少？
  3. 减小非线性误差的措施是什么？分析该电桥的输出电压和非线性误差。
  #image("image/02-2.png", width: 40%)
]
#SOLUTION

1. 可以先计算电阻相对变化量 $Delta R_1"/"R_1$：
$
  (Delta R_1)/R_1 = K dot epsilon = 2.05 times 800 mu epsilon = 0.00164
$
由于 $R_1 = 120 Omega$，可以计算得到电阻变化量 $Delta R_1$：
$
  Delta R_1 = (Delta R_1)/R_1 times R_1 = 0.00164 times 120 Omega = 0.1968 Omega
$

2. 假设单臂电桥的 $R_1 = R_2 = R_3 = R_4 = 120 Omega$，则输出电压为：
$
  U_o = E times ((R_1)/(R_1 + R_2) - R_3/(R_3 + R_4))
$
代入 $R_1 -> R_1 + Delta R_1$ 得，电桥实际输出电压 $U'_o$ 为：
$
  U'_o 
  &= E times ((R_1 + Delta R_1)/(R_1 + Delta R_1 + R_2) - R_3/(R_3 + R_4)) \ \
  &= 3 times ((120 + 0.1968)/(120 + 0.1968 + 120) - 120/(120 + 120)) "V" \ \
  &= 0.001229"V" = 1.229"mV"
$
电桥输出电压的理论值 $U_o$ 为：
$
  U_o = E/4 dot (Delta R_1)/R_1 = 3/4 times 0.00164 "V" = 0.00123"V" = 1.23"mV"
$
非线性误差 $gamma$ 可以计算得到：
$
  gamma = (U_o - U'_o)/U_o times 100% = (1.23"mV" - 1.229"mV")/1.23"mV" times 100% approx 0.08%
$


3. 减小非线性误差的措施为：使用差动电桥结构，接下来使用差动半桥实现。差动半桥的输出电压 $U''_o$ 为：
$
  U'_o 
  &= E dot [(R_1 + Delta R_1)/(R_1 + Delta R_1 + R_2 - Delta R_2) - (R_3)/(R_3 + R_4)] \ \
  &= 3 times ((120 + 0.1968)/(120 + 0.1968 + 120 - 0.1968) - 120/(120 + 120)) "V" \ \
  &= 0.00246"V" = 2.46"mV"
$
理论输出为：
$
  U_o = E/2 dot (Delta R_1)/R_1 = 3/2 times 0.00164 "V" = 0.00246"V" = 2.46"mV"
$
非线性误差 $gamma$ 为：
$
  gamma = (U_o - U'_o)/U_o times 100% = (2.46 - 2.46)/2.46 times 100% = 0
$

#pagebreak()
#problem(3)[
  变气隙式电感传感器的输出特性与哪些因素有关？如何改善其非线性？如何提高其灵敏度？
]
#SOLUTION

1. 变气隙式电感传感器的电感计算公式为：
$
  L = (omega^2)/R_m = (omega^2 mu_0 S_0)/(2delta)
$
因此，变气隙式电感传感器的输出特性与线圈匝数 $omega$、真空磁导率 $mu_0$、截面积 $S_0$ 和气隙厚度 $delta$ 有关。

2. 改善非线性，可以采用差动变气隙式电感传感器。

3. 变气隙式电感传感器的灵敏度 $K$ 为：
$
  K = (Delta L"/"L_0)/(Delta delta) = 1/delta_0
$
差动变气隙式电感传感器的灵敏度为：
$
  K = (Delta L"/"L_0)/(Delta delta) = 2/delta_0
$
因此，提高灵敏度可以采用以下方法：
- 减小初始气隙 $delta_0$
- 采用差动结构



#pagebreak()
#problem(4)[
  请简述相敏检波器的工作原理。保证其可靠工作的条件是什么？
]
#SOLUTION

1. 相敏检波器使用环形电桥将差动整流电路的输出 $u_2(t)$ 和参考信号 $u_0(t)$ 进行比较，输出信号 $u_L (t)$ 的幅值与两者的相位差有关。
$
  u_L (t) = (u_2)/(n_1 (R_1 + 2R_L)) dot R_L dot cos(phi) prop u_2 dot cos(phi)
$
- 当 $u_1(t)$ 和 $u_2(t)$ 同相时，$cos(phi) = 1$，输出信号最大；
- 当两者反相时，$cos(phi) = -1$，输出信号最小。

因此，相敏检波器可以通过比较输入信号 $u_2(t)$ 和参考信号 $u_0(t)$ 的相位关系来提取有用信号，从而实现 $u_L$ 和被测位移 $Delta x$ 之间的线性关系。

2. *相敏检波器可靠工作的条件：*
- *频率同步*：参考信号 $u_0(t)$ 的频率 $omega_0$ 与输入信号 $u_2(t)$ 的频率 $omega_2$ 需要严格一致，也就是 $omega_0 = omega_2$
- *相位同步*：参考信号 $u_0(t)$ 和输入信号 $u_2(t)$ 的相位差 $phi$ 需要保持恒定
- *低通滤波器性能足够好*：低通滤波器的截止频率需要远低于载波频率 $omega_1$，也要高于被测量的频率 $omega_2$
- 载波频率足够高：载波频率 $omega_1$ 需要远高于被测量的频率 $omega_2$，以确保输出信号 $u_L$ 中的交流分量可以被有效滤除。

#pagebreak()
#problem(5)[
  已知气隙电感传感器的截面积 $S = 1.5"cm"^2$，磁路长度 $L = 20"cm"$，相对磁导率 $mu_r = 5000$，气隙 $delta_0 = 0.5"cm"$，$Delta delta = plus.minus 0.1"mm"$，真空磁导率 $mu_0 = 4pi times 10^(-7) "H/m"$，线圈匝数 $W = 3000$。请问单端传感器的灵敏度 $Delta L "/" Delta delta$ 是多少？如果做成差动形式，传感器的灵敏度将如何变化？
]
#SOLUTION
1. 单端传感器的电感 $L$ 可以计算得到：
$
  L = (omega^2)/R_m = (omega^2 mu_0 S)/(2 delta_0)
$
对于单端传感器有：
$
  (Delta L)/L_0 = (Delta delta)/delta_0
$
因此，单端传感器的灵敏度 $Delta L "/" Delta delta$ 为：
$
  (Delta L)/(Delta delta) = L_0/delta_0 = (omega^2 mu_0 S)/(2 delta_0^2)
$
代入数值计算得到：
$
  (Delta L)/(Delta delta) = (3000^2 times 4pi times 10^(-7) times 1.5 times 10^(-4))/(2 times (0.5 times 10^(-2))^2) "H/m" = 33.93 "H/m"
$

2. 差动传感器的灵敏度为单端传感器的两倍，因此差动传感器的灵敏度为：
$
  (Delta L)/(Delta delta) = 2 times 33.93 "H/m" = 67.86 "H/m"
$



#pagebreak()
#problem(6)[
  什么是电涡流效应？如何利用它来测量位移？
]
#SOLUTION

1. *什么是电涡流效应？*

根据法拉第电磁感应原理，块状金属导体置于变化的磁场中或在磁场中作切割磁力线运动时，导体内将产生漩涡状的感应电流，此电流叫电涡流，以上现象称为电涡流效应。

2. *如何利用电涡流效应来测量位移？*

在测量位移 $x$ 的时候，我们将传感器线圈和被测导体组成线圈 — 导体系统。当传感器线圈输入交流电压时，被测金属导体表面会产生感应电涡流，此电涡流会产生交变磁场，导致传感器线圈的等效阻抗发生变化。传感器线圈受电涡流影响时的等效阻抗 $Z$ 的函数关系式为：
$
  Z = F(rho, mu, r, f, x)
$
保持电阻率 $rho$、磁导率 $mu$、半径 $r$ 和频率 $f$ 不变，传感器线圈的等效阻抗 $Z$ 就是位移 $x$ 的函数，即可实现对位移 $x$ 的测量。
