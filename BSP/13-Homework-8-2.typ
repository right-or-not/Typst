#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-12-28" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "Second Exercise for Chapter 8" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(1)[
  When the input to an LTI system is 
  $
    x[n] = (1/3)^n u[n] + (2)^n u[-n-1],
  $
  the corresponding output is
  $
    y[n] = 5(1/3)^n u[n] - 5(2/3)^n u[n].
  $
  *(a)* Find the system function $H(z)$ of the system. Plot the pole(s) and zero(s) of $H(z)$ and indicate the ROC. \
  *(b)* Find the impulse response $h[n]$ of the system. \
  *(c)* Write a difference equation that is satisfied by the given input and output. \
  *(d)* Is the system stable? Is it causal?
]
#SOLUTION

*(a)* For $x[n]$, perform the z-transform:
$
  X(z) 
  &= sum_(n=-oo)^(oo) x[n] z^(-n) \
  &= sum_(n=0)^(oo) (1/3)^n z^(-n) + sum_(n=-oo)^(-1) (2)^n z^(-n) \
  &= sum_(n=0)^(oo) (1/3)^n z^(-n) + sum_(n=1)^(oo) (1/2)^n z^(n) \
  &= sum_(n=0)^(oo) (1/3)^n z^(-n) + sum_(n=0)^(oo) (1/2)^n z^(n) - 1 \
  &= (3z)/(3z - 1) + 2/(2-z) - 1 \
  &= (-5z)/((3z-1)(z-2))
$
For which, the ROC is 
$
  1/3 < abs(z) < 2
$
Likewise, for $y[n]$:
$
  Y(z) 
  &= sum_(n=-oo)^(oo) y[n] z^(-n) \
  &= sum_(n=0)^(oo) 5(1/3)^n z^(-n) - sum_(n=0)^(oo) 5(2/3)^n z^(-n) \
  &= 5 sum_(n=0)^(oo) (1/3)^n z^(-n) - 5 sum_(n=0)^(oo) (2/3)^n z^(-n) \
  &= (15z)/(3z - 1) - (15z)/(3z - 2) \
  &= (-15z)/((3z-1)(3z-2))
$
For which, the ROC is
$
  abs(z) > 2/3
$
Thus, the system function $H(z)$ is
$
  H(z) = Y(z)/X(z) = (3(z-2))/(3z-2)
$
For which, the pole is at $z = 2"/"3$ and the zero is at $z = 2$. The ROC is
$
  abs(z) > 2/3
$\
\

*(b)* The impulse response $h[n]$ can be found by performing the inverse z-transform of $H(z)$:
$
  H(z)/z = (3z-6)/(z(3z-2)) = c_1/z + c_2/(3z-2)
$
For which, we have
$
  c_1 = "Res"[H(z)/z; z = 0] = lim_(z -> 0) (3z-6)/(3z-2) = 3 \
  c_2 = "Res"[H(z)/z; z = 2/3] = lim_(z -> 2/3) (3z-6)/(z) = -6 \
$
So,
$
  H(z)/z = 3/z - 6/(3z-2)
$
That is:
$
  H(z) 
  &= 3 + (-2)/(1 - 2/3z^(-1)) = 3 + (-2)sum_(n=0)^(oo) (2/3)^n z^(-n) \
  &= sum_(n = -oo)^(oo) {3delta[n] - 2(2/3)^n u[n]} z^(-n)
$
Thus, the impulse response is
$
  h[n] = 3delta[n] - 2(2/3)^n u[n]
$\
\

*(c)* The difference equation can be found by rewriting $H(z)$:
$
  H(z) = Y(z)/X(z) = (3(z-2))/(3z-2)
$
That is:
$
  (3z - 2)Y(z) &= 3(z-2)X(z) \
  3z Y(z) - 2Y(z) &= 3z X(z) - 6X(z) \
$
So the difference equation is
$
  3y[n] - 2y[n-1] = 3x[n] - 6x[n-1]
$\
\

*(d)* The ROC of $H(z)$ is
$
  abs(z) > 2/3
$
So the system is stable.

Also, since
$
  h[n] = 3delta[n] - 2(2/3)^n u[n]
$
For all $n < 0$, $h[n] = 0$. So the system is causal.




#pagebreak()
#problem(2)[
  If the input $x[n]$ to an LTI system is $x[n] = u[n]$, the output is 
  $
    y[n] = (1/2)^(n-1) u[n+1].
  $
  *(a)* Find $H(z)$, the z-transform of the system impulse response, and plot its pole-zero diagram. \
  *(b)* Find the impulse response $h[n]$. \
  *(c)* Is the system stable? \
  *(d)* Is the system causal?
]
#SOLUTION

*(a)* For $x[n] = u[n]$:
$
  X(z) = sum_(n=0)^(oo) z^(-n) = 1/(1 - z^(-1)) = z/(z-1)
$
For which, the ROC is $abs(z) > 1$.

For $y[n]$:
$
  Y(z) 
  &= sum_(n=-oo)^(oo) (1/2)^(n-1) u[n+1] z^(-n) \
  &= sum_(n=-1)^(oo) (1/2)^(n-1) z^(-n) \
  &= 4z + 2 dot sum_(n=0)^(oo) (1/2)^n z^(-n) \
  &= 4z + 2/(1 - (1/2)z^(-1)) \
  &= 4z + (4z)/(2z - 1) \
  &= (8z^2)/(2z - 1)
$
For which, the ROC is $abs(z) > 1"/"2$.

Thus, the system function $H(z)$ is
$
  H(z) = Y(z)/X(z) = (8z(z-1))/(2z-1)
$
For which, the ROC is $abs(z) > 1"/"2$. The pole is at $z = 1"/"2$ and the zero is at $z = 1$ and $z = 0$.
#pagebreak()
Plot plot-zero diagram:
#image("image/13_2_1.jpg", width: 50%)




*(c)* ROC of $H(z)$ is $abs(z) > 1"/"2$, so the system is stable.

*(d)* Since for all $n = -1$, $h[-1] = 4 eq.not 0$, the system is uncausal.





#pagebreak()
#problem(3)[
  The pole-zero diagram in Figure 1 corresponds to the z-transform $X(z)$ of a causal sequence $x[n]$. Sketch the pole-zero diagram of $Y(z)$, where $y[n] = x[-n+3]$. Also, specify the ROC of $Y(z)$.
  #image("image/13_3.png", width: 60%)
]
#SOLUTION

We all know that for a causal sequence $x[n]$:
$
  X(z) = sum_(n=0)^(oo) x[n] z^(-n)
$
Therefor for $y[n] = x[-n+3]$, we have:
$
  Y(z) 
  &= sum_(n=-oo)^(oo) y[n] z^(-n) \
  &= sum_(n=-oo)^(oo) x[-n+3] z^(-n) \
  &= sum_(m=-oo)^(oo) x[m] z^(m-3) quad (m = -n + 3) \
  &= z^(-3) sum_(m=-oo)^(oo) x[m] z^(m) \
  &= z^(-3) sum_(m=-oo)^(oo) x[m] (z^(-1))^(-m) \
  &= z^(-3) X(1/z)
$
From Figure 1, we know that the poles of $X(z)$ are at
$
  z_1 = -3/4,"    " z_2 = (1+j)/2,"    " z_3 = (1-j)/2
$
So the poles of $Y(z)$ are at
$
  1/z_1 = -3/4,"    " 1/z_2 = (1+j)/2,"    " 1/z_3 = (1-j)/2
$
That is:
$
  z_1 = -4/3,"    " z_2 = 1 + j,"    " z_3 = 1 - j
$
So the pole-zero diagram of $Y(z)$ is as follows: 
#image("image/13_3_ans.jpg", width: 60%)

Because $x[n]$ is causal, the ROC of $X(z)$ is
$
  abs(z) > 3/4
$
So the ROC of $Y(z)$ is
$
  abs(z) < 4/3
$





#pagebreak()
#problem(4)[
  Given the system functions of two digital filters: \
  *IIR Filter*:
  $
    H_("IIR")(z) = (0.2 + 0.4 z^(-1) + 0.2z^(-2))/(1 - 0.5z^(-1) + 0.3z^(-2))
  $
  *FIR Filter*:
  $
    H_("FIR")(z) = 0.25 + 0.5 z^(-1) + 0.25z^(-2)
  $
  *(1)* Plot the magnitude frequency responses $H(Omega)$ of both filters (from $0$ to $pi$ radians) \
  *(2)* Determine the type of each filter (low-pass, high-pass, band-pass, or band-stop) \
  *(3)* Given the input signal: $x[n] = sin(0.1 pi n) + 0.5 sin(0.5 pi n), n = 0, 1, dots, 100$. Compute the output signals $y_("IIR")[n]$ and $y_("FIR")[n]$ for both filters; Plot the input signal, IIR output, and FIR output in MATLAB.
]
#SOLUTION

*(1)* Plot the magnitude frequency responses of both filters in MATLAB:
#image("image/13_4_1.png", width: 70%)

*(2)* From the above figure, we can see that the IIR filter is a low-pass filter, and the FIR filter is a band-pass filter. Let us prove it:

For the IIR filter:
$
  H(z) = (2(z+1)^2)/(10z^2 -5z^2 - 3)
$
So, let $z = e^(j Omega)$, we have:
$
  abs(H(Omega)) = (2abs((e^(j Omega) + 1)^2))/abs(10e^(j 2Omega) -5e^(j Omega) - 3) eq.delta (2abs(A(Omega))^2)/(abs(B(Omega))^2)
$
Where:
$
  abs(A(Omega)) = abs(1 + e^(j Omega)) = abs(e^(j 1/2 Omega)) dot abs(e^(-j 1/2 Omega) + e^(j 1/2 Omega)) = 2abs(cos(1/2 Omega)) \
  abs(B(Omega))^2 = B(Omega) dot B(Omega)^* = 134 - 70cos(Omega) - 60cos(2Omega)
$
Thus,
$
  abs(H(Omega)) = (4[cos(Omega) + 1])/(sqrt(134 - 70cos(Omega) - 60cos(2Omega)))
$
let $Omega = 0$, $abs(H(Omega)) = 4$. \
let $Omega = pi$, $abs(H(Omega)) = 0$. \
So the IIR filter is a low-pass filter.

For the FIR filter:
$
  H(z) = (1/4)(z^2 + 2z + 1)/z^2 = (1/4)(1 + z^(-1))^2
$
So,
$
  abs(H(Omega)) = (1/4)abs(1 + e^(-j Omega))^2 eq.delta (1/4)abs(2cos(1/2 Omega))^2 = (cos(Omega) + 1)/2
$
let $Omega = 0$, $abs(H(Omega)) = 1$. \
let $Omega = pi"/"2$, $abs(H(Omega)) = 1/2$. \
let $Omega = pi$, $abs(H(Omega)) = 0$. \
So the FIR filter is a low-pass filter.\

*(3)* Compute the output signals in MATLAB:
#image("image/13_4_2.png", width: 100%)