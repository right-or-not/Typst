#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-10-30" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "First Exercise for Chapter 5" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(1)[
  The frequency response of a system is given by:
  $
    H(omega) = (sin^2(3omega) dot cos omega)/(omega^2)
  $
  Find its unit impulse response $h(t)$.
]
#SOLUTION

Obviously, 
$
  h(t) = cal(F)^(-1){H(omega)}
$
However, the integral is difficult to compute, so we use the properties of Fourier transform:
$
  cal(F){H(omega)} = 2pi h(-t)
$
Then, 
$
  cal(F){H(omega)} 
  &= cal(F){(sin^2(3omega) dot cos omega)/(omega^2)} = cal(F){9 dot (sin^2(3omega))/((3omega)^2)dot cos omega}\
  &= 9 dot 1/(4pi^2) dot cal(F){sinc(3omega)} * cal(F){sinc(3omega)} * cal(F){cos omega}\
$
Among which, because
$
  cal(F){p_tau (t)} = tau dot sinc(omega tau "/" 2) ==> cal(F){tau dot sinc(omega tau "/" 2)} = 2pi p_tau (-t) = 2pi p_tau (t)
$
therefore, let $tau = 6$,
$
  cal(F){sinc(3omega)} = 1/6 dot 2pi p_6 (t)
$
and
$
  cal(F){cos(omega)} = 1/2 dot cal(F){e^(j omega) + e^(-j omega)} = 1/2 dot [2pi delta(t-1) + 2pi delta(t+1)]
$
So,
$
  cal(F){H(omega)} = 9 dot 1/(4pi^2) dot pi^2/9 dot pi dot  p_tau (t) * p_tau (t) * [delta(t-1) + delta(t+1)] = 2pi h(-t)
$
That is:
$
  h(t) = 1/8 dot p_tau (t) * p_tau (t) * [delta(t+1) + delta(t-1)]
$
Let's define $Lambda_tau (t) = p_tau (t) * p_tau (t)$, that is:
$
  Lambda_tau (t) = cases(
    tau - |t|"   "&", "-tau < t < tau,
    0&", others"
  )
$
Then, the answer is:
$
  h(t) 
  &= 1/8 dot Lambda_6 (t) * [delta(t+1) + delta(t-1)]\
  &= 1/8 dot [Lambda_6 (t+1) + Lambda_6 (t-1)]
$




#pagebreak()
#problem(2)[
  Consider the system with the frequency response given by 
  $
    H(omega) = 10/(j omega + 10)
  $
  *(a)* Given the output to $x(t) = 2 + 2cos(50t + pi "/" 2)$.\
  *(b)* Sketch $|H(omega)|$.\
  *(c)* Sketch the response of the filter to an input of $x(t) = 2e^(-2t) dot cos(4t) dot u(t) + e^(-2t) cos(20t) dot u(t)$. (See Figure P5.4.)\
  #image("image/06_2.png", width: 100%)
]
#SOLUTION

*(a)* Obviously,
$
  |H(omega)| = 10/sqrt(10^2 + omega^2)",  "angle H(omega) = arctan(-omega/10)
$

$because x(t) = 2 + 2cos(omega t + pi "/" 2) = 2 - 2sin(omega t)$, $omega = 50$\
$therefore y(t) = 2 dot |H(0)| - 2 dot |H(50)|dot sin(50t + angle H(50)) = 2 - 2/sqrt(26) dot sin(50t - arctan(5))$.

*(b)* Like part(a), we will get:
$
  |H(omega)| = 10/sqrt(10^2 + omega^2)
$
Then, sketch the figure of $|H(omega)|$:
#image("image/06_2_b.png", width: 100%)

*(c)* Use MATLAB to sketch the figure:
#image("image/06_2_c.png", width: 100%)


#pagebreak()
#problem(3)[
  A linear time-invariant continuous-time system has the frequency function $H(omega)$. It is known that the input
  $
    x(t) = 1 + 4cos(2pi t) + 8sin(3pi t - 90 degree)
  $
  produces the response
  $
    y(t) = 2 - 2 sin(2pi t)
  $
  *(a)* For what values of $omega$ is it possible to determine $H(omega)$?\
  *(b)* Compute $H(omega)$ for each of the values of $omega$ determined in part(a).
]
#SOLUTION

*(a)* $omega = 0, plus.minus 2pi, plus.minus 3pi$

*(b)* As we known:
$
  cases(
    x_1 (t) = 1,
    x_2 (t) = 4cos(2pi t),
    x_3 (t) = -8 cos(3pi t)
  )"          "
  cases(
    y_1(t) = 2,
    y_2(t) = 2cos(2pi t - pi "/"2),
    y_3(t) = 0,
  )
$
So:
$
  cases(
    |H(0)| = 2",   "& angle H(0) = 0,
    |H(2pi)| = 1"/"2",   "& angle H(2pi) = 90degree,
    |H(3pi)| = 0
  )
$
Then it's easy to get :
$
  H(0) = 2\
  H(2pi) = 1/2 j", "H(-2pi) =-1/2 j\
  H(3pi) = H(-3pi) = 0
$



#pagebreak()
#problem(4)[
  A causal linear time-invariant system is characterized by the following differential equation relaing its input and output:
  $
    ("d"^2 y(t))/("d"t^2) + 6 ("d"y(t))/("d"t) + 8y(t) = 2x(t)
  $
  *(a)* Determine the unit impulse response of the system.\
  *(b)* if $x(t) = t e^(-2t) dot u(t)$, what is the response of the system?
]
#SOLUTION

*(a)* Perform Fourier transform on the above equation:
$
  (j omega)^2 Y(omega) + 6(j omega)Y(omega) + 8Y(omega) = 2X(omega)
$
because:
$
  X(omega) dot H(omega) = Y(omega)
$
therefore:
$
  H(omega) = (Y(omega))/(X(omega)) = (2Y(omega))/((j omega)^2 Y(omega) + 6(j omega)Y(omega) + 8Y(omega)) = 2/((j omega)^2 + 6(j omega) + 8)
$
Simplify the above equation:
$
  H(omega) = 2/((j omega + 2)dot (j omega + 4)) = 1/(j omega + 2) - 1/(j omega + 4)
$
So the unit impulse response of the system $h(t)$ is:
$
  h(t) = cal(F)^(-1){H(omega)} = e^(-2t)dot u(t) - e^(-4t) dot u(t)
$\

*(b)* because:
$
  cal(F){e^(-2t)dot u(t)} = 1/(j omega + 2)
$
therefore:
$
  X(omega) = cal(F){t e^(-2t)dot u(t)} = j dot ("d")/("d"omega) dot 1/(j omega + 2) = 1/((j omega + 2)^2)
$
Then, we will get $Y(omega)$:
$
  Y(omega) = X(omega) dot H(omega) = 1/((j omega + 2)^3) - 1/((j omega + 2)^2 dot (j omega + 4))
$
Simplify the above equation:
$
  Y(omega) = X(omega) dot H(omega) = 1/(2!) dot 2!/((j omega + 2)^3) - [1/2 dot 1/((j omega + 2)^2) - 1/4 dot 1/(j omega + 2) + 1/4 dot 1/(j omega + 4)]
$
Do the inverse Fourier transform:
$
  y(t) = cal(F)^(-1){Y(omega)} 
  &= 1/2 dot t^2 e^(-2t) dot u(t) - [1/2dot t e^(-2t) - 1/4 dot e^(-2t) + 1/4 dot e^(-4t)] dot u(t)\
  &= -1/4 dot e^(-4t)dot u(t) + (1/2 t^2 - 1/2t +1/4)dot e^(-2t) dot u(t)
$





#pagebreak()
#problem(5)[
  There is a causal linear time-invariant system with frequency response
  $
    H(omega) = 1 / (j omega + 3)
  $
  For a specific input $x(t)$, the output of the system is observed to be:
  $
    y(t) = e^(-3t) dot u(t) - e^(-4t) dot u(t)
  $
  Find $x(t)$.
]
#SOLUTION

Perform Fourier transform on $y(t)$:
$
  Y(omega) = cal(F){y(t)} = 1/(j omega + 3) - 1/(j omega + 4)
$
So:
$
  X(omega) = (Y(omega))/(H(omega)) = 1-(j omega + 3)/(j omega + 4) = 1/(j omega + 4)
$
Then, perform inverse Fourier transform:
$
  x(t) = cal(F)^(-1){X(omega)} = e^(-4t) dot u(t)
$






#pagebreak()
#problem(6)[
  Let the Fourier transform of $x(t)$ be
  $
    X(omega) = delta(omega) + delta(omega - pi) + delta(omega - 5)
  $
  And let 
  $
    h(t) = u(t) - u(t-2)
  $
  Questions:\
  *(a)* Is $x(t)$ periodic?\
  *(b)* Is $x(t) * h(t)$ periodic?\
  *(c)* Can the convolution of two aperiodic signals be periodic?
]
#SOLUTION

*(a)* Assume $x(t)$ is periodic, then $exists T > 0$, $x(t) = x(t + T)$.
Let's perform the Fourier transform to the $x(t + T)$.
$
  cal(F){x(t + T)} = e^(j omega T)dot cal(F){x(t)} = e^(j omega T)dot X(omega)
$
because $x(t) = x(t + T)$, so:
$
  cal(F){x(t+T)} = e^(j omega T)dot X(omega) = X(omega) = cal(F){x(t)}
$
That is:
$
  (e^(j omega T)-1)dot X(omega) = 0 ==> T=0
$
So the assumption is wrong, $x(t)$ is aperiodic.\
\

*(b)* Perform Fourier transform on $h(t)$:
$
  H(omega) = cal(F){h(t)} = (1/(j omega) + pi delta(omega))dot (1-e^(j omega(-2)))
$
Let $y(t) = x(t) * h(t)$, then $Y(omega)$ is:
$
  Y(omega) 
  = X(omega) dot H(omega) = (1/(j omega) + pi delta(omega))dot (1-e^(j omega(-2))) dot X(omega)
$
Then, we can get $y(t)$:
$
  y(t) 
  &= cal(F)^(-1){Y(omega)} = 1/(2pi) dot integral_(-infinity)^(+infinity) Y(omega) dot e^(j omega t) " d"omega\
  &= 1/(2pi) dot [H(0) dot 1 + H(pi) dot (-1) + H(5) dot e^(j 5 t)]\
  &= 1/(2pi) dot [pi dot 0 dot 1 + 1/(j pi) dot (1 - e^(j(-2pi))) dot (-1) + 1/(j 5) dot e^(j(-10)) dot e^(j 5 t)]\
  &= 1/(2pi) dot 1/(j 5) dot e^(j(-10)) dot e^(j 5 t)
$
Assume that $y(t)$ is periodic, then $exists T > 0$, let $y(t) = y(t + T)$,
$
  y(t + T) = 1/(j (10pi)) dot e^(j(5(t+T)-10)) = 1/(j (10pi)) dot e^(j(5t-10)) = y(t)
$
That is:
$
  e^(j(5T)) = 1 ==> 5T = 2k pi ==> T = 2/5 k pi , k in ZZ and k eq.not 0
$

So the assumption is right, $y(t) = x(t) * h(t)$ is periodic.\
\

*(c)* Normally, the convolution of two aperiodic signals is aperiodic, because the Fourier transform on a periodic signal is discrete, while the Fourier transform on aperiodic signal is continuous. In equation $Y(omega) = X_1(omega) dot X_2(omega)$, two continuous function $X_1(omega)$ and $X_2(omega)$ cannot get a discrete signal $Y(omega)$. So, the convolution of two aperiodic signals is aperiodic normally.

However, just like the input in part(b), if $X_1(omega)$ or $X_2(omega)$ is the function composed of $delta(omega)$ function, and the integral of the output
$
  integral_(-infinity)^(+infinity) Y(omega) " d"omega = 
  integral_(-infinity)^(+infinity) X_1(omega) dot X_2(omega) " d"omega 
$
is a constant, then $y(t)$ is only a function with one frequency. That is, $y(t)$ is a periodic signal.

So if the convolution of two  aperiodic signals is periodic or not, it depends.