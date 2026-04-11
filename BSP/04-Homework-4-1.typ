#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-10-23" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "Exercises for Chapter 4" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(1)[
  Given that the response of a linear time-invariant system to an input $x(t) = e^(-5t)dot u(t)$ is $y(t) = sin(omega_0t)$, \
  *(a)* Can  we determine the system's unit impulse response $h(t)$? Give your reason. \
  *(b)* Is that system causal? Give your reason.
]
\
#SOLUTION

*(a)* Obviously, it is easy to get the $h(t)$ with #emph[Laplace Transform]. However, using the differential properties of convolution is more appropriate. The following is obvious:
$
  y'(t) &= "d"/("d"t)[x(t) * h(t)] = accent(x, .)(t) * h(t) = "d"/("d"t)[e^(-5t) dot u(t)] * h(t) \
  &= [-5e^(-5t) dot  u(t) + e^(-5t) dot delta(t)] * h(t) \
  &= -5e^(-5t) dot  u(t) * h(t) + e^(-5t) dot delta(t) * h(t) \
  &= -5[e^(-5t) dot  u(t) * h(t)] + e^(-5t) dot h(t) \
  &= -5 dot y(t) + e^(-5t) dot  h(t)
$
That is:
$
  h(t) = e^(5t) dot [y'(t) + 5y(t)] = e^(5t) dot [omega_0 dot cos (omega_0 t) + 5 sin (omega_0 t)]
$

#text(fill: rgb(255, 0, 0))[
  Correction: 
  $
    y'(t) &= "d"/("d"t)[x(t) * h(t)] = accent(x, .)(t) * h(t) = "d"/("d"t)[e^(-5t) dot u(t)] * h(t) \
    &= [-5e^(-5t) dot  u(t) + e^(-5t) dot delta(t)] * h(t) \
    &= [-5e^(-5t) dot  u(t) + e^(-5 times 0) dot delta(t)] * h(t) \
    &= [-5e^(-5t) dot  u(t) + delta(t)] * h(t) \
  $
  That is:
  $
    h(t) = y'(t) + 5y(t) = omega_0 dot cos (omega_0 t) + 5 sin (omega_0 t)
  $
]

*(b)* Obviously, $exists t < 0$, $h(t) eq.not 0$, so the system is noncausal.






#pagebreak()

#problem(2)[
  For each signal shown in Figure P3.9, do the following: \
  #figure(image("image/04_2_ques.png", width: 90%))
  *(a)* Compute the trigonometric and complex exponential Fourier series. \
  *(b)* Compute and plot the truncated exponential series for $N = 3, 10$, and $30$, using MATLAB when $T = 2$, and $a = 0.5$.
]
\
#SOLUTION

*(a)* *First*, compute the trigonometric Fourier series:
$
  x(t) = a_0 + sum_(k = 1)^(+infinity) c_k dot cos (k dot  (2pi)/T dot t)
$
It is easy to get: $a_0 = 2a "/" T$, and the following  is to compute the coefficients $c_k$:
$
  c_k 
  &= 1 / T dot integral_(-T"/"2)^(T"/"2) x(t) dot cos(k dot (2pi)/T dot t) " d"t \
  &= 1 / T dot integral_(-a)^(a) cos(k dot (2pi)/T dot t) " d"t \
  &= 1 / (2pi k) dot integral_(-a)^(a) cos(k dot (2pi)/T dot t) " d"(k dot (2pi)/T dot t) \
  &= 1 / (pi k) dot sin(k dot (2pi)/T dot a) \
$
So the trigonometric Fourier series is:
$
  x(t) &= (2a)/T + sum_(k = 1) ^(+infinity) 1 / (pi k) dot sin(k dot (2pi)/T dot a) dot cos (k dot  (2pi)/T dot t) \ 
$\

*Second*, compute the complex exponential Fourier series:
$
  x(t) = sum_(k = -infinity)^(+infinity) c_k dot e^(j k omega_0 t)", "omega_0 = (2pi)/T
$
Then, we should compute the coefficients $c_k$:
$
  c_k
  &= 1 / T dot integral_(-T"/"2)^(T"/"2) x(t) dot e^(-j k omega_0 t) " d"t = 1 / T dot integral_(-a)^(a) e^(-j k omega_0 t) " d"t \
  &= 1 / (-j k omega_0 T) dot integral_(-a)^(a) e^(-j k omega_0 t) " d"(-j k omega_0 t) \
  &= 1 / (j k omega_0 T) dot (e^(j k omega_0 a) - e^(-j k omega_0 a)) \
  &= 2 / ( k omega_0 T) dot sin(k omega_0 a) \
  &= (sin(k omega_0  a)) / ( k pi)  \
$
So the complex exponential Fourier series is:
$
  x(t) = sum_(k = -infinity)^(+infinity) (sin(k omega_0  a)) / ( k pi)  dot  e^(j k omega_0 t)", "omega_0 = (2pi)/T
$\
#text(fill: rgb(255, 0, 0))[
  Correction: when $k = 0$, 
$
    (sin(k omega_0 a))/(k pi) = (omega_0 a cos(k omega_0 a))/(pi) = (omega_0 a)/pi = (2 a)/(T) = (2 times 0.5)/2 = 1/2
$
]

#pagebreak()
*(b)* *(1)*With $T = 2$, $a = 0.5$, let $N = 3$, we will get:
$
  x(t) = sum_(k = -3)^(3) (sin(k pi "/"2)) / ( k pi)  dot  e^(j k pi t)
$Using MATLAB to compute the values of coefficients:
```
=== Fourier coefficients (N = 3) ===
  n		        coefficient
 -3		        -0.106103
 -2		        0.000000
 -1		        0.318310
  0		        0.500000
  1		        0.318310
  2		        0.000000
  3		        -0.106103
```
and plot the Figure:
#figure(image("image/04_1.png", width: 90%))\

*(b)* Likewise, let $N = 10$, we will get:
$
  x(t) = sum_(k = -10)^(10) (sin(k pi "/"2)) / ( k pi)  dot  e^(j k pi t)
$
Using MATLAB to compute the values of coefficients:
```
=== Fourier coefficients (N = 10) ===
  n		        coefficient
-10		        0.000000
 -9		        0.035368
 -8		        -0.000000
 -7		        -0.045473
 -6		        0.000000
 -5		        0.063662
 -4		        -0.000000
 -3		        -0.106103
 -2		        0.000000
 -1		        0.318310
...
 10		        0.000000
```
and plot the Figure:
#figure(image("image/04_2.png", width: 90%))\

*(c)* Let $N = 30$, we will get:
$
  x(t) = sum_(k = -30)^(30) (sin(k pi "/"2)) / ( k pi)  dot  e^(j k pi t)
$
Using MATLAB to compute the values of coefficients:
```
=== Fourier coefficients (N = 30) ===
  n		        coefficient
-30		        0.000000
-29		        0.010976
-28		        -0.000000
-27		        -0.011789
-26		        -0.000000
-25		        0.012732
-24		        -0.000000
-23		        -0.013840
-22		        0.000000
-21		        0.015158
...
 30		        0.000000
```
and plot the Figure:
#figure(image("image/04_3.png", width: 90%))

#v(50pt)
*The following is the MATLAB code:*\
--------------------------------------------------
```matlab
%% Compute Fourier coefficients and Plot the Fiogure
clear; clc; close all;

% get N
N = input('Enter N: ');

% set parameters
T = 2;
a = 0.5;

% Compute coefficients
k_values = -N:N;
coefficients = zeros(size(k_values));

for i = 1:length(k_values)
    k = k_values(i);
    if k == 0
        coefficients(i) = a;
    else
        coefficients(i) = (sin(k * pi * a)) / (k * pi);
    end
end

% show the value
fprintf('\n=== Fourier coefficients (N = %d) ===\n', N);
fprintf('  n\t\tcoefficient\n');
for i = 1:min(10, length(k_values))
    fprintf('%3d\t\t%.6f\n', k_values(i), coefficients(i));
end
if length(k_values) > 10
    fprintf('...\n');
    fprintf('%3d\t\t%.6f\n', k_values(end), coefficients(end));
end

% plot the figure
figure();

stem(k_values, coefficients, 'filled', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlabel('n', 'FontSize', 12);
ylabel('Fourier coefficients', 'FontSize', 12);
title(sprintf('Fourier coefficients (N = %d)', N), 'FontSize', 14);

% add watermark
watermark = annotation('textbox', ...
    'String', '3230100633\_HZJ', ...
    'FontSize', 40, ...
    'Color', [0.9, 0.9, 0.9, 0.01], ...
    'Rotation', 30, ...
    'EdgeColor', 'none', ...
    'Position', [0.35, 0.25, 0.5, 0.2], ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'FitBoxToText', 'off'); 
uistack(watermark, 'bottom');
drawnow;

% save the figure
saveas(gcf, "04_1.png");
```
--------------------------------------------------



#pagebreak()

#problem(3)[
  For each of the following signals, compute the complex exponential Fourier series by using trigonometric identities, and then sketch the amplitude and phase spectra for all values of $k$. \
  *(b)* $x(t) = sin t + cos t$ \
  *(d)* $x(t) = cos (2t) dot sin (3t)$ 
]
\
#SOLUTION

*(b)* Obviously,
$
  x(t) 
  &= sin(t) + cos(t) = (e^(j t) - e^(-j t))/(2j) + (e^(j t) + e^(-j t))/(2) \
  &= (j+1)/2 dot e^(-j t) + (1-j)/2 dot e^(j t)
$
That is:
$
  x(t) = sum_(k = -infinity)^(+infinity) c_k dot e^(j k omega_0 t)", "omega_0 = (2pi)/T
$
where
$
  c_k = cases(
    (1+j)"/"2"   "& ", "k = -1,
    (1-j)"/"2 & ", "k = 1,
    0 & ", others"
  )
$\

According to the above compl exponential Fourier series, we can get the amplitude and phase spectra:
$
  |X_k| = cases(
    sqrt(2)/2"   "& ", "k = plus.minus 1,
    0 & ", others"
  )"          "
  angle X_k = cases(
    45 degree "   "& ", "k = -1,
    -45 degree & ", "k = 1,
    0 & ", others"
  )
$

#cetz.canvas({
  import cetz.draw: *

  rect((-2,-1), (4, 4))
  grid((-2, -1), (4, 4), help-lines: true)
  
  // |X-K|
  set-style(stroke: black + 1.5pt, fill: black)
  line((-2, 0), (4, 0), mark: (end: ">"), anchor: "x-axis") // x-axis
  content((rel: (-0.4, -0.3)))[$k$]
  line((0, -1), (0, 4), mark: (end: ">")) // y-axis
  content((rel: (0.6, -0.4)))[$|X_k|$]
  set-style(stroke: blue + 1.5pt, fill: blue)
  circle((-1, 0.707*2), radius: 2pt)
  circle((1, 0.707*2), radius: 2pt)
  set-style(stroke: blue + 2pt, fill: none)
  circle((1, 0), radius: 3pt)
  circle((-1, 0), radius: 3pt)
  line((-2, 0), (-1.1, 0))
  line((rel: (0.2, 0)), (0.9, 0))
  line((rel: (0.2, 0)), (3.7, 0))

  set-style(stroke: black + 1pt, fill: none)
  rect((6,-1), (12, 4))
  grid((6, -1), (12, 4), help-lines: true)

  // /_ X-K
  set-style(stroke: black + 1.5pt, fill: black)
  line((6, 1), (12, 1), mark: (end: ">"), anchor: "x-axis") // x-axis
  content((rel: (-0.4, -0.3)))[$k$]
  line((9, -1), (9, 4), mark: (end: ">")) // y-axis
  content((rel: (0.6, -0.4)))[$angle X_k$]
  set-style(stroke: blue + 1.5pt, fill: blue)
  circle((10, -0.5), radius: 2pt)
  circle((8, 2.5), radius: 2pt)
  set-style(stroke: blue + 2pt, fill: none)
  circle((10, 1), radius: 3pt)
  circle((8, 1), radius: 3pt)
  line((8-2, 1), (9-1.1, 1))
  line((9-0.9, 1), (9+0.9, 1))
  line((9+1.1, 1), (8+3.7, 1))
})




#pagebreak()

#problem(4)[
  Determine the exponential Fourier series for the following periodic signals: \
  *(a)* $ x(t) = (sin 2t + sin 3t)/(2dot sin t) $ \
  *(b)* $ sum_(k = -infinity)^(infinity) delta(t - k T) $
]
\
#SOLUTION

*(a)* The original formula is equivalent to:
$
  x(t) 
  &= (sin 2t + sin 3t)/(2dot sin t) = ((2sin t cos t) + (3sin t - 4 sin^3 t)) / (2dot sin t) \
  &= cos t + 3/ 2 - 2 sin^2 t = cos t + 1 / 2 + (1 - 2 sin ^2 t) \
  &= 1/2 + cos t + cos(2t) \
  &= 1/2 + (e^(j t) + e^(-j t))/2 + (e^(2j t) + e^(-2j t))/2 \
  &= sum_(k = -2)^(2) 1 /2  dot e^(j k t)
$
That is:
$
  x(t) = sum_(k = -infinity)^(+infinity) c_k dot e^(j k t)", "c_k = cases(
    1"/"2" "& ", "k in {-2, -1, 0, 1, 2},
    0 & ", others"
  )
$
\
\

*(b)* Let the above equation be $x(t)$. Obviously,
$
  x(t) = sum_(k = -infinity)^(infinity) delta(t - k T) = sum_(k = -infinity)^(infinity) c_k dot e^(j k omega_0 t)", "omega_0 = (2pi)/T
$
Then, let's compute the coefficients $c_k$:
$
  c_k
  &= 1/T dot integral_(-T"/"2)^(T"/"2) x(t) dot e^(-j k omega_0 t) " d"t = 1/T
$
That is:
$
    sum_(k = -infinity)^(infinity) delta(t - k T) = sum_(k = -infinity)^(infinity) 1/T dot e^(j k omega_0 t)", "omega_0 = (2pi)/T
$







#pagebreak()

#problem(5)[
  A periodic signal with period $T$ has Fourier coefficients $c_k^x$; that is, $ x(t) = sum_(k = -infinity)^(infinity) c_k^x exp(j k omega_0t)," "omega_0 = (2pi)/(T)," "-infinity < t < infinity $Compute the Fourier coefficients $c_k^v$ for the periodic signal $v(t)$, where \
  *(a)* $v(t) = x(t-1)$ \
  *(b)* $v(t) = D x(t)$
]
\
#SOLUTION

*(a)* 
$
  v(t) 
  &= x(t-1) = sum_(k = -infinity)^(infinity) c_k^x exp(j k omega_0(t-1)) \
  &= sum_(k = -infinity)^(infinity) c_k^x dot e^(-j k omega_0) dot exp(j k omega_0 t)", "omega_0 = (2pi)/(T)", "-infinity < t < infinity
$
That is:
$
  c_k^v = c_k^x dot e^(-j k omega_0)", "omega_0 = (2pi)/(T)
$
\

*(b)* 
$
  v(t) &= D x(t) = ("d")/("d"t) sum_(k = -infinity)^(infinity) c_k^x exp(j k omega_0t) \
  &= sum_(k = -infinity)^(infinity) c_k^x dot (j k omega_0) dot exp(j k omega_0t)", "omega_0 = (2pi)/(T)", "-infinity < t < infinity
$
That is:
$
  c_k^v = c_k^x dot (j k omega_0)", "omega_0 = (2pi)/(T)
$






#pagebreak()

#problem(6)[
  Compute the inverse Fourier Tranform of the following $X(omega)$. \
  *(a)* $X(omega) = pi dot delta(omega - 4 pi) + pi dot delta(omega + 4 pi)$ \
  *(b)* $X(omega) = cases(
    1\, & 0 <= omega <= 2,
    -1\, & -2 <= omega < 0,
    0\, |omega| > 2
  )$
]
\
#SOLUTION

*(a)* 
$
  x(t) &= 1/(2pi) dot integral_(-infinity)^(+infinity) X(omega) dot e^(j omega t) " d"omega \
  &= 1/(2pi) dot integral_(-infinity)^(+infinity) [pi dot delta(omega - 4 pi) + pi dot delta(omega + 4 pi)] dot e^(j omega t) " d"omega \
  &= 1/2 dot e^(j(4pi)t) + 1/2 dot e^(j(-4pi)t) \
$
That is:
$
  x(t) = cos(4pi t)
$

*(b)* 
$
  x(t) &= 1/(2pi) dot integral_(-infinity)^(+infinity) X(omega) dot e^(j omega t) " d"omega \
  &= 1/(2pi) dot integral_(-2)^(0) (-1) dot e^(j omega t) " d"omega + 1/(2pi) dot integral_(0)^(2) 1 dot e^(j omega t) " d"omega \
  &= (-1)/(2pi j t)dot (1 - e^(j(-2)t)) + (1)/(2pi j t)dot (e^(j 2 t) - 1) \
  &= (-1)/(pi j t)  +  1 / (pi j t) dot  (e^(j 2 t) + e^(j(-2)t))/(2) \
  &= (-1 + cos 2t)/(pi j t) \
  &= (-2sin^2 t)/(pi j t) \
  &= (2j dot sin^2 t)/(pi t)
$

#text(fill: rgb(255, 0, 0))[
  Correction: when $t = 0$,
  $
    (2j dot sin^2 t)/(pi t) = (2j dot 2sin t dot cos t)/pi = 0
  $
]


