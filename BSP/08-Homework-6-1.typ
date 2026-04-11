#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-11-14" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "First Exercise for Chapter 6" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(4.6)[
  Use (4.28) or the properties of the DTFT to compute the inverse DTFT of the frequency function $X(omega)$ shown in Figure P4.6.
  #image("image/08_1.png", width: 80%)
]
#SOLUTION

*(a)* Obiviously, 
$
  cal(F){x[n]} = X(Omega) = [3/(2pi) dot p_((2pi)/3)(Omega) * p_((2pi)/3)(Omega)] * sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi)
$
Try to find $gamma(t)$, for which $cal(F){gamma(t)} = X(omega) dot p_(2pi)(omega) = Gamma(omega)$. Then, 
$
  2pi dot gamma(-t) = cal(F){Gamma(omega)}
  &= cal(F) {3/(2pi) dot p_((2pi)/3)(omega) * p_((2pi)/3)(omega)}\
  &= 3/(2pi) dot [(2pi)/3 dot sinc ((pi t)/3)]^2
$
That is: 
$
  gamma(t) = 1/2 dot sinc^2((pi t)/3)
$
So, we will get:
$
  x[n] = gamma(n) = 1/2 dot sinc^2((pi n)/3)
$\

#text(fill: rgb(255, 0, 0))[
  Correction: Basic compute error! ! !
  $
    gamma(t) = 1/(2pi) dot 3/(2pi) dot [(2pi)/3 dot sinc ((pi t)/3)]^2 =  1/3 dot sinc^2((pi t)/3)
  $
  So, we will get:
  $
    x[n] = gamma(n) = 1/3 dot sinc^2((pi n)/3)
  $
]\


*(b)* For (b), we have two methods. \

*First*, we can see $X(Omega)$ as:
$
  X(Omega) = [3/(2pi) dot p_pi (Omega) * p_pi (Omega) - p_((2pi)/3) (Omega) - 3/(2pi) dot p_(pi/3)(Omega) * p_(pi/3)(Omega)] *  sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi)
$
Like (a), we need find $gamma(t)$, for which $cal(F){gamma(t)} = Gamma(omega) = X(omega) dot p_(2pi) (omega)$, so:
$
  2pi dot gamma(-t) 
  &= cal(F){Gamma(omega)} = cal(F){X(omega) dot p_(2pi) (omega)} \
  &= cal(F){3/(2pi) dot p_pi (omega) * p_pi (omega) - p_((2pi)/3) (omega) - 3/(2pi) dot p_(pi/3)(omega) * p_(pi/3)(omega)} \
  &= (3pi)/2 dot sinc^2((t pi)/2) - (2pi)/3 dot sinc((t pi)/3) - pi/3 dot sinc^2((t pi)/6)
$
That is:
$
  gamma(t) = 3/4 dot sinc^2((t pi)/2) - 1/3 dot sinc((t pi)/3) - 1/12 dot sinc^2((t pi)/6)
$
So, we will get:
$
  x[n] = gamma(n) = 3/4 dot sinc^2((n pi)/2) - 1/3 dot sinc((n pi)/3) - 1/12 dot sinc^2((n pi)/6)
$\

*Second*, we can see $X(Omega)$ as:
$
  X(Omega) = delta(Omega - pi) * [p_((4pi)/3) (Omega) - 3/(2pi) dot p_((2pi)/3)(Omega) * p_((2pi)/3)(Omega)] * sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi)
$
Like (a), we just find $gamma(t)$,
$
  2pi dot gamma(-t)
  &= cal(F){Gamma(omega)} = cal(F){X(omega) dot p_(2pi) (omega)} \
  &= cal(F){delta(omega - pi) * [p_((4pi)/3) (omega) - 3/(2pi) dot p_((2pi)/3)(omega) * p_((2pi)/3)(omega)]} \
  &= e^(-j pi t) dot cal(F){p_((4pi)/3) (omega) - 3/(2pi) dot p_((2pi)/3)(omega) * p_((2pi)/3)(omega)} \
  &= e^(-j pi t) dot [(4pi)/3 dot sinc((2pi t)/3) - (2pi)/3 dot sinc^2((pi t)/3)] \
$
That is:
$
  gamma(t) = e^(j pi t) dot [2/3 dot sinc((2pi t)/3) - 1/3 sinc^2((pi t)/3)]
$
So, we will get:
$
  x[n] = gamma(n) 
  &= e^(j pi n) dot [2/3 dot sinc((2pi n)/3) - 1/3 sinc^2((pi n)/3)] \
  &= (-1)^n dot [2/3 dot sinc((2pi n)/3) - 1/3 sinc^2((pi n)/3)]
$\

*(c)* Obiviously,
$
  X(Omega) = [p_((4pi)/3)(Omega) + p_((2pi)/3)(Omega)] * sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi)
$
Like (a), let us find $gamma(t)$,
$
  2pi dot gamma(-t) 
  &= cal(F){X(omega) dot p_(2pi)(omega)} = cal(F){p_((4pi)/3)(Omega) + p_((2pi)/3)(Omega)} \
  &= (4pi)/3 dot sinc((2pi t)/3) + (2pi)/3 dot sinc((pi t)/3)
$
That is:
$
  gamma(t) = 2/3 sinc((2pi t)/3) + 1/3 dot sinc((pi t)/3)
$
So, we will get:
$
  x[n] = gamma(n) = 2/3 sinc((2pi n)/3) + 1/3 dot sinc((pi n)/3)
$\

*(d)* Obiviously,
$
  X(Omega) = [pi/3 dot p_(pi/3)(Omega) * p_(pi/3)(Omega)] * [delta(Omega - (2pi)/3) + delta(Omega - (2pi)/3)] * sum_(k = -infinity)^(+infinity) delta(Omega - 2 k pi)
$
Like (a), let us find $gamma(t)$,
$
  2pi dot gamma(-t)
  &= cal(F){X(omega) dot p_(2pi)(omega)} \
  &= cal(F){[3/pi dot p_(pi/3)(Omega) * p_(pi/3)(Omega)] * [delta(Omega - (2pi)/3) + delta(Omega - (2pi)/3)]} \
  &= [pi/3 dot sinc^2((pi t)/6)] dot [e^(j (2pi t)/3) + e^(-j (2pi t)/3)] \
$
That is:
$
  x[n] = gamma(n)
  &= 1/6 dot sinc^2((pi n)/6) dot [e^(j (2pi t)/3) + e^(-j (2pi t)/3)] \
  &= 1/3 dot sinc^2((pi n)/6) dot (e^(j (2pi n)/3) + e^(-j (2pi n)/3))/2 \
  &= 1/3 dot sinc^2((pi n)/6) dot cos((2pi n)/3)
$
Like (b), we can think from another way, but we do not waste time here.




#pagebreak()
#problem(4.9)[
  Compute the rectanglar form of the four-point DFT of the following signals, all of which are sero for $n < 0$ and $n >= 4$:\
  *(b)* $x[0] = 1, x[1] = 0, x[2] = -1, x[3] = 0$.\
  *(g)* Compute the DFT for each of the foregoing signals using the MATLAB M-file `dft`.
]
#SOLUTION

*(b)* For the definition of DFT, we know that: 
$
  X_k = sum_(n = 0)^(3) x[n] dot e^(-j Omega n) = sum_(n = 0)^(3) x[n] dot e^(-j (2 k pi)/N n), " where" N = 4
$
when $k = 0$, $
  X_0 = sum_(n = 0)^(3) x[n] dot e^(-j (2 dot 0 dot pi)/4 n) = sum_(n = 0)^(3) x[n] = 0
$
when $k = 1$, $
  X_1 = sum_(n = 0)^(3) x[n] dot e^(-j (2 dot 1 dot pi)/4 n) = sum_(n = 0)^(3) x[n] dot e^(-j dot pi/2 dot n) = 2
$
when $k = 2$, $
  X_2 = sum_(n = 0)^(3) x[n] dot e^(-j (2 dot 2 dot pi)/4 n) = sum_(n = 0)^(3) x[n] dot e^(-j dot pi dot n) = 0
$
when $k = 3$, $
  X_3 = sum_(n = 0)^(3) x[n] dot e^(-j (2 dot 3 dot pi)/4 n) = sum_(n = 0)^(3) x[n] dot e^(-j dot -pi/2 dot n) = 2
$
So we will get:
$
  X_k = [0, 2, 0, 2]
$\

*(g)* According to the definition of DFT, code the M-file `dft` like following:\
----------------------------------------\
```matlab
function X = dft(x)
% Compute DFT
N = length(x);
X = zeros(1, N);
for k = 0:N-1
    for n = 0:N-1
        X(k+1) = X(k+1) + x(n+1) * exp(-1j * 2 * pi * k * n / N);
    end
end
end
```
----------------------------------------\
And then, use the function `dft` to compute the signal in (b). The output is:
```
DFT(x):
   0.0000 + 0.0000i   2.0000 + 0.0000i   0.0000 - 0.0000i   2.0000 + 0.0000i
```
The output is equal to the result in (b).



#pagebreak()
#problem(4.12)[
  Compute the sinusoidal form of the signals in Problem 4.9(b)
]
#SOLUTION

Perform inverse DFT on $X_k$,
$
  x[n] = 1/N dot sum_(k = 0)^(N-1) X_k dot e^(j dot (2k pi)/N dot n), " where" N = 4
$
So,
$
  x[n] 
  &= 1/4 dot sum_(k = 0)^(3) X_k dot e^(j dot (2k pi)/4 dot n) \
  &= 1/4 dot [2 dot e^(j dot pi/2 dot n) + 2 dot e^(j dot (3pi)/2 dot n)]\
  &= 1/2 dot [e^(j dot pi/2 dot n) + e^(-j dot pi/2 dot n)] \
  &= cos((pi n)/2)
$





#pagebreak()
#problem(4)[
  Let
  $
    y[n] = ((sin (pi n)/4)/(pi n))^2 * ((sin Omega_C n)/(pi n))
  $
  where \* denotes convoltion, and $|Omega_C| <= pi$.\
  Determine the value of $Omega_C$, such that:
  $
    y[n] = ((sin (pi n)/4)/(pi n))^2
  $
]
#SOLUTION

Perform the Fourier transform on $y[n]$:
$
  cal(F){y[n]} 
  &= cal(F){((sin (pi n)/4)/(pi n))^2 * ((sin Omega_C n)/(pi n))} \
  &= cal(F){((sin (pi n)/4)/(pi n))^2} dot cal(F){(sin Omega_C n)/(pi n)}\
  &= 1/(2pi) dot cal(F){1/4 dot sinc((pi n)/4)} * cal(F){1/4 dot sinc((pi n)/4)} dot cal(F){(Omega_C)/pi dot sinc(Omega_C n)}\
  &= 1/(2pi) dot p_(pi/2)(Omega) * p_(pi/2)(Omega) dot p_(2Omega_C)(Omega)
$
because:
$
  y[n] = ((sin (pi n)/4)/(pi n))^2
$
So, 
$
  cal(F){y[n]} = 1/(2pi) dot p_(pi/2)(Omega) * p_(pi/2)(Omega)
$
That is:
$
  1/(2pi) dot p_(pi/2)(Omega) * p_(pi/2)(Omega) = 1/(2pi) dot p_(pi/2)(Omega) * p_(pi/2)(Omega) dot p_(2Omega_C)(Omega)
$
So, $2Omega_C >= pi$. That is: 
$
  |Omega_C| >= pi/2
$
and because $Omega_C <= pi$, so:
$
  pi >= |Omega_C| >= pi/2
$
Choose 
$
  Omega_C = pi/2
$
is enough.





#pagebreak()
#problem(5)[
  There are four signal given as below:\
  *(a)* Compute the Fourier spectrum $X_1(omega)$ of the signal $x_1(t)$, and plot the amplitude spectrum $|X_1(omega)|$.\
  *(b)* Compute the Fourier spectrum $X_2(omega)$ of the signal $x_2(t)$, and plot the amplitude spectrum $|X_2(omega)|$.\
  *(c)* Compute the Fourier spectrum $X_3(omega)$ of the signal $x_3(t)$, and plot the amplitude spectrum $|X_3(omega)|$.\
  *(d)* Compute the DFT $X_3(k)$ of the signal $x_3[n]$, and plot the amplitude $|X_3(k)|$, $N = 6$.\
  *(e)* Compare $|X_1(omega)|$ v.s. $|X_2(omega)|$, $|X_2(omega)|$ v.s. $|X_3(omega)|$, $|X_3(omega)|$ v.s. $|X_3(k)|$, explain: relationship between FS and FT, relationship between FT and DTFT, relationship between DTFT and DFT.
  #image("image/08_5_1.png", width: 90%)
  #image("image/08_5_2.png", width: 40%)
  #image("image/08_5_3.png", width: 70%)
]
#SOLUTION

*(a)* Perform Fourier series expansion on $x_1(t)$,
$
  c_k = 1/T dot integral_0^T x_1(t) dot e^(-j k pi t) " d"t = 1/2 dot integral_0^1e^(-j k pi t) " d"t = ((-1)^k - 1)/(-2pi j k)
$
and
$
  c_0 = 1/T dot integral_0^T x_1(t) " d"t= 1/2 dot integral_0^1 x_1(t) " d"t = 1/2
$
So,
$
  x_1(t) = sum_(k = -infinity)^(+infinity) c_k dot e^(j k pi t)
$
Then, we can get $X_1(omega)$:
$
  X_1(omega) = sum_(k = -infinity)^(+infinity) c_k dot 2pi dot delta(omega - k pi)
$
Plot the figure:
#image("image/08_5_(a).png")\

*(b)* Obiviously,
$
  x_2(t) = u(t) - u(t-1)
$
Then, perform the Fourier transform on it:
$
  X_2(omega) 
  &= cal(F){u(t)} - cal(F){u(t-1)} \
  &= [1/(j omega) + pi delta(omega)] - e^(-j omega)[1/(j omega) + pi delta(omega)] \
  &= (1 - e^(-j omega)) dot [1/(j omega) + pi delta(omega)]
$
Plot the figure:
#image("image/08_5_(b).png")\

*(c)* Obiviously,
$
  x_3[n] = u[n] - u[n-4]
$
So,
$
  X_3(Omega) &= cal(F){u[n] - u[n-4]} = (1 - e^(-j Omega 4)) dot cal(F){u[n]} \
  &= (1 - e^(-j Omega 4)) dot [1/(1 - e^(-j Omega)) + sum_(k = -infinity)^(+infinity) pi delta(Omega - 2 k pi)]
$
Plot the figure:
#image("image/08_5_(c).png")\

*(d)* Obiviously,
$
  X_3(k) = sum_(n = 0)^(N-1) x_3[n] dot e^(-j dot (2 k pi)/N dot n)
$
Let $N = 6$,
$
  X_3(k) = sum_(n = 0)^(5) x_3[n] dot e^(-j dot ( k pi)/3 dot n)
$
and for $x_3[n]$, $x_3[4] = x_3[5] = 0$, and $x_3[0] = dots = x_3[3] = 01$. So:
$
  X_3(k) = sum_(n = 0)^(3) e^(-j dot ( k pi)/3 dot n)
$
Plot the figure:
#image("image/08_5_(d).png")\

*(e)* According to the figure above, it's obiviously that:\
(1) FS is like sampling FT.\
(2) DTFT is like stacking multiple FT with different frequency shifts.\
(3) DFT is just like sampling DTFT in the intervel $[0, 2pi]$.
