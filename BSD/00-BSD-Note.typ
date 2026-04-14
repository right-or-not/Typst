#import "@local/zju-typst-tplt:0.2.0": *

#show: BL

// information for notes
#let ymd = "2026-03-26"
#let course = "Biomedical Sensing and Detection"
#let proj-name = "Notes for Course"

// Homework template for note
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
    first-line-indent-all: true,
)

#set par(first-line-indent: 2em)

= 绪论

== 生物医学传感（传感器）

== 生物医学检测技术


#pagebreak()
// :========== Part 2 ==========: //
= 生物医学传感与检测技术基础

== 传感器特性
- *传感器的基本特性：传感器的输入 - 输出关系特性。*
- *传感器特性是传感器内部结构参数作用关系的外部表现。*
- *传感器特性能够判断该传感器能否不失真地反映输入信号。*
- *静态特性*: 测量 $=>$ 静态 or 稳态 or 瞬态效应稳定到最终
- *动态特性*: 测量 $=>$ 瞬态 or 传感器对随时间变化的输入信号的响应特性

=== 静态特性
1. *灵敏度*
$ K = (Delta Y)/(Delta X) = ("d"Y)/("d"X) $
2. *分辨率*
    - 传感器能够感知或检测到的最小输入信号增量
$ "Resolution" = Delta Y_("min") $
$ "Resolution" = (Delta Y_("min"))/(Y_("F.S.")) times 100% $
3. *线性度*
    - 传感器的标定曲线与指定直线（理论曲线 / 最小二乘）之间的接近程度
$ epsilon = plus.minus (Delta Y_("max"))/(Y_("F.S.")) times 100% $
4. *迟滞*
    - 在相同测量条件下，对应于同一大小的输入信号，传感器正、反行程的输出信号大小不相等的现象
$ delta_H = plus.minus (Delta H_"max")/(Y_"F.S.") times 100% $
5. *重复性*
    - 传感器在输入量按同一方向作全量程多次测试时所得输入－输出特性曲线一致的程度
$ delta_K = plus.minus (Delta H_"max")/(Y_"F.S.") times 100% = plus.minus (max(Delta H_"1max", Delta H_"2max"))/(Y_"F.S.") times 100% $
6. *漂移*
    - 传感器在输入量不变的情况下，输出量随时间变化的现象
    - 零点漂移：传感器自身结构参数老化
    - 温度漂移：测试过程中环境发生变化

=== 动态特性
+ *零阶传感器*
    $ a_0 y(t) = b_0 x(t) $
    - 线性度 $K$
    $ H(s) = (b_0)/(a_0) = K $
    

+ *一阶传感器* 
    $ a_1 ("d"y(t))/("d"t) + a_0 y(t) = b_0 x(t) $
    - 线性度 $K$
    - 时间常数 $tau$
    $ H(s) = (b_0)/(a_1 s + a_0) = (K)/(tau s + 1) $

+ *二阶传感器* 
    $ a_2 ("d"^2 y(t))/("d"t^2) + a_1 ("d"y(t))/("d"t) + a_0 y(t) = b_0 x(t) $ 
    - 线性度 $K$
    - 自然频率 $omega_0$
    - 阻尼比 $xi$
    $ H(s) = (b_0)/(a_2 s^2 + a_1 s + a_0) = (omega_0^2 K)/(s^2 + 2xi omega_0 s + omega_0^2) $
    - 上升时间 $t_r$ : 稳态值从10%上升到90%所需的时间。
    - 响应时间 $t_s$ : 输出响应在 $plus.minus Delta %$ 误差容限内保持稳定所需的时间。
    - 过冲 $alpha$ : 最大输出超过稳态值的值。
    - 延迟时间 $t_o$ : 输出首次达到稳态值的 $50%$ 所需的时间。
    - 衰减 $psi$ : 相邻两个峰值（或波谷）之间高度下降的百分比，$psi = (alpha - alpha_1)"/"alpha times 100%$


== 传感检测技术
=== 检测方法
- *直接检测 & 间接检测*
    - 直接测量方法使用仪器的输出作为结果
    - 间接测量方法使用某些测量参数的计算结果作为最终结果
- *主动检测 & 被动检测*
    - 主动检测方法需要从外部向被检测对象施加能量
    - 被动检测方法不需要从外部向被检测对象施加能量
- *侵入式检测 & 非侵入式检测*
- *有线检测 & 无线检测*

=== 检测系统
#image("./image/00-2-2-2.png", width: 90%)
- 参量转换电路
- 阻抗匹配电路
- 微弱信号放大电路
- 调制解调电路
- 模拟滤波器电路
- DAC 和 ADC 接口电路
- 数字信号处理

=== 信号调制、解调
。。。

=== 传感检测系统改进
- 选择合适的传感器（针对时间老化、温度老化、机械老化等）
- 稳定化技术（针对时间老化、温度老化、机械老化等）
- 线性化技术（差动技术￿：正反行程误差偏大、偏小的“中和”效应，改善灵敏度、非线性）
- 平均技术（针对时间老化、温度老化、机械老化等）
- 屏蔽、隔离与干扰抑制（针对恶劣的电磁、温度、湿度、机械振动、气压、声压、辐射、气流等工作环境；光电隔离/变压器隔离/继电器隔离/布线隔离；接地技术)

== 生物相容性设计

== 生物医学传感器的微制造




#pagebreak()
// :========== Part 3 ==========: //
= 物理量传感器及应用

== 电阻传感器与测量
=== 电阻传感器
#strong[$ R = (rho L)/S $]
$ ("d"R)/R = ("d"rho)/rho + ("d"L)/L - ("d"S)/S $
#strong[$ epsilon := (Delta L)/L $]
$ (Delta S)/S = (2Delta r)/r  = -2mu dot (Delta L)/L = -2mu epsilon $
#strong[$ (Delta R)/R = K dot (Delta L)/L = K dot epsilon $]
$ (Delta R)/R = K dot epsilon = (1 + 2mu) dot epsilon + (Delta rho)/rho $

- *金属电阻应变计*
$ K = ("d"R"/"R)/("d"L"/"L) = (1 + 2mu) + (Delta rho"/"rho)/epsilon approx 1 + 2mu $
#strong[$ epsilon = (sigma)/(E) = ("应力")/("弹性模量") = F/(S E) $]
$ (Delta R)/R = K dot epsilon = K dot F/(S E) = K/(S E)dot F prop F $

- *半导体电阻应变计*
$ K = ("d"R"/"R)/("d"L"/"L) = (1 + 2mu) + (Delta rho"/"rho)/epsilon approx (Delta rho"/"rho)/epsilon $
#strong[$ (Delta rho)/rho = pi sigma = pi E epsilon = "压阻系数" dot "弹性模量" dot "应变" $]
$ K approx (Delta rho"/"rho)/epsilon = pi E $

=== 测量电路
- 电桥调零配平
$ n := R_2/R_1 = R_4/R_3 $
- 电桥输出公式
$ U_o = E dot (R_1/(R_1 + R_2) - R_3/(R_3 + R_4)) $

==== 直流电桥
#strong[$ R_1 -> R_1 + Delta R_1 $]
$ Delta U_o = E dot ((R_1 + Delta R_1)/(R_1 + Delta R_1 + R_2) - R_3/(R_3 + R_4)) $
$ Delta U_o = E dot (Delta R_1"/"R_1 dot R_4"/"R_3)/((1 + Delta R_1"/"R_1 + R_2"/"R_1) dot (1 + R_4"/"R_3)) $
$ Delta U_o = E dot (n)/((1 + Delta R_1"/"R_1 + n) dot (1 + n)) dot (Delta R_1)/R_1 approx E dot n/((1 + n)^2) dot (Delta R_1)/R_1 $
- 灵敏度 $K$
$ K = U_o/(Delta R_1"/"R_1) = E dot n/((1 + n)^2) $
- 求最佳灵敏度 $K_("max")$
$ ("d"K)/("d"n) = E dot (1-n)/((1+n)^3) = 0 $
$ n = 1 $
$ Delta U_o = E/4 dot (Delta R_1)/R_1 $
$ K = E/4 $
- *直流电桥存在非线性误差，为了减少和消除非线性误差，通常使用差动电桥！*

==== 差动电桥
- *差动半桥*
$ Delta U_o = E/2 dot (Delta R_1)/R_1 $
$ K = E/2 $ 

- *差动全桥*
$ Delta U_o = E dot (Delta R_1)/R_1 $
$ K = E $


== 电感传感器与测量
=== 变磁阻式传感器
- 真空磁导率 $mu_0$
- 线圈匝数 $omega$
- 磁阻 $R_m$
$ R_m = L_1/(mu_1 S_1) + L_2/(mu_2 S_2) + (2delta)/(mu_0 S_0) approx (2delta)/(mu_0 S_0) $
- 电感 $L$
$ L = (omega^2)/R_m = (omega^2 mu_0 S_0)/(2delta) $
$ L_0 = (omega^2)/R_m = (omega^2 mu_0 S_0)/(2delta_0) $ 

==== 变隙式电感传感器
$ L(delta = delta_0 - Delta delta) = L_0 + Delta L = (omega^2 mu_0 S_0)/(2(delta_0 - Delta delta)) $
$ L/L_0 = (L_0 + Delta L)/L_0 = 1/(1 - Delta delta"/"delta_0) $
$ L/L_0 = 1 + (Delta L)/L_0 = 1 + (Delta delta)/delta_0 + ((Delta delta)/(2 delta_0))^2 + ((Delta delta)/(2 delta_0))^3 + dots $
$ (Delta L)/L_0 = (Delta delta)/delta_0 + ((Delta delta)/(2 delta_0))^2 + ((Delta delta)/(2 delta_0))^3 + dots approx (Delta delta)/delta_0 $

- 灵敏度 $K$
$ K = ((Delta L)"/"L_0)/(Delta delta) = 1/delta_0 $

==== 差动变隙式电感传感器
$ L_1 = L_0 + Delta L_1 = L_0 dot [1 + (Delta delta)/delta_0 + ((Delta delta)/(2 delta_0))^2 + ((Delta delta)/(2 delta_0))^3 + dots] $
$ L_2 = L_0 - Delta L_2 = L_0 dot [1 - (Delta delta)/delta_0 + ((Delta delta)/(2 delta_0))^2 - ((Delta delta)/(2 delta_0))^3 + dots] $
$ Delta L = L_1 - L_2 = 2 L_0 dot (Delta delta)/delta_0 $
$ (Delta L)/L_0 = 2 dot (Delta delta)/delta_0 $
$ K = (Delta L"/"L)/(Delta delta) = 2/delta_0 $

=== 差动变压器式电感传感器（LVDT）
$ dot(I)_1 = (dot(U)_1)/(r_1 + j omega L_1) $
$ dot(E)_(2a) = -j omega M_1 dot(I)_1 $
$ dot(E)_(2b) = -j omega M_2 dot(I)_1 $
$ dot(U)_2 = dot(E)_(2a) - dot(E)_(2b) = -(j omega (M_1 - M_2) dot(U)_1)/(r_1 + j omega L_1) $

- 有效值
$ U_2 = abs(dot(U)_2) = (omega (M_1 - M_2) dot(U)_1)/sqrt(r_1^2 + (omega L_1)^2) $

=== 信号调制解调【相敏检波器】'


=== 电涡流传感器

== 电容传感器与测量
== 压电传感器与测量
== 磁电传感器与测量
== 光电传感器与测量
== 热电传感器与测量

