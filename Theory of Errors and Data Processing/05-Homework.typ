#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-12-22" // 日期，格式为 YYYY-MM-DD
#let course = "误差理论与数据处理" // 课程名称
#let proj-name = "Exercise for Chapter 5" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(5.1)[
  由测量方程
  $
    3x + y = 2.9 "    " x - 2y = 0.9 "    " 2x - 3y = 1.9
  $
  试求 $x$ 、 $y$ 的最小二乘法处理及其相应精度。
]
#SOLUTION

整理以上方程组：
$
  cases(
    v_1 = 2.9 - (3x + y),
    v_2 = 0.9 - (x - 2y),
    v_3 = 1.9 - (2x - 3y)
  )
$
写成矩阵形式即为：$V = L - A dot X$ ，其中:
$
  V = mat( v_1; v_2; v_3 ),
  L = mat( 2.9; 0.9; 1.9 ),
  A = mat( 3, 1; 1, -2; 2, -3 ),
  X = mat( x; y )
$
记 $C = (A^T dot A)$ ，计算得到：
$
  C = A^T dot A = mat( 14, -5; -5, 14 )
$
令 $V = O$ , 则有：
$
  hat(X) = C^(-1) dot A^T dot L = mat( 14, -5; -5, 14 )^(-1) dot mat( 3, 1, 2; 1, -2, -3 ) dot mat( 2.9; 0.9; 1.9 ) = 1/855 mat( 823; 13 )
$
也就是：
$
  cases(
    x = 823 div 855 approx 0.9626,
    y = 13 div 855 approx 0.0152
  )
$
由 $V = L - A dot X$ 得到：
$
    V = mat( -0.0029; -0.0322; 0.0205 )
$
显然：$n = 3, t = 2$ ，可以得到：
$
  hat(sigma) = sqrt((sum_(i = 1)^n v_i^2)/(n - t)) approx 0.0383
$
由于前面计算可以得到：
$
  C^(-1) = 1/171 mat( 14, 5; 5, 14 )
$
所以有：
$
  cases(
    d_(11) = 14 div 171 approx 0.0818,
    d_(22) = 14 div 171 approx 0.0818
  )
$
最后得到 $x$ 和 $y$ 的的精度为：
$
    cases(
        sigma_x = hat(sigma) sqrt(d_(11)) approx 0.0110,
        sigma_y = hat(sigma) sqrt(d_(22)) approx 0.0110
    )
$
综上，$x$ 和 $y$ 的最小二乘法估计值及其相应精度分别为：
$
    cases(
        hat(x) = 0.9626,
        hat(y) = 0.0152
    )
$
$    
    cases(
        sigma_x approx 0.0110,
        sigma_y approx 0.0110
    )
$







#pagebreak()
#problem(5.3)[
    已知误差方程为
    $
    v_1 &= 10.013 - x_1  &  v_3 &= 10.002 - x_3  &  v_5 &= 0.008 - (x_1 - x_3) \
    v_2 &= 10.010 - x_2 quad &  v_4 &= 0.004 - (x_1 - x_2) quad &  v_6 &= 0.006 - (x_2 - x_3)
    $
    试给出 $x_1$ 、 $x_2$ 、 $x_3$ 的最小二乘法估值及其相应精度。
]
#SOLUTION

整理以上方程组：
$
    cases(
        v_1 = 10.013 - x_1,
        v_2 = 10.010 - x_2,
        v_3 = 10.002 - x_3,
        v_4 = 0.004 - (x_1 - x_2),
        v_5 = 0.008 - (x_1 - x_3),
        v_6 = 0.006 - (x_2 - x_3)
    )
$
写成矩阵形式即为：$V = L - A dot X$ ，其中:
$
    V = mat( v_1; v_2; v_3; v_4; v_5; v_6 ),
    L = mat( 10.013; 10.010; 10.002; 0.004; 0.008; 0.006 ),
    A = mat( 1, 0, 0; 0, 1, 0; 0, 0, 1; 1, -1, 0; 1, 0, -1; 0, 1, -1 ),
    X = mat( x_1; x_2; x_3 )
$
记 $C = (A^T dot A)$ ，计算得到：
$
    C = A^T dot A = mat( 3, -1, -1; -1, 3, -1; -1, -1, 3 ) \
    C^(-1) = (A^T dot A)^(-1) = 1/4 mat( 2, 1, 1; 1, 2, 1; 1, 1, 2 ) 
$
令 $V = O$ , 则有：
$
    hat(X) = C^(-1) dot A^T dot L = mat( 3, -1, -1; -1, 3, -1; -1, -1, 3 )^(-1) dot mat( 1, 0, 0; 0, 1, 0; 0, 0, 1; 1, -1, 0; 1, 0, -1; 0, 1, -1 )^T dot mat( 10.013; 10.010; 10.002; 0.004; 0.008; 0.006 ) =  mat( 10.0125; 10.00925; 10.00325 )
$
即：
$
    cases(
        x_1 = 10.0125,
        x_2 = 10.00925,
        x_3 = 10.00325
    )
$
由 $V = L - A dot X$ 得到：
$
    V = mat( 0.0005; 0.00075; -0.00125; 0.00075; -0.00125; 0 )
$
显然：$n = 6, t = 3$ ，可以得到：
$    
    hat(sigma) = sqrt((sum_(i = 1)^n v_i^2)/(n - t)) approx 0.00122
$
由于前面计算可以得到：
$
  d_(11) = d_(22) = d_(33) = 1/2
$
所以有：
$
    cases(
        sigma_(x_1) = hat(sigma) sqrt(d_(11)) approx 0.000866,
        sigma_(x_2) = hat(sigma) sqrt(d_(22)) approx 0.000866,
        sigma_(x_3) = hat(sigma) sqrt(d_(33)) approx 0.000866
    )
$
综上，$x_1$ 、 $x_2$ 、 $x_3$ 的最小二乘法估计值及其相应精度分别为：
$
    cases(
        hat(x_1) = 10.0125,
        hat(x_2) = 10.00925,
        hat(x_3) = 10.00325
    )
$
$    
    cases(
        sigma_(x_1) approx 0.000866,
        sigma_(x_2) approx 0.000866,
        sigma_(x_3) approx 0.000866
    )
$



#pagebreak()
#problem(5.7)[
    不等精度测量的方程组如下
    $
      x - 3y = -5.6, P_1 = 1;
      4x + y = 8.1, P_2 = 2;
      2x - y = 0.5, P_3 = 3;
    $
    试求 $x$ 、 $y$ 的最小二乘法处理及其相应精度。
]
#SOLUTION

整理以上方程组：
$  cases(
    v_1 = -5.6 - (x - 3y),
    v_2 = 8.1 - (4x + y),
    v_3 = 0.5 - (2x - y)
  )
$
写成矩阵形式即为：$V = L - A dot X$ ，其中:
$  
  V = mat( v_1; v_2; v_3 ),
  L = mat( -5.6; 8.1; 0.5 ),
  A = mat( 1, -3; 4, 1; 2, -1 ),
  X = mat( x; y ),
  P = "diag"( 1, 2, 3 )
$
记 $C = (A^T dot P dot A)$ ，计算得到：
$  
  C = A^T dot P dot A = mat( 45, -1; -1, 14 )
$
令 $V = O$ , 则有：
$  
  hat(X) = C^(-1) dot A^T dot P dot L = mat( 45, -1; -1, 14 )^(-1) dot mat( 1, 4, 2; -3, 1, -1 ) dot "diag"( 1, 2, 3 ) dot mat( -5.6; 8.1; 0.5 ) approx mat(1.4345; 2.3525)
$
也就是：
$  cases(
    x approx 1.4345,
    y approx 2.3525
  )
$
由 $V = L - A dot X$ 得到：
$  
    V approx mat( 0.02289; 0.00954; -0.01653 )
$
显然：$n = 3, t = 2$ ，可以得到：
$  
  hat(sigma) = sqrt((sum_(i = 1)^n P_i v_i^2)/(n - t)) approx 0.03906
$
由于前面计算可以得到：
$
  C^(-1) = 1/629 mat( 14, 1; 1, 45 )
$
所以有：
$
  cases(
    d_(11) = 14 div 629 approx 0.0222,
    d_(22) = 45 div 629 approx 0.0715
  )
$
最后得到 $x$ 和 $y$ 的的精度为：
$
    cases(
        sigma_x = hat(sigma) sqrt(d_(11)) approx 0.00583,
        sigma_y = hat(sigma) sqrt(d_(22)) approx 0.01045
    )
$
综上，$x$ 和 $y$ 的最小二乘法估计值及其相应精度分别为：
$
    cases(
        hat(x) approx 1.4345,
        hat(y) approx 2.3525
    )
$
$    
    cases(
        sigma_x approx 0.00583,
        sigma_y approx 0.01045
    )
$