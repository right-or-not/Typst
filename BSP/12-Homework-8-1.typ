#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-12-18" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "First Exercise for Chapter 8" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)


#problem(1)[
  Determine the z-transform, including the ROC, for each of the following sequences: #v(0.5em)
  *(a)* $display((1/2)^n u[n])$ #v(0.5em)
  *(b)* $display((1/2)^n u[-n])$ #v(0.5em)
  *(c)* $display((1/2)^n (u[n] - u[n - 10]))$ #v(0.5em)
]
#SOLUTION

*(a)* 
$
  X(z) 
  &= sum_(n = -infinity)^(+infinity) x[n] dot z^(-n) = sum_(n = -infinity)^(+infinity) (1/2)^n u[n] dot z^(-n) \
  &= sum_(n = 0)^(+infinity) (1/2)^n dot z^(-n) = 1/(1 - 1/2 z^(-1))", ROC: "|z| > 1/2
$ \

*(b)* 
$
  X(z) 
  &= sum_(n = -infinity)^(+infinity) x[n] dot z^(-n) = sum_(n = -infinity)^(+infinity) (1/2)^n u[-n] dot z^(-n) \
  &= sum_(n = -infinity)^(0) (1/2)^n dot z^(-n) = sum_(n = 0)^(+infinity) (2z)^n \
  &= 1/(1 - 2z)", ROC: "|z| < 1/2
$ \

*(c)* 
$
  X(z) 
  &= sum_(n = -infinity)^(+infinity) x[n] dot z^(-n) \ 
  &= sum_(n = -infinity)^(+infinity) (1/2)^n (u[n] - u[n - 10]) dot z^(-n) \
  &= sum_(n = 0)^(9) (1/2)^n dot z^(-n) = sum_(n = 0)^(+infinity) (2z)^n \
  &= (1 - (1/2 z^(-1))^10 )/(1 - 1/2 z^(-1))", ROC: "|z| > 0  
$











#pagebreak()
#problem(2)[
  Following are several z-transforms. For each, determine the inverse z-transform: #v(1.5em)
  *(a)* $display(X(z) = (1 - 1/2z^(-1))/(1 + 3/4z^(-1) + 1/8z^(-2))), abs(z) > 1/2$ #v(1.5em)
  *(b)* $display(X(z) = (1 - 1/2z^(-1))/(1 - 1/4z^(-2))), abs(z) > 1/2$ #v(1.5em)
  *(c)* $display(X(z) = (1 - a z^(-1))/(z^(-1) - a)), abs(z) > abs(1/a)$ #v(1.5em)
]
#SOLUTION

*(a)* 
$
  X(z) 
  &= (1 - 1/2z^(-1))/(1 + 3/4z^(-1) + 1/8z^(-2)) = (1 - 1/2z^(-1))/((1 + 1/2z^(-1))(1 + 1/4 z^(-1))) \
  &= c_1 / (1 + 1/2z^(-1)) + c_2 / (1 + 1/4z^(-1))
$
where,
$
  c_1 = "RES"[X(z); z^(-1) = -2] = lim_(z^(-1) -> -2) (1 - 1/2z^(-1))/(1 + 1/4z^(-1)) = 4 \
  c_2 = "RES"[X(z); z^(-1) = -4] = lim_(z^(-1) -> -4) (1 - 1/2z^(-1))/(1 + 1/2z^(-1)) = -3 \
$
so,
$
  X(z) 
  &= 4 dot 1/(1 + 1/2z^(-1)) + (-3) dot 1/(1 + 1/4z^(-1)) \
  &= 4 dot sum_(n = 0)^(+infinity) (-1/2z^(-1))^n + (-3) dot sum_(n = 0)^(+infinity) (-1/4z^(-1))^n \
  &= sum_(n = -infinity)^(+infinity) {4 (-1/2)^n dot u[n] - 3 (-1/4)^n dot u[n]} dot z^(-n) 
$
That is:
$
  x[n] = 4 dot (-1/2)^n dot u[n] - 3 dot (-1/4)^n dot u[n]
$ \
\

*(b)* 
$
  X(z) 
  &= (1 - 1/2z^(-1))/(1 - 1/4z^(-2)) = (1 - 1/2z^(-1))/((1 - 1/2z^(-1))(1 + 1/2z^(-1))) = 1/(1 + 1/2z^(-1))
$
so,
$
  X(z) = sum_(n = 0)^(+infinity) (-1/2 z^(-1))^n = sum_(n = -infinity)^(+infinity) (-1/2)^n dot u[n] dot z^(-n)
$
That is,
$
  x[n] = (-1/2)^n dot u[n]
$ \

*(c)* 
$
  X(z) 
  &= (1 - a z^(-1))/(z^(-1) - a) = (-1/a + z^(-1))/(1 - 1/a z^(-1)) = -a + (a^2 - 1)/a dot 1/(1 - 1/a dot z^(-1))
$
so,
$
  X(z) 
  &= -a + (a^2 - 1)/a dot sum_(n = 0)^(+infinity) (1/a dot z^(-1))^n \
  &= sum_(n = -infinity)^(+infinity) {-a dot delta[n] + (a^2-1)/a (1/a)^n dot u[n]} dot z^(-n) \
$
That is:
$
  x[n] = -a dot delta[n] + (a^2-1)/a (1/a)^n dot u[n]
$








#pagebreak()
#problem(7.2)[
  A discrete-time signal $x[n]$ has z-transform
  $
    X(z) = (z)/(8z^2 - 2z - 1)
  $
  Determine the z-transform $V(z)$ of the following signals: \
  *(a)* $v[n] = x[n-4] u[n-4]$ \
  *(c)* $v[n] = cos(2n) x[n]$ \
  *(f)* $v[n] = x[n] * x[n]$ \
]
#SOLUTION

*(a)* 
$
  cal(Z){v[n]} = cal(Z){x[n-4]u[n-4]} = z^(-4)X(z) = (z^(-3))/(8z^2 - 2z - 1)
$ \

*(c)* 
$
  cal(Z){v[n]} 
  &= cal(Z){cos(2n)x[n]} = cal(Z){(e^(j(2n)) + e^(-j(2n)))/2 dot x[n]} \
  &= 1/2X(z e^(-2j)) + 1/2 X(z e^(2j)) \
  &= 1/2 dot (z e^(-2j))/(8(z e^(-2j))^2 - 2(z e^(-2j)) - 1) + 1/2 dot (z e^(2j))/(8(z e^(2j))^2 - 2(z e^(2j)) - 1)
$ \

*(f)* 
$
  cal(Z){v[n]}
  &= cal(Z){x[n] * x[n]} = X(z) dot X(z) = ((z)/(8z^2 - 2z - 1))^2
$






#pagebreak()
#problem(4)[
  The input to a causal LTI system inverse
  $
    x[n] = u[n-1] + (1/3)^n u[n]
  $
  The z-transform of the output of this system is
  $
    Y(z) = (- 1/3 z^(-1))/((1 - 1/3z^(-1))(1 + z^(-1)))
  $
  *(a)* Determine $H(z)$, the z-transform of the system impulse response. Be sure to specify the ROC. \
  *(b)* What is the ROC for $Y(z)$? \
  *(c)* Determine $y[n]$. 
]
#SOLUTION

*(a)* 
$
  X(z) 
  &= sum_(n = -infinity)^(+infinity) x[n] z^(-n) = sum_(n = -infinity)^(+infinity) {u[n-1] + (1/3)^n u[n]} z^(-n) \
  &= z^(-1) dot sum_(n = 0)^(+infinity) z^(-n) + sum_(n = 0)^(+infinity)(1/3)^n z^(-n) \
  &= z^(-1) dot 1/(1 - z^(-1)) + 1/(1 - 1/3 z^(-1)) \
  &= (1 - 1/3z^(-2))/((1-z^(-1))(1 - 1/3z^(-1)))
$
So,
$
  H(z) = (Y(z))/(X(z)) = ((- 1/3 z^(-1))/((1 - 1/3z^(-1))(1 + z^(-1))))/((1 - 1/3z^(-2))/((1-z^(-1))(1 - 1/3z^(-1)))) = ((-1/3z^(-1))(1 - z^(-1)))/((1 - 1/3z^(-2))(1 + z^(-1)))
$
and the ROC: $abs(z) > 1$. \
\

*(b)* Because the system is a causal LTI system, so the ROC for $Y(z)$ is $abs(z) > 1$. \
\

*(c)* 
$
  Y(z) = (- 1/3 z^(-1))/((1 - 1/3z^(-1))(1 + z^(-1))) = c_1 / ((1 - 1/3z^(-1))) + c_2 / ((1 + z^(-1)))
$
where,
$
  c_1 = "Res"[Y(z); z^(-1) = 3] = lim_(z^(-1) -> 3) (- 1/3 z^(-1))/(1 + z^(-1)) = -1/4 \
  c_2 = "Res"[Y(z); z^(-1) = -1] = lim_(z^(-1) -> -1) (- 1/3 z^(-1))/(1 - 1/3z^(-1)) = 1/4 \
$
so,
$
  Y(z) 
  &= -1/4 dot 1/((1 - 1/3z^(-1))) + 1/4 dot 1/((1 + z^(-1))) \
  &= -1/4 sum_(n = 0)^(+infinity)(1/3z^(-1))^n + 1/4 sum_(n = 0)^(+infinity) (-z^(-1))^n \
  &= sum_(n = -infinity)^(+infinity) {-1/4dot (1/3)^n + 1/4dot (-1)^n} dot u[n] dot z^(-n)
$
That is:
$
  x[n] = {-1/4dot (1/3)^n + 1/4dot (-1)^n} dot u[n]
$






#pagebreak()
#problem(7.15)[
  The input $x[n] = (-1)^n u[n]$ is applied to a linear time-invariant discrete-time system. The resulting output response $y[n]$ with zero initial conditions is given by
  $
    y[n] = cases(
      0"," &"for" n < 0,
      n + 1",   " &"for" n = "0, 1, 2, 3",
      0"," &"for" n >= 4
    )
  $
  Determine the transfer function $H(z)$ of the system.
]
#SOLUTION

For $x[n] = (-1)^n u[n]$, 
$
  X(z) = sum_(n = -infinity)^(+infinity) x[n] dot z^(-n) = sum_(n = 0)^(infinity) (-1)^n dot z^(-n) = 1/(1 + z^(-1))
$
where the ROC is: $abs(z) > 1$.

For $y[n]$,
$
  Y(z) = 1 + 2z^(-1) + 3z^(-2) + 4z^(-3) 
$
where the ROC is: $abs(z) > 0$.

So,
$
  H(z) 
  &= (Y(z))/(X(z)) = (1 + 2z^(-1) + 3z^(-2) + 4z^(-3) )/(1"/"(1 + z^(-1))) \
  &= (1 + 2z^(-1) + 3z^(-2) + 4z^(-3))(1 + z^(-1))
$








#pagebreak()
#problem(7.24)[
  A linear time-invariant discrete-time system has transfer function
  $
    H(z) = (z^2 - z - 2)/(z^2 + 1.5z - 1)
  $
  *(a)* Compute the unit-pulse response $h[n]$ for all $n >= 0$. \
  *(b)* Compute the step response $y[n]$ for all $n >= 0$. \
  *(c)* Compute the output values $y[0], y[1], y[2]$ resulting from the input $x[n] = 2^n sin(pi n "/" 4) + tan(pi n "/" 3), n = 0, 1, 2, dots$, with zero initial conditions. \
  *(d)* If possible, find an input $x[n]$ with $x[n] = 0$ for all $n < 0$ such that the output response $y[n]$ resulting from $x[n]$ is given by $y[0] = 2, y[1] = -3$, and $y[n] = 0$ for all $n >= 2$. Assume that the initial conditions are equal to zero.
]
#SOLUTION

*(a)* 
$
  H(z) 
  &= (z^2 - z - 2)/(z^2 + 1.5z - 1) = 2 + c_1 / (1 + 2z^(-1)) + c_2/(1 - 1/2z^(-1))
$
where
$
  c_1 = "Res"[H(z); z^(-1) = -1/2] = 4/5 \
  c_2 = "Res"[H(z); z^(-1) = 2] = -9/5
$
So,
$
  H(z) 
  &= 2 + 4/5 dot 1/(1 + 2z^(-1)) - 9/5 dot 1/(1 - 1/2z^(-1)) \
  &= 2 + 4/5 dot sum_(n = 0)^(+infinity) (-2z^(-1))^n - 9/5 dot sum_(n = 0)^(+infinity) (1/2z^(-1))^n \
  &= sum_(n = -infinity)^(+infinity) {2delta[n] + 4/5 dot (-2)^n dot u[n] - 9/5 dot (1/2)^n dot u[n]} dot z^(-n)
$
That is,
$
  h[n] = 2delta[n] + {4/5 dot (-2)^n - 9/5 dot (1/2)^n} dot u[n]
$\

*(b)* For input $x[n] = u[n]$,
$
  X(z) = 1/(1 - z^(-1))
$
Then, it is easy to get:
$
  Y(z) 
  &= X(z) dot H(z) = (1 - z^(-1) - 2z^(-2))/((1 - z^(-1))(1 + 2z^(-1))(1 - 1/2z^(-1))) \
  &= c_1/(1 - z^(-1)) + c_2/(1 + 2z^(-1)) + c_3/(1 - 1/2z^(-1))
$
where:
$
  c_1 = "Res"[Y(z); z^(-1) = 1] = -4/3 \
  c_2 = "Res"[Y(z); z^(-1) = -1/2] = 8/15 \
  c_3 = "Res"[Y(z); z^(-1) = 2] = 9/5 \
$
So,
$
  Y(z) 
  &= -4/3 dot 1/(1 - z^(-1)) + 8/15 dot 1/(1 + 2z^(-1)) + 9/5 dot 1/(1 - 1/2z^(-1)) \
  &= -4/3 dot sum_(n = 0)^(+infinity) (z^(-1))^n + 8/15 dot sum_(n = 0)^(+infinity) (-2z^(-1))^n + 9/5 dot sum_(n = 0)^(+infinity) (1/2z^(-1))^n \
  &= sum_(n = -infinity)^(+infinity) {-4/3 + 8/15 dot (-2)^n + 9/5 dot (1/2)^n} dot u[n] dot z^(-n)
$
That is:
$
  y[n] = {-4/3 + 8/15 dot (-2)^n + 9/5 dot (1/2)^n} dot u[n]
$ \


*(c)* 
$
  H(z) = (1 - z^(-1) - 2z^(-2))/(1 + 1.5z^(-1) - z^(-2)) = (Y(z))/(X(z))
$
So,
$
  (1 + 1.5z^(-1) - z^(-2))Y(z) = (1 - z^(-1) - 2z^(-2))X(z)
$
That is:
$
  y[n] + 1.5y[n-1] - y[n-2] = x[n] - x[n-1] - 2x[n-2] 
$
Let $n = 0$, $y[0] = x[0] = 0$; \
Let $n = 1$, $y[1] = -1.5y[0] + x[1] - x[0] = sqrt(2) + sqrt(3)$; \
Let $n = 2$, $y[2] = -1.5y[1] + y[0] + x[2] - x[1] - 2x[0] = 4 - 5/2sqrt(2) - 7/2sqrt(3)$; \

*(d)* 
$
  y[n] = 2delta[n] - 3delta[n-1]
$
So,
$
  Y(z) = cal(Z){y[n]} = 2 - 3z^(-1)
$
Because:
$
  H(z) = (Y(z))/(X(z)) =  (1 - z^(-1) - 2z^(-2))/(1 + 1.5z^(-1) - z^(-2))
$
Therefore,
$
  X(z) 
  &= ((2 - 3z^(-1))(1 + 2z^(-1))(1 - 1/2z^(-1)))/((1 - 2z^(-1))(1 + z^(-1))) \
  &= 4 - 3/2 z^(-1) + c_1/(1 - 2z^(-1)) + c_2/(1 + z^(-1))
$
where:
$
  c_1 = "Res"[X(z); z^(-1) = 1/2] = 1/2 \
  c_2 = "Res"[X(z); z^(-1) = -1] = -5/2 \
$
So,
$
  X(z) 
  &= 4 - 3/2 z^(-1) +  1/2 dot 1/(1 - 2z^(-1)) -5/2 dot 1/(1 + z^(-1)) \
  &= 4 - 3/2 z^(-1) +  1/2 dot sum_(n = 0)^(+infinity) (2z^(-1))^n -5/2 dot sum_(n = 0)^(+infinity) (-z^(-1))^n \
$
That is:
$
  x[n] = 4delta[n] - 3/2delta[n-1] + {1/2 dot (-2)^n - 5/2 dot (-1)^n}dot u[n]
$
#text(fill: red)[
$
  x[n] = 4delta[n] - 3/2delta[n-1] + {1/2 dot 2^n - 5/2 dot (-1)^n}dot u[n]
$
]




#pagebreak()
#problem(7.36)[
  A linear time-invariant discrete-time system is given by the cascade connection shown in Figure P7.36. \
  *(a)* Compute the unit-pulse response of the overall system. \
  *(b)* Compute the input/output difference equation of the overall system. \
  *(c)* Compute the step response of the overall system. \
  *(e)* Compute $y[n]$ when $x[n] = (0.5)^n u[n]$ with $y[-2] = 2, q[-2] = 3.$
  #image("image/12_7.png", width: 80%)
]
#SOLUTION

*(a)* 
$
  H(z) = (2z+1)/((1+z)^2) = 1 - 1/((1 + z^(-1))^2)
$
So,
$
  H(z) 
  &= 1 + 1/(z^(-1)) dot sum_(n = 0)^(+infinity) n(-1)^n z^(-n) \
  &= 1 +  sum_(n = 0)^(+infinity) n(-1)^n z^(-(n-1)) \
  &= 1 +  sum_(n = 0)^(+infinity) (n+1)(-1)^(n+1) z^(-n) \
$
That is:
$
  x[n] = delta[n] + (n+1)(-1)^(n+1) dot u[n]
$ \


*(b)* 
$
  H(z) = (2z^(-1) + z^(-2))/((1 + z^(-1))^2) = (Y(z))/(X(z))
$
So,
$
  (1 + 2z^(-1) + z^(-2))Y(z) =  (2z^(-1) + z^(-2))X(z)
$
That is:
$
  y[n] + 2y[n-1] - y[n-2] = 2x[n-1] + x[n-2]
$ \
#text(fill: red)[
$
  y[n] + 2y[n-1] + y[n-2] = 2x[n-1] + x[n-2]
$ \
]

*(c)* Let $x[n] = u[n]$,
$
  X(z) = 1/(1 - z^(-1))
$
So,
$
  Y(z) 
  &= X(z) dot H(z) = (z^(-1) (2 + z^(-1)))/((1 - z^(-1))(1 + z^(-1))^2) \
  &= c_1/(1 - z^(-1)) + c_2/((1 + z^(-1))^2) + c_3/(1 + z^(-1))
$
where,
$
  c_1 = "Res"[Y(z); z^(-1) = 1] = 3/4 \
  c_2 = "Res"[Y(z); z^(-1) = -1] = -1/2 \
  c_3  = -1/4 \
$
So,
$
  Y(z) 
  &= 3/4 dot 1/(1 - z^(-1)) -1/2 dot 1/((1 + z^(-1))^2) -1/4 dot 1/(1 + z^(-1)) \
  &= 3/4 dot sum_(n = 0)^(+infinity)(z^(-1))^n -1/2 dot sum_(n = 0)^(+infinity)(n+1)(-1)^(n+1)dot z^(-n) -1/4 dot sum_(n = 0)^(+infinity) (-z^(-1))^n \
$
That is:
$
  x[n] = {3/4 - 1/4 dot (-1)^n + 1/2 dot (n+1)(-1)^(n+1)} dot u[n]
$ \

*(d)* Because:
$
  H_2(z) = (Y(z))/(Q(z)) = 1/(1 + z) = (z^(-1))/(1 + z^(-1))
$
That is:
$
  y[n] + y[n-1] = q[n-1]
$
So,
$
  y[-1] = 1
$
We get the initial status: $y[-2] = 2, y[-1] = 1$.

First of all, compute the response of zero input:
$
  y[n] + 2y[n-1] + y[n-2] = 0
$
Use the characteristic equation:
$
  lambda^2 + 2lambda + 1 = 0
$
the solution is:
$
  lambda_1 = lambda_2 = -1
$
So,
$
  y[n] = (A + B n)(-1)^n
$
Let $y[-2] = 2, y[-1] = 1$,
$
  y_1[n] = (-4 - 3n)(-1)^n dot u[n+2]
$ \

Then compute the response of zero state:
$
  Y(z) 
  &= X(z) dot H(z) = (2z^(-1) + z^(-2))/((1 + z^(-1))^2) dot 1/(1 - 0.5z^(-1)) \
  &= 8/9 dot z/(z - 0.5) - 8/9 dot z/(z + 1) + 2/3 dot z/((z + 1)^2) \
$
That is:
$
  y_2[n] = {8/9 dot (1/2)^n - 8/9 dot (-1)^n - (2n(-1)^n)/3} dot u[n]
$
So the answer is:
$
  y[n] = y_1[n] + y_2[n] = 2delta[n+2] + delta[n+1] + {8/9(1/2)^n - (44/9 + 11/3 n)(-1)^n} dot u[n]
$
