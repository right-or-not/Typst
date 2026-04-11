#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-11-14" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "Second Exercise for Chapter 5" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(5.23)[
  An ideal linear-phase bandpass filter has frequency response
  $
    H(omega) = cases(
      10e^(-j 4 omega)",    "& -4 < omega < -2", "2 < omega < 4,
      0"," & "all other "omega
    )
  $
  Compute the output response $y(t)$ of the filter when the input $x(t)$ is \
  *(c)* $x(t) = sinc(4t), -infinity < t < infinity$ \
  *(g)* $x(t) = sinc^2(t) cos(2t), -infinity < t < infinity$ \
  Plot $x(t)$ and the correspongding output $y(t)$ for each of the cases computed (c) and (g). Use a small-enough time increment on the plot to capture the high-frequency content of the signal.
]
#SOLUTION

*(c)* First, simplify the $H(omega)$:
$
  H(omega)
  & = cases(
    10e^(-j 4 omega)",    "& -4 < omega < -2", "2 < omega < 4,
    0"," & "all other "omega
  ) \
  & = 10e^(-j 4 omega) dot [p_8 (omega) - p_4 (omega)]
$
Then, compute the Fourier transform of $x(t)$:
$
  X(omega) 
  &= cal(F){x(t)} = (2pi)/8 p_8 (omega)
$
So we will get $Y(omega)$:
$
  Y(omega) 
  &= X(omega) dot H(omega) = 10e^(-j 4 omega) dot (2pi)/8 dot p_8 (omega) dot [p_8 (omega) - p_4 (omega)] \
  &= 10e^(-j 4 omega) dot (2pi)/8 dot p_8 (omega) - 10e^(-j 4 omega) dot (2pi)/8 dot p_4 (omega) \
$
Finally, perform the inverse Fourier transform on $Y(omega)$:
$
  y(t+4) 
  &= cal(F)^(-1){e^(j 4 omega) dot Y(omega)} \
  &= cal(F)^(-1){10 dot (2pi)/8 dot p_8 (omega) - 10 dot (2pi)/8 dot p_4 (omega)} \
  &= 10 sinc(4t) - 5 sinc(2t)
$
That is:
$
  y(t) = 10 sinc(4t - 16) - 5 sinc(2t - 8)
$
Plot the figure of $x(t)$ and the output $y(t)$ with MATLAB:
#image("image/07_1_(c).png")\



*(g)* Like (c) get $H(omega)$ first:
$
  H(omega) = 10 e^(-j 4 omega) dot [p_8(omega) - p_4(omega)]
$
Then, compute the Fourier transform of $x(t)$:
$
  X(omega)
  &= cal(F){x(t)} = cal(F){sinc^2(t)cos(2t)}\
  &= (1/(2pi))^2 dot cal(F){sinc(t)} * cal(F){sinc(t)} * cal(F){cos(2t)}\
  &= (1/(2pi))^2 dot pi p_2(omega) * pi p_2(omega) * [pi delta(omega - 2) + pi delta(omega + 2)] \
  &= pi/4 dot Lambda_2(omega) * [delta(omega - 2) + delta(omega + 2)] \
$
So, we will get $Y(omega)$:
$
  Y(omega) = X(omega) dot H(omega) = (5pi)/2 e^(-j 4 omega) dot [Lambda_2(omega - 2) + Lambda_2(omega + 2)] dot [p_8(omega) - p_4(omega)]
$
However, the expression is too difficult to culculate, we can simplify it:
$
  Y(omega) = X(omega) dot H(omega) = (5pi)/2 e^(-j 4 omega) dot Lambda_4(omega) dot [p_8(omega) - p_4(omega)]
$
Finally, perform the inverse Fourier transform on $Y(omega)$:
$
  y(t + 4)
  &= cal(F)^(-1){e^(j 4 omega) dot Y(omega)} \
  &= cal(F)^(-1){(5pi)/2 dot Lambda_4(omega) dot [p_8(omega) - p_4(omega)]} \
  &= (5pi)/2 dot cal(F)^(-1){Lambda_4(omega) - Lambda_2(omega) - p_4(omega)} \
  &= (5pi)/2 dot {16/(2pi) dot sinc^2(2t) - 4/(2pi) dot sinc^2(t) - 4/(2pi) dot sinc(2t)} \
  &= 20sinc^2(2t) - 5sinc^2(t) - 5sinc(2t) \
$
That is:
$
  y(t) = 20sinc^2(2t - 8) - 5sinc^2(t - 4) - 5sinc(2t - 8)
$
Plot the figure of $x(t)$ and the output $y(t)$ with MATLAB:
#image("image/07_1_(g).png")

#text(fill: rgb(255, 0, 0))[
  Correction: 
  $
    Lambda_4(omega) dot [p_8(omega) - p_4(omega)] = Lambda_4(omega) - Lambda_2(omega) - 2p_4(omega)
  $
  So the answer is: 
  $
    y(t) = 20sinc^2(2t - 8) - 5sinc^2(t - 4) - 10sinc(2t - 8)
  $
]\







#pagebreak()
#problem(5.29)[
  Consider the system in Figure P5.29, where $p(t)$ is an impulse train with period $T$ and $H(omega) = T p_2(omega)$. Compute $y(t)$ when
  #image("image/07_2.png", width: 70%)
  *(a)* $x(t) = sinc^2(t"/"2)$ for $-infinity < t < infinity, T = pi$\
  *(b)* $x(t) = sinc^2(t"/"2)$ for $-infinity < t < infinity, T = 2pi$\
  *(c)* For (a) and (b), compare the plots of $x(t)$ and the correspongding $y(t)$.\
  *(d)* Repeat part (a), using the interpolation formula to solve for $y(t)$, and plot your results with $n$ ranging from $n = -5$ to $n = 5$.
]
#SOLUTION

*(a)* sample the signal first:
$
  x_s (t) = x(t) dot p(t) = sinc^2(t"/"2) dot sum_(k = -infinity)^(infinity) delta(t - k T)
$
Then, perform the Fourier transform on $x_s (t)$:
$
  X_s (omega) 
  &= cal(F){x_s (t)} = 1/(2pi) X(omega) * P(omega) \
  &= (1/(2pi))^2 dot 2pi p_1(omega) * 2pi p_1(omega) * (2pi)/T sum_(k = -infinity)^(infinity) delta(omega - k omega_0) \
  &= (2pi)/T dot p_1(omega) * p_1(omega) * sum_(k = -infinity)^(infinity) delta(omega - k omega_0) \
$
where $omega_0 = 2pi "/" T = 2$.

So, we will get $Y(omega)$:
$
  Y(omega) 
  &= X_s (omega) dot H(omega) \
  &= (2pi)/T dot p_1(omega) * p_1(omega) * sum_(k = -infinity)^(infinity) delta(omega - 2k) dot T p_2(omega) \
  &= 2pi dot p_1(omega) * p_1(omega)
$
perform the inverse Fourier transform to $Y(omega)$:
$
  2pi dot y(-t) = cal(F){Y(omega)} = 2pi dot cal(F){p_1(omega)} dot cal(F){p_1(omega)} = 2pi sinc^2(t "/" 2)
$
That is:
$
  y(t) = sinc^2(t"/"2) = x(t)
$\


*(b)* Like (a), we can get $X_s (omega)$ easily:
$
  X_s (omega) = 1/T dot p_1(omega) * p_1(omega) * sum_(k = -infinity)^(infinity) delta(omega - k omega_0)
$
where $omega_0 = 2 pi "/" T = 1$.

So, we will get $Y(omega)$:
$
  Y(omega)
  &= (2pi)/T dot p_1(omega) * p_1(omega) * sum_(k = -infinity)^(infinity) delta(omega - k) dot T p_2(omega) \
  &= 2pi p_2(omega)
$
perform the inverse Fourier transform on $Y(omega)$:
$
  2pi dot y(-t) = cal(F){Y(omega)} = 2pi dot cal(F){p_2(omega)} = 4pi sinc(t)
$
That is:
$
  y(t) = 2sinc(t)
$\

*(c)* According to the formula, it is obviously that: for (a), $y(t) = x(t)$, while for (b), $y(t) eq.not x(t)$. Let's plot the $x(t)$ and $y(t)$ here.

First, it is the figure of $x(t)$ and $y(t)$ in part (a):
#image("image/07_2_(c)_1.png", width: 100%)
Obviously, figure of $x(t)$ is same as figure of $y(t)$.

Then is the figure of $x(t)$ and $y(t)$ in part (b):
#image("image/07_2_(c)_2.png", width: 100%)
Obviously, figure of $x(t)$ is different from figure of $y(t)$.

#v(20pt)
*(d)* Using the interpolation formula:
$
  y(t) = (B T)/pi sum_(-infinity)^(infinity) x(n T) sinc(B(t - n T))
$
where $B = 1$ and $T = pi$. So,
$
  y(t) = sum_(-infinity)^(infinity) x(n pi) sinc(t - n pi)
$
Plot the figure with MATLAB when n is -5 to 5:
$
  y(t) = sum_(n = -5)^(5) x(n pi) sinc(t - n pi)
$
#image("image/07_2_(d).png")






#pagebreak()
#problem(5.36)[
  Consider the following sampling and reconstruction configuration:
  #image("image/07_3_1.png", width: 80%)
  You can find the output $y(t)$ of the ideal reconstruction by sending the sampled signal $x_s (t) = x(t) p(t)$ through an ideal lowpass filter with the frequency response function
  #image("image/07_3_2.png", width: 30%)
  Let $x(t) = 1 + cos(20pi t) + cos(60pi t)$ and $T = 0.01$ sec. \
  *(a)* Draw $|X_s (omega)|$, where $x_s (t) = x(t) p(t)$. Determine if aliasing occurs. \
  *(b)* Determine the expression for $y(t)$.
]
#SOLUTION

*(a)* compute $x_s (t)$ first:
$
  x_s (t) 
  &= x(t) dot p(t) \
  &= {1 + cos(20pi t) + cos(60pi t)} dot 1/T dot sum_(k = -infinity)^(infinity) e^(j k omega_0 t)
$
perform the Fourier transform on $x_s (t)$:
$
  X_s (omega) 
  &= cal(F){x_s (t)} \
  &= 1/(2pi) dot {2pi delta(omega) + pi delta(omega plus.minus 20pi) + pi delta(omega plus.minus 60pi)} * (2pi)/T sum_(k = -infinity)^(infinity) delta(omega - k omega_0) \
  &= 1/T dot {2pi delta(omega) + pi delta(omega plus.minus 20pi) + pi delta(omega plus.minus 60pi)} * sum_(k = -infinity)^(infinity) delta(omega - k omega_0) \
$
where $omega_0 = 200pi$. So, 
$
  X_s (omega) = 1/T dot {2pi delta(omega) + pi delta(omega plus.minus 20pi) + pi delta(omega plus.minus 60pi)} * sum_(k = -infinity)^(infinity) delta(omega - 200k pi)
$
Draw the figure with MATLAB:
#image("image/07_3_(a).png", width: 90%)
Obviously, there is no aliasing occurs.


*(b)* because there is no occurs, and the sampling-rate $omega_s > 2 omega = 120pi$, so the output $y(t)$ is equal to the original signal $x(t)$. That is:
$
  y(t) = x(t) = 1 + cos(20pi t) + cos(60pi t)
$