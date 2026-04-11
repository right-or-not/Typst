#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-12-05" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "Third Exercise for Chapter 6" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(5.39)[
  An ideal linear-phase highpass digital filter has frequency function $H(Omega)$, where for one period, $H(Omega)$ is given by
  $
    H(Omega) = cases(
      e^(-j 3 Omega)"   "&", "pi"/"2 <= |Omega| <= pi,
      0 &", " 0 <= |Omega| < pi "/" 2
    )
  $
  *(a)* Determine the unit-pulse response $h[n]$ of the filter. \
  *(b)* Compute the output response $y[n]$ of the filter when the input $x[n]$ is given by: \
  #h(2em) *(i)* $x[n] = cos(pi n "/" 4), n = 0, plus.minus 1, plus.minus 2, dots$ \
  #h(2em) *(iv)* $x[n] = sinc(pi n "/" 4), n = 0, plus.minus 1, plus.minus 2, dots$ \
  #h(2em) *(vi)* $x[n] = sinc(pi n "/" 2) dot cos(pi n "/" 8), n = 0, plus.minus 1, plus.minus 2, dots$ \
  *(c)* For each signal defined in part (b), plot the input $x[n]$ and the corresponding output $y[n]$ to determine the effect of the filter.
]
#SOLUTION

*(a)* First, simplify the $H(Omega)$:
$
  H(Omega) = {e^(-j Omega 3) dot [p_(2pi)(Omega) - p_(pi)(Omega)]} * sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi)
$ 
We know that $h[n] = cal(F)^(-1){H(Omega)}$, so we just want to find a $gamma(t)$, for which $cal(F){gamma(t)} = H(omega) dot p_(2pi)(omega) = e^(-j omega 3) dot [p_(2pi)(omega) - p_(pi)(omega)] eq.delta Gamma(omega)$. So we will find:
$
  2pi dot gamma(-t) 
  &= cal(F){Gamma(omega)} = cal(F){e^(-j omega 3) dot [p_(2pi)(omega) - p_(pi)(omega)]} \
  &= cal(F){p_(2pi)(omega) - p_(pi)(omega)}(t + 3) \
  &= 2pi sinc(pi (t+3)) - pi sinc(pi/2 (t+3)) \ 
$
That is:
$
  gamma(t)
  &= sinc(pi(-t+3)) - 1/2 dot sinc(pi/2 (-t+3)) \
  &= sinc(pi(t-3)) - 1/2 sinc(pi/2 (t-3))
$
So:
$
  h[n] = gamma(n) = sinc[pi(n-3)] - 1/2 sinc[pi/2(n-3)]
$\

*(b)* For periodic signals $x[n]$, $y[n] = |H(Omega_0)|x_i [Omega_0 n + angle H(Omega_0)]$.

#h(2em) *(i)* For $x[n] = cos(pi n "/" 4)$, it is easy to get:
$
  y[n] = |H(pi / 4)| dot cos(pi/4 n + angle H(pi/4)) = 0
$

#h(3em) *(iv)* For $x[n] = sinc(pi n "/" 4)$, it is easy to get:
$
  y[n] = (|H(pi "/" 4)|)/(pi n"/"4) dot sin(pi/4 n + angle H(pi/4)) = 0
$

#h(3em) *(vi)* For $x[n] = sinc(pi n "/" 2) dot cos(pi n "/" 8)$, perform Fourier transform on it first:
$
  X(Omega) 
  &= cal(F){x[n]} = 1/(2pi) dot cal(F){sinc(pi n "/" 2)} * cal(F){cos(pi n"/"8)} \
  &= 1/(2pi) dot 2p_pi (Omega) * [pi delta(Omega - pi/8) + pi delta(Omega + pi/8)] \
  &= p_(pi)(Omega) * [delta(Omega - pi/8) + delta(Omega + pi/8)]", for" -pi <= Omega <= pi
$
#h(2em) So, for $-pi <= Omega <= pi$, we will get:
$
  Y(Omega) = X(Omega) dot H(Omega) = e^(-j Omega 3) dot p_(5pi"/"4)(Omega) dot [p_(2pi)(Omega) - p_(pi)(Omega)]
$
#h(2em) Then, perform inverse DTFT on $Y(Omega)$:
$
  y[n] 
  &= gamma(n) = cal(F)^(-1){Gamma(omega)} = cal(F)^(-1){Y(omega) dot p_(2pi)(omega)} \
  &= cal(F)^(-1){e^(-j omega 3) dot p_(5pi"/"4)(omega) dot [p_(2pi)(omega) - p_(pi)(omega)]} \
  &= cal(F)^(-1){e^(-j omega 3) dot [p_(5pi"/"4)(omega)  - p_(pi)(omega)]} \
  &= 5/8 sinc[(5pi)/8 (n-3)] - 1/2 sinc[(pi)/2 (n-3)]
$\

#pagebreak()
*(c)* Plot the figure with MATLAB:\
#h(2em) *(i)* $x[n] = cos(pi n"/"4)$, $y[n] = 0$.
#image("image/10_1_i.png")\
#h(2em) *(iv)* $x[n] = sinc(pi n"/"4)$, $y[n] = 0$.
#image("image/10_1_iv.png")\
#h(2em) *(vi)* 
$
  x[n] = sinc(pi n"/"2) dot cos(pi n"/"8) \
  y[n] = 5/8 sinc[(5pi)/8 (n-3)] - 1/2 sinc[(pi)/2 (n-3)]
$
#image("image/10_1_vi.png")



#pagebreak()
#problem(5.41)[
  As shown in Figure P5.41, a sampled version $x[n]$ of an analog signal $x(n)$ is applied to a linear time-invariant discrete-time system with frequency response function $H(Omega)$.
  #image("image/10_2.png", width: 70%)
  Choose the sampling interval $T$ and determine the frequency response function $H(Omega)$ so that
  $
    y[n] = cases(
      x[n]" "& ", when" x(t) = A cos(omega_0 t)" , "& 100 < omega_0 < 1000,
      0 & ", when" x(t) = A cos(omega_0 t)" ,  "& 0 <= omega_0 <= 100
    )
  $
  Express $H(Omega)$ in analytical form.
]
#SOLUTION

Record $T$ as $T_s$, we know that:
$
  omega_s = (2pi)/T_s >= 2 omega_("max") = 1000
$
So, we can get:
$
  T_s <= pi/(omega_"max") = pi/1000
$
Look at $y[n]$, $h[n]$ is a highpass filter obviously, we can get:
$
  H(Omega) = cases(
      1" , "& 100T_s < |Omega| < 1000T_s,
      0" ,  "& 0 <= |Omega| <= 100T_s
    )
$
If we choose 
$
  T_s = T = pi"/"1000
$
then:
$
  H(Omega) = cases(
      1" , "& pi"/"10 < |Omega| < pi,
      0" ,  "& 0 <= |Omega| <= pi"/"10
    )
$



#pagebreak()
#problem(5.45)[
  Consider the discrete-time system given by the input / output difference equation
  $
    y[n+1] + 0.9y[n] = 1.9x[n+1]
  $
  *(a)* Show that the impulse response is given by $h[n] = 1.9 dot (-0.9)^n dot u[n]$. \
  *(b)* Compute the frequency response function, and sketch the magnitude function $|H(Omega)|$, for $-pi <= Omega <= pi$. \
  *(c)* Compute the output response $y[n]$ to an input of $x[n] = 1 + sin(pi n "/" 4) + sin(pi n "/" 2)$. \
  *(d)* Compute the output response $y[n]$ result from the input $x[n] = u[n] - u[n-3]$. \
]
#SOLUTION

*(a)* Let $x[n] = delta[n]$, then we will get:
$
  h[n+1] + 0.9h[n] = 1.9delta[n+1]
$
Let $h[n] = 1.9 dot (-0.9)^n dot u[n]$,
$
  h[n+1] + 0.9h[n] 
  &= 1.9 dot (-0.9)^(n+1) dot u[n+1] + 0.9 dot 1.9 dot (-0.9)^n dot u[n] \
  &= 1.9 dot (-0.9)^(n+1) dot {u[n+1] - u[n]} \
  &= 1.9 dot (-0.9)^(n+1) dot delta[n+1] \
  &= 1.9 dot delta[n+1] \
$
So $h[n] = 1.9 dot (-0.9)^n dot u[n]$ is right.\
\

*(b)* 
Obviously,
$
  H(Omega) = cal(F){h[n]} = cal(F){1.9 dot (-0.9)^n dot u[n]} = 1.9/(1 + 0.9e^(-j Omega))
$
So,
$
  |H(Omega)| = 1.9/(sqrt((1+0.9cos Omega)^2 + (0.9sin Omega)^2)) = 1.9/(sqrt(1.81 + 1.8cos Omega))
$
sketch the Figure like following Figure 1.
#figure(image("image/10_3_b.png"), caption: [The magnitude function $|H(Omega)|$])\


*(c)* Let
$
  x[n] = x_1[n] + x_2[n] + x_3[n] = 1 + sin(pi n "/" 4) + sin(pi n "/" 2)
$
From part(b), we know that:
$
  H(Omega) = cal(F){h[n]} = cal(F){1.9 dot (-0.9)^n dot u[n]} = 1.9/(1 + 0.9e^(-j Omega))
$
So that:
$
  |H(Omega)| = 1.9/(sqrt((1+0.9cos Omega)^2 + (0.9sin Omega)^2)) = 1.9/(sqrt(1.81 + 1.8cos Omega)) \
  angle H(Omega) = arctan((1 + 0.9cos Omega)/(-0.9sin Omega))
$
Therefore:
$
  y_1[n] &= |H(0)|dot 1 = 1 \
  y_2[n] &= |H(pi"/"4)|dot sin(pi n"/"4 + angle H(pi"/"4)) \
  &= 1.9/(sqrt(1.81 + 0.9sqrt(2))) dot sin(pi n"/"4 + arctan(sqrt(2)+0.9)) \
  y_3[n] &= |H(pi"/"2)|dot sin(pi n"/"2 + angle H(pi"/"2)) \
  &= 1.9/(sqrt(1.81)) dot sin(pi n"/"4 + arctan(-10/9)) \
$
That is:
$
  y[n] 
  &= y_1[n] + y_2[n] + y_3[n] \
  &= 1 + 1.9/(sqrt(1.81 + 0.9sqrt(2))) dot sin(pi n"/"4 + arctan(sqrt(2)+0.9)) \
  &"     "+ 1.9/(sqrt(1.81)) dot sin(pi n"/"4 + arctan(-10/9)) \
$\


*(d)* Obviously, $x[n] = u[n] - u[n-3]$ is aperiodic, so we do the DFTF on it first:
$
  X(Omega) = {pi sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi) + 1/(1 - e^(-j Omega))} dot (1 - e^(-j Omega 3))
$
So, we can get:
$
  Y(Omega) = X(Omega) dot H(Omega)
$
Here, we simplify it: because $x[n]$ is a linear time-invariant system, so let $y[n] = v[n] - v[n - 3]$, where $v[n]$ is the output with the input $u[n]$.
$
  U(Omega) = pi sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi) + 1/(1 - e^(-j Omega))
$
So,
$
  V(Omega) = U(Omega) dot H(Omega) = {pi sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi) + 1/(1 - e^(-j Omega))} dot 1.9/(1 + 0.9e^(-j Omega))
$
Simplify it:
$
  V(Omega) = pi sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi) + 1/(1 - e^(-j Omega)) dot 1.9/(1 + 0.9e^(-j Omega))
$
Let:
$
  1/(1 - e^(-j Omega)) dot 1.9/(1 + 0.9e^(-j Omega)) = a/(1 - e^(-j Omega)) + b/(1 + 0.9e^(-j Omega))
$
we will get:
$
  cases(
    0.9a - b = 0,
    a + b = 1.9
  )
$
the solution is:
$
  cases(
    a = 1,
    b = 0.9
  )
$
So, 
$
  V(Omega) = pi sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi) + 1/(1 - e^(-j Omega)) + 0.9/(1 + 0.9e^(-j Omega))
$
Then we can perform inverse DTFT on $V(Omega)$:
$
  v[n] = u[n] + 0.9dot (-0.9)^n dot u[n]
$
So that:
$
  y[n] 
  &= v[n] - v[n-3] \
  &= {u[n] + 0.9dot (-0.9)^n dot u[n]} - {u[n-3] + 0.9dot (-0.9)^(n-3) dot u[n-3]}
$





#pagebreak()
#problem(4)[
  Let $x[n]$ and $h[n]$ be two finite-length discrete signal given by:
  $
    x[n] = [1, 2, 3], "for" n = 0, 1, 2. \
    h[n] = [1, 1, 1], "for" n = 0, 1, 2. \
  $
  *(a)* Compute the 5-point circular convolution $y_C [n] = x[n] convolve.o h[n]$ (circular convolution of length 5). \
  *(b)* Compute the 5-point DFT of $x[n]$ and $h[n]$ (i.e., $X[k]$ and $H[k]$, for $k = 0, 1, dots, 4$). Then compute the inverse DFT of the product $X[k]H[k]$ and verify that it equals $y_C [n]$ from part(a). \
  *(c)* Compute the linear convolution $y_L [n] = x[n] * h[n]$. Compare $y_L [n]$ with $y_C [n]$ from part(a). Under what condition does the circular equal the linear convolution for these two signals? 
]
#SOLUTION

*(a)* Before compute 5-point circular convolution, we should add 0 in $x[n]$ and $h[n]$.
$
  x[n] = [1, 2, 3, 0, 0], "for" n = 0, 1, 2, 3, 4. \
  h[n] = [1, 1, 1, 0, 0], "for" n = 0, 1, 2, 3, 4. \
$
Then use multiplication:

#table(
  columns: 9,
  align: center,
  stroke: none,
  "", "", "", "", "1", "2", "3", "0", "0",
  "", "", "", $convolve.o$, "1", "1", "1", "0", "0",
  table.hline(),
  "", "", "", "", "0", "0", "0", "0", "0",
  "", "", "", "0", "0", "0", "0", "0", "",
  "", "", "1", "2", "3", "0", "0", "", "",
  "", "1", "2", "3", "0", "0", "", "", "",
  "1", "2", "3", "0", "0", "", "", "", "",
  table.hline(),
  "", "", "", "", "0", "0", "0", "0", "0",
  "", "", "", "", "0", "0", "0", "0", "0",
  "", "", "", "", "3", "0", "0", "1", "2",
  "", "", "", "", "0", "0", "1", "2", "3",
  "", "", "", "", "0", "1", "2", "3", "0",
  table.hline(),
  "", "", "", "", "3", "1", "3", "6", "5",
)

So, the answer is:
$
  y_C [n] = [1, 3, 6, 5, 3]
$

*(b)* Compute $X[k]$ first:
$
  X[k] = "DFT"{x[n]} 
  &= sum_(n=0)^4 x[n] dot W_5^(k n) \
  &= sum_(n=0)^2 x[n] dot W_5^(k n) = W_5^(0) + 2W_5^(k) + 3W_5^(2k)
$
Then, compute $H[k]$:
$
  H[k] = "DFT"{h[n]}
  &= sum_(n=0)^4 h[n] dot W_5^(k n) \
  &= sum_(n=0)^2 h[n] dot W_5^(k n) = W_5^(0) + W_5^(k) + W_5^(2k)
$
So, 
$
  Y[k] = X[k] dot H[k] = (W_5^(0) + 2W_5^(k) + 3W_5^(2k)) dot (W_5^(0) + W_5^(k) + W_5^(2k))
$
Then, perform inverse DFT on $Y[k]$, we will get:
$
  y[n] = sum_(k = 0)^(4)Y[k] dot W_5^(-k n)
$
The answer is alse:
$
  y[n] = [1, 3, 6, 5, 3]
$
Obviously, $y[n] eq.triple y_C [n]$

*(c)* Use multiplication:

#table(
  columns: 5,
  align: center,
  stroke: none,
  "", "", "1", "2", "3",
  "", $convolve$, "1", "1", "1",
  table.hline(),
  "", "", "1", "2", "3",
  "", "1", "2", "3", "",
  "1", "2", "3", "", "",
  table.hline(),
  "1", "3", "6", "5", "3"
)

S0, the answer is:
$
  y_L [n] = [1, 3, 6, 5, 3]
$
Obviously, $y_C [n] eq.triple y_L [n]$.

When perform $N$-circular convolution on $x_1[n]$ and $x_2[n]$, if you make $N >= "length"(x_1[n]) + "length"(x_2)[n] - 1$, the circular convolution is equal to linear one.


