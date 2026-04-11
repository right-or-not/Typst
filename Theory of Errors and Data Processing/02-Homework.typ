#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-11-25" // 日期，格式为 YYYY-MM-DD
#let course = "误差理论与数据处理" // 课程名称
#let proj-name = "Exercise for Chapter 2" // 作业/项目名称

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

#problem(2.2)[
  试述单次测量的标准差 $sigma$ 和算数平均值的标准差 $sigma_(overline(x))$ ，两者物理意义和实际用途有何不同？ 
]
#SOLUTION
1. 单次测量的标准差 $sigma$:
$
  sigma = sqrt(1/n dot sum_(i = 1)^(n) delta_i^2) = sqrt(1/(n-1) dot sum_(i = 1)^(n) v_i^2)
$
- *物理意义：* $sigma$ 表示的是测量列的标准差，即单一测量值相对于其真值（实际测量中通常取总体均值）的离散程度，反映的是测量系统本身的精密度。
- *实际用途：* 单次测量的标准差 $sigma$ 可以表征测量的不确定度和可靠性。同时，测量列的标准差还可以评估测量方法或测量仪器随机误差的大小，从而评估仪器精密度。

2. 算数平均值的标准差 $sigma_(overline(x))$
$
  sigma_(overline(x)) = sigma/(sqrt(n))
$
- *物理意义：* $sigma_(overline(x))$ 描述的是多次测量的算术平均值相对于真值的离散程度，反映了平均值这个估计量的可靠性。
- *实际用途：* 算数平均值的标准差 $sigma_(overline(x))$ 表征了平均结果的不确定度，能够用来评估平均值的精度。同时，$sigma_(overline(x))$ 与测量次数 $n$ 有关，因此也能在一定程度上帮助我们选择合理的测量次数：如果平均值的标准差较大，可以适当增加测量次数。



#pagebreak()
#let x_string = ("236.45", "236.37", "236.51", "236.34", "236.39", "236.48", "236.47", "236.40")
#let x = x_string.map(str => calc.round(float(str), digits: 2))
#let mean = cal_mean(x, 10)
#let sig = cal_sig(x, 6)
#let sig_mean = cal_sig_mean(x, 6)
#problem(2.4)[
  测量某物体重量共 #{x.len()} 次，测得数据（单位为 g）为 #{x_string.join("，")}。试求算术平均值及其标准差。
]
#SOLUTION

由题意可知：
$
  overline(x) 
  &= (x_1 + x_2 + dots + x_n)/n \
  &= #mean approx 236.43
$
取算术平均值 $overline(x) = 236.43$。

计算算术平均值的标准差 $sigma_(overline(x))$ 的时候不用对 $overline(x)$ 修约，即取 $overline(x) = #mean$。
$
  sigma = sqrt(1/(n-1) dot sum_(i = 1)^n v_i^2) = #sig 
$
$
  sigma_(overline(x)) = sigma / (sqrt(n)) = #sig_mean approx 0.021
$
取算术平均值的标准差 $sigma_(overline(x)) = 0.021$。




#pagebreak()
#let x_string = ("168.41", "168.54", "168.59", "168.40", "168.50")
#let x = x_string.map(str => calc.round(float(str), digits: 2))
#let mean = cal_mean(x, 10)
#let sig = cal_sig(x, 4)
#let sig_mean = cal_sig_mean(x, 4)
#problem(2.6)[
  测量某电路电流共 #{x.len()} 次，测的数据（单位为mA）为 #{x_string.join("，")}。试求算术平均值及其标准差、或然误差及平均误差。
]
#SOLUTION

由题意可知：
$
  overline(x) 
  &= (x_1 + x_2 + dots + x_n)/n \
  &= #mean approx 168.49
$
取算术平均值 $overline(x) = 168.49$。

计算其标准差时，选用准确的算术平均值计算，即取 $overline(x) = #mean$。
$
  sigma = sqrt(1/(n-1) dot sum_(i = 1)^n v_i^2) = #sig 
$
$
  sigma_(overline(x)) = sigma/(sqrt(n)) = #sig_mean approx 0.04
$
取标准差 $sigma = 0.04$。
$
  rho approx 2/3 sigma = #{calc.round(sig_mean*2/3, digits: 4)} approx 0.025
$
取或然误差 $rho = 0.025$。
$
  theta approx 4/5 sigma = #{calc.round(sig_mean*4/5, digits: 4)} approx 0.030
$
取平均误差 $theta = 0.030$。





#pagebreak()
#let x_string = ("102523.85", "102391.30", "102257.97", "102124.65", "101991.33", "101858.01", "101724.69", "101591.36")
#let x = x_string.map(str => calc.round(float(str), digits: 2))
#let quan = (1, 3, 5, 7, 8, 6, 4, 2)
#let mean_quan = cal_mean_quan(x, quan, 10)
#let sig_quan = cal_sig_quan(x, quan, 4)
#let sig_mean_quan = cal_sig_mean_quan(x, quan, 4)
#problem(2.12)[
  某时某地由气压表得到的读数（单位为Pa）为 #{x_string.join("，")}，其权各为 #{quan.map(int => str(int)).join("，")}，试求加权算术平均值及其标准差。
]
#SOLUTION

由题意可知：
$
  overline(x) = (p_1 dot x_1 + p_2 dot x_2 + dots + p_n dot x_n)/(p_1 + p_2 + dots + p_n) = #mean_quan approx 102028.34
$
取加权算数平均值为 $overline(x) = 102028.34$。
$
  sigma = sqrt(1/(n-1) dot sum_(i = 1)^(n) p_i dot v_i^2) = #sig_quan
$
$
  sigma_(overline(x)) = sigma / (sqrt(limits(sum)_(i = 1)^n p_i)) = #sig_mean_quan approx 86.95
$
取气压表读数的加权标准差 $sigma = #sig_quan$，由此可以根据 $sigma_(overline(x)) = sigma"/"sqrt(limits(sum)_(i = 1)^n p_i)$ 计算得到 $sigma_(overline(x)) = 86.95$。





#pagebreak()
#let x_bar = 9.811
#let x_sig = 0.014
#let y_bar = 9.802
#let y_sig = 0.022
#let mean = calc.round((121*x_bar + 49*y_bar)/(121+49), digits: 5)
#problem(2.16)[
  对某重力加速度作两组测量，第一组测量具有平均值为 $#{x_bar} "m/s"^2$、其标准差为 $#{x_sig} "m/s"^2$。第二组测量具有平均值为 $#{y_bar} "m/s"^2$、其标准差为 $#{y_sig} "m/s"^2$。假设这两组测量属于同一正态总体。试求此两组测量的平均值和标准差。
]
#SOLUTION

因为两组测量属于同一正态总体，因此可以通过两组测量的标准差得到两组测量的权值：
$
  p_1 : p_2 = 1/(sigma_1^2) : 1/(sigma_2^2) = 121 : 49
$
由此，可以算出加权平均值 $overline(x)$：
$
  overline(x) = (p_1 dot overline(x)_1 + p_2 dot overline(x)_2)/(p_1 + p_2) =  mean approx 9.808
$
取加权算术平均值 $overline(x) = 9.808$。
$
  sigma = sqrt(1/(2-1) dot [p_1 dot (overline(x)_1 - overline(x))^2 + p_2 dot (overline(x)_2 - overline(x))^2]) = 0.05315 approx 0.05
$
$
  sigma_(overline(x)) = sigma/(sqrt(p_1 + p_2)) = 0.0041 approx 0.004
$
取算术平均值的标准差 $sigma_(overline(x)) = 0.004$。






#pagebreak()
#let x_string = ("14.7", "15.0", "15.2", "14.8", "15.5", "14.6", "14.9", "14.8", "15.1", "15.0")
#let x = x_string.map(s => calc.round(float(s), digits: 1))
#let mean = cal_mean(x, 10)
#let sig = cal_sig(x, 4)
#let sig_2 = calc.round(1.253 * x.map(x => calc.abs(x - mean)).sum() / calc.sqrt((x.len() * (x.len() - 1))), digits: 4)
#problem(2.17)[
  对某量进行 #{x.len()} 次测量，测得数据为 #{x_string.join("，")}，试判断该测量列中是否存在系统误差。
]
#SOLUTION

由题意可知：可以用标准差比较法来发现系统误差。先计算算术平均值：
$
  overline(x) = 1/n dot sum_(i = 1)^n x_i = #mean
$
先用贝塞尔公式求标准差：
$
  sigma_1 = sqrt(1/(n-1) dot sum_(i = 1)^n v_i^2) = #sig
$
再用别捷尔斯法计算标准差：
$
  sigma_2 = 1.253/(n dot (n-1)) dot sum_(i = 1)^n |v_i| = #sig_2
$
即有：
$
  sigma_1 / sigma_2 = 1 + u = #{calc.round(sig/sig_2, digits: 4)}
$
#let u = calc.round(1-sig/sig_2, digits: 4)
$
  u = #u < 2/(sqrt(n-1)) = 0.6667
$
因此，没有充分的理由认为该测量列中存在系统误差。




#pagebreak()
#let x_string = ("28.53", "28.52", "28.50", "29.52", "28.53", "28.53", "28.50", "28.49", "28.49", "28.51", "28.53", "28.52", "28.49", "28.40", "28.50")
#let x = x_string.map(str => calc.round(float(str), digits: 2))
#let mean = cal_mean(x, 4)
#let sig = cal_sig(x, 4)
#problem(2.22)[
  对某量进行 #{x.len()} 次测量，测的数据为 #{x_string.join("，")}，若这些测得值已消除系统误差，试用莱伊特准则、格罗布斯准则和迪克松准则分别判别该测量列中是否含有粗大误差的测量值。
]
#SOLUTION

*(1) 莱伊特准则: *先计算测量列的算术平均值：
$
  overline(x) = 1/n dot sum_(i = 1)^n x_i = #mean approx 28.57
$
再计算测量列的标准差：
$
  sigma = sqrt(1/(n-1) dot sum_(i=1)^n v_i^2) = #sig approx 0.26
$
显然：
$
  x_4 - overline(x) = #{0.95} > #{3*0.27} = 3sigma
$
所以 $x_4$ 是粗大误差，去除后计算算术平均值和标准差：
#let x_1 = x.slice(0, 3) + x.slice(4)
#let mean_1 = cal_mean(x_1, 4)
#let sig_1 = cal_sig(x_1, 4)
$
  overline(x) = #mean_1 approx 28.50 \
  sigma = #sig_1 approx 0.03
$
显然：
$
  |x_12 - overline(x)| = #{0.1} > #{3*0.03} = 3sigma
$
所以倒数第二个数据也是粗大误差，去除后计算算术平均值和标准差：
#let x_2 = x_1.slice(0, 12) + x_1.slice(13)
#let mean_2 = cal_mean(x_1, 4)
#let sig_2 = cal_sig(x_1, 4)
$
  overline(x) = #mean_2 approx 28.51 \
  sigma = #sig_2 approx 0.017
$
此时，所有数据均在 $-3sigma ~ 3sigma$ 之间，没有理由怀疑剩下的 13 个数据有粗大误差。\
\

*(2) 格罗布斯准则: *同（1）可以计算算术平均值和标准差：
$
  overline(x) = #mean approx 28.58 \
  sigma = #sig approx 0.27
$
计算：
$
  g_((n)) = (|x_((n)) - overline(x)|)/sigma
$
#let g = x.sorted().map(x => calc.abs(x - mean)/sig)
查表可以知道：$g_0(15, 0.05) = 2.41$
$
  g_((1)) = #calc.round(g.at(0), digits: 4), g_((2)) = #calc.round(g.at(1), digits: 4), dots, g_((15)) = #calc.round(g.at(-1), digits: 4)
$
其中 $g_((15)) > g_0(15, 0.05)$，所以需要剔除最大值 $29.52$，然后继续上述步骤，此时 $n = 14$。先计算算术平均值和标准差：
$
  overline(x) = #mean_1 approx 28.50 \
  sigma = #sig_1 approx 0.03
$
查表可以知道：$g_0(14, 0.05) = 2.37$
#let g_1 = x_1.sorted().map(x => calc.abs(x - mean_1)/sig_1)
$
  g_((1)) = #calc.round(g_1.at(0), digits: 4), g_((2)) = #calc.round(g_1.at(1), digits: 4), dots, g_((15)) = #calc.round(g_1.at(-1), digits: 4)
$
其中 $g_((1)) > g_0(14, 0.05)$，所以需要剔除最小值 $28.40$，然后继续上述步骤，没有理由怀疑剩下的 13 个数据有粗大误差。\
\

*(3) 迪克松准则: *先讲测量列由小到大排列：
#let x_sort = x.sorted()
$
  x_((1)) = #x_sort.at(0), x_((2)) = #x_sort.at(1),dots, x((15)) = #x_sort.at(-1)
$
查表可知：$r_0(15, 0.01) = 0.616$。
$
  r_22 = (x_((15)) - x_((13)))/(x_((15)) - x_((3))) = #calc.round({(x_sort.at(-1) - x_sort.at(-3))/(x_sort.at(-1) - x_sort.at(2))}, digits: 4) > r_0(15, 0.01)
$
所以最大值 $29.52$ 为粗大误差，剔除后继续上述步骤，此时 $n = 14$，查表可知：$r_0(14, 0.01) = 0.641$。
#let x_sort = x_sort.slice(0, x_sort.len()-1)
$
  r_22 = (x_((14)) - x_((12)))/(x_((14)) - x_((3))) = #calc.round({(x_sort.at(-1) - x_sort.at(-3))/(x_sort.at(-1) - x_sort.at(2))}, digits: 4)
$
$
  r_(22)' = (x_((3)) - x_((1)))/(x_((14)) - x_((1))) = #calc.round({(x_sort.at(2) - x_sort.at(0))/(x_sort.at(-1) - x_sort.at(0))}, digits: 4) > r_0(14, 0.01)
$
所以最小值 $28.40$ 也是粗大误差，剔除后重复上述操作，可以发现没有充分理由怀疑剩下的 13 个测量数据还有粗大误差。