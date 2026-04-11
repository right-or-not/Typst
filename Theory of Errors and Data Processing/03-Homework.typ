#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-12-02" // 日期，格式为 YYYY-MM-DD
#let course = "误差理论与数据处理" // 课程名称
#let proj-name = "Exercise for Chapter 3" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

// mean
#let cal_mean(data, num) = {
  let n = data.len()
  let mean = data.sum() / n
  calc.round(mean, digits: num)
}

// sig
#let cal_sig(data, num) = {
  let n = data.len()
  let mean = data.sum() / n
  let var = data.map(v => (v - mean) * (v - mean)).sum() / (n - 1)
  let sig = calc.sqrt(var)
  calc.round(sig, digits: num)
}

// sig_mean
#let cal_sig_mean(data, num) = {
  let n = data.len()
  let mean = data.sum() / n
  let var = data.map(v => (v - mean) * (v - mean)).sum() / ((n - 1) * n)
  let sig = calc.sqrt(var)
  calc.round(sig, digits: num)
}

// mean_quan
#let cal_mean_quan(data, quan, num) = {
  let n = data.len()
  let sum_quan = quan.sum()
  let data_sum = {
    let sum = 0.0
    for i in range(n) {
      sum += data.at(i) * quan.at(i)
    }
    sum
  }
  calc.round(data_sum / sum_quan, digits: num)
}

// sig_quan
#let cal_sig_quan(data, quan, num) = {
  let n = data.len()
  let sum_quan = quan.sum()
  let data_sum = 0.0
  for i in range(n) {
    data_sum += data.at(i) * quan.at(i)
  }
  let mean = data_sum / sum_quan
  let var = 0.0
  for i in range(n) {
    var += calc.pow(data.at(i) - mean, 2) * quan.at(i)
  }
  var = var / (n - 1)
  calc.round(calc.sqrt(var), digits: num)
}


// sig_mean_quan
#let cal_sig_mean_quan(data, quan, num) = {
  let n = data.len()
  let sum_quan = quan.sum()
  let data_sum = 0.0
  for i in range(n) {
    data_sum += data.at(i) * quan.at(i)
  }
  let mean = data_sum / sum_quan
  let var = 0.0
  for i in range(n) {
    var += calc.pow(data.at(i) - mean, 2) * quan.at(i)
  }
  var = var / (sum_quan * (n - 1))
  calc.round(calc.sqrt(var), digits: num)
}


#let a = 161.6
#let b = 44.5
#let c = 11.2
#let Delta_a = 1.2
#let Delta_b = -0.8
#let Delta_c = 0.5
#let delta_a = 0.8
#let delta_b = 0.5
#let delta_c = 0.5
#let V_0 = calc.round(a*b*c, digits: 2)
#let Delta_V = calc.round(b * c * Delta_a + a * c * Delta_b + a * b * Delta_c, digits: 4)
#let delta_V = calc.round(calc.sqrt(calc.pow(b * c * delta_a, 2) + calc.pow(a * c * delta_b, 2) + calc.pow(a * b * delta_c, 2)), digits: 4)
#problem(3.2)[
  为求长方体体积 $V$，直接测量其各边长为 $a = #a$mm，$b = #b$mm，$c = #c$mm，已知测量的系统误差为 $Delta a = #Delta_a$mm，$Delta b = #Delta_b$mm，$Delta c = #Delta_c$mm，测量的极限误差为 $delta_a = plus.minus#delta_a$mm，$delta_b = plus.minus#delta_b$mm，$delta_c = plus.minus#delta_c$mm，试求立方体的体积及其体积的极限误差。
]
#SOLUTION

首先，写出长方体体积 $V$ 的计算公式：
$
  V = a dot b dot c
$
由此可知：
$
  (partial V)/(partial a) = b c", "
  (partial V)/(partial b) = a c", "
  (partial V)/(partial c) = a b 
$
不考虑系统误差和随机误差，可以写出长方体体积 $V$ 的测量值：
$
  V_0 = a dot b dot c = #{V_0}"mm"^3
$
系统误差 $Delta V$ 为：
$
  Delta V 
  &= (partial V)/(partial a) dot Delta a + (partial V)/(partial b) dot Delta b + (partial V)/(partial c) dot Delta c \
  &= b c dot Delta a + a c dot Delta b + a b dot Delta c 
  = #{Delta_V}"mm"^3
$
极限误差 $delta_(lim V)$ 为：
$
  delta_(lim V) 
  &= plus.minus sqrt(((partial V)/(partial a) dot delta_a)^2 + ((partial V)/(partial b) dot delta_b)^2 + ((partial V)/(partial c) dot delta_c)^2) \
  &= plus.minus sqrt((b c dot delta_a)^2 + (a c dot delta_b)^2 + (a b dot delta_c)^2)\
  &= plus.minus#{delta_V}"mm"^3
$
综上，立方体的体积为：
$
  V = V_0 - Delta V plus.minus delta_(lim V) 
  &= #{V_0 - Delta_V} plus.minus #{delta_V} ("mm"^3) \
  &= 77795.70 plus.minus 3729.11 ("mm"^3) 
$




#let I = 22.5
#let U = 12.6
#let sigma_I = 0.5
#let sigma_U = 0.1
#let P = calc.round(I * U, digits: 10)
#let sigma_P = calc.round(U * sigma_I + I * sigma_U, digits: 4)
#pagebreak()
#problem(3.4)[
  测量某电路的电流 $I = #I$mA，电压 $U = #U$V，测量的标准差分别为 $sigma_I = #sigma_I$mA，$sigma_U = #sigma_U$V，求所消耗的功率 $P = U I$ 及其标准差 $sigma_P$。
]
#SOLUTION

根据功率的计算公式：
$
  P = U I
$
可得：
$
  (partial P)/(partial I) = U", "
  (partial P)/(partial U) = I
$
由于题目假设不存在系统误差，因此功率 $P$ 可以直接按照公式计算，即：
$
  P = U dot I = #P"mW"
$
因为电流电压满足：
$
  U = R dot I
$
所以 $U$ 和 $I$ 之间的线性相关系数为：
$
  rho = ("Cov"(U, I))/(sqrt("Var"(U)) dot sqrt("Var"(I))) = ("Cov"(R I, I))/(sqrt("Var"(R I)) dot sqrt("Var"(I))) = 1
$

其标准差计算如下：
$
  sigma_P 
  &= sqrt(((partial P)/(partial I) dot sigma_I)^2 + ((partial P)/(partial U) dot sigma_U)^2 + 2 dot (partial P)/(partial I)(partial P)/(partial U) dot sigma_I sigma_U ) \
  &= (partial P)/(partial I)dot sigma_I + (partial P)/(partial U)dot sigma_U = #sigma_P"mW"
$






#pagebreak()
#problem(3.6)[
  已知 $x$ 和 $y$ 的相关系数 $rho_(x y) = -1$，试求 $u = x^2 + a y$ 的方差 $sigma_u^2$。
]
#SOLUTION

由题意得：
$
  (partial u)/(partial x) = 2x", " (partial u)/(partial y) = a
$
所以可以得到 $u$ 的方差：
$
  sigma_u^2 
  &= ((partial u)/(partial x)dot sigma_x)^2 + ((partial u)/(partial y)dot sigma_y)^2 + 2  rho_(x y) dot (partial u)/(partial x) (partial u)/(partial y) dot sigma_x sigma_y \
  &= (2x dot sigma_x)^2 + (a dot sigma_y)^2 -2 dot (2a x) dot sigma_x sigma_y \
  &= (2x dot sigma_x - a dot sigma_y)^2
$








#pagebreak()
#problem(3.7)[
  通过电流表的电流 $I$，与指针偏转角 $phi$ 服从下列关系：
  $
    I = C dot tan(phi)
  $
  式中 $C$ 为决定于仪表结构的常数，$C = 5.031 times 10^(-7)"A"$，两次测得 $phi_1 = 6 degree 17' plus.minus 1'$、$phi_2 = 43 degree 32' plus.minus 1'$。试求两种情况下的 $I_1$、$I_2$ 及其极限误差，并分析最佳测量方案。
]
#SOLUTION

由题意得：
$
  "d"I = "d"(C dot tan(phi)) = C dot ("d"phi)/(cos^2(phi))
$
即有：
$
  (partial I)/(partial phi) = ("d" I)/("d" phi) = C/(cos^2(phi))
$
由此可以推出标准差的计算关系：
$
  sigma_I = sqrt(((partial I)/(partial phi))^2 dot sigma_phi^2) = (partial I)/(partial phi) dot sigma_phi = (C dot sigma_phi)/(cos^2(phi))
$
对于极限误差 $delta_(lim) = t dot sigma$，我们取 $t = 3$，这样所有的 $t$ 都能够约掉，即：
$
  delta_(lim I) = (C dot delta_(lim phi))/(cos^2(phi))
$
*(1)* 取第一种情况 $phi_1 = 6 degree 17' plus.minus 1'$，此时：
$
  I_1 = C dot tan(phi_1) = 5.539 times 10^(-8)"A" \
  delta_(lim I_1) = (C dot delta_(lim phi_1))/(cos^2(phi_1)) = plus.minus 1.481 times 10^(-10)"A"
$
*(2)* 取第二种情况 $phi_2 = 43 degree 32' plus.minus 1'$，此时：
$
  I_2 = C dot tan(phi_2) = 4.780 times 10^(-7)"A" \
  delta_(lim I_2) = (C dot delta_(lim phi_2))/(cos^2(phi_2)) = plus.minus 2.784 times 10^(-10)"A"
$
由公式：
$
  delta_(lim I) = (C dot delta_(lim phi))/(cos^2(phi))
$
可知：$delta_(lim phi)$、$C$ 等参数均与仪表相关，因此在使用同一仪表测量的时候 $delta_(lim I)$ 仅与 $phi$ 有关，$cos(phi)$ 的值越大，极限误差 $delta_(lim I)$ 越小。











#pagebreak()
#problem(3.11)[
  测量某电路电阻 $R$ 两端的电压降 $U$，可由公式 $I = U"/"R$ 计算出电路电流 $I$。若电压降为 16V，电阻为 4$Omega$，欲使电流的极限误差为 0.04A，试决定电阻 $R$ 和电压降 $U$ 的测量误差是多少？
]
#SOLUTION

由题意得：
$
  (partial I)/(partial U) = 1/R", " (partial I)/(partial R) = -(U)/(R^2)
$
电阻 $R$ 的测量误差为：
$
  delta_R = (delta_(lim I))/(sqrt(2) dot (partial I)/(partial R)) = - (delta_(lim I))/(sqrt(2)) dot (R^2)/U = -0.028 Omega
$
电压 $U$ 的测量误差为：
$
  delta_U = (delta_(lim I))/(sqrt(2) dot (partial I)/(partial U)) = (delta_(lim I))/(sqrt(2)) dot R = 0.113"V" approx 0.11"V"
$







#pagebreak()
#problem(3.12)[
  按公式 $V = pi r^2 h$ 求圆柱体体积，若已知 $r$ 为 2cm，$h$ 为 20cm，要使体积的相对误差等于 1%，试问 $r$ 和 $h$ 测量时误差应为多少？
]
#SOLUTION

按照公式可得体积 $V$ 为：
$
  V = pi r^2 h = 251.3"cm"^3
$
计算得到测量体积的误差为：
$
  delta_V = 1% times V = 2.513"cm"^3
$
由公式可得：
$
  (partial V)/(partial r) = 2pi r h", " (partial V)/(partial h) = pi r^2
$
*(1)* 半径 $r$ 的测量误差为：
$
  delta_r = (delta_V)/(sqrt(2) dot (partial V)/(partial r)) = (delta_V)/(sqrt(2)) dot 1/(2 pi r h) = 7.07 times 10^(-3)"cm"
$
*(2)* 高度 $h$ 的测量误差为：
$
  delta_h = (delta_V)/(sqrt(2) dot (partial V)/(partial h)) = (delta_V)/(sqrt(2)) dot 1/(pi r^2) = 0.1414"cm"
$
