#import "@local/zju-typst-tplt:0.2.0": *

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-10-16" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "Exercises for Chapter 3" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

// ==================== 正文内容 ==================== //
#problem(1)[
Consider the cascade connection of two LTI systems in Figure P2.30:

*(a)* Determine and sketch/plot the overall impulse response of the cascade system; i.e., plot the output $y[n] = h[n]$ when $x[n] = delta [n]$.

*(b)* Determine and sketch/plot the overall unit step response of the cascade system; i.e., plot the output $y[n] = s[n]$ when $x[n] = u[n]$.

*(c)* Now consider the input $x[n] = 2delta [n] + 3delta [n-4] - delta [n-12]$. Sketch/plot $w[n]$ and $y[n]$.

*(d)* Determine and sketch/plot $w[n]$ if $x[n] = (-1/2)^n dot u[n]$. Also, determine the overall output $y[n]$.
]
#SOLUTION

*(a)* $because y[n] = h[n] = delta [n] * h_1[n] * h_2[n]$\
#v(6pt)
#h(17pt)$therefore &y[-3] = h[-3] = 1\
&y[-2] = h[-2] = 2\
&y[-1] = h[-1] = 3\
&y[0] = h[0] = 4\
&y[1] = h[1] = 3\
&y[2] = h[2] = 2\
&y[3] = h[3] = 1\
& forall n in.not {-3, -2, ..., 3}, y[n] = 0.$\
#figure(image("image/03_1(a)_ans.png", width: 100%))

*(b)* $because y[n] = s[n] = u [n] * h[n] = limits(sum)_(k = -infinity)^(infinity) u[k] dot h[n-k].$\
#v(6pt)
$therefore &y[-3] = s[-3] = 1\
&y[-2] = s[-2] = 3\
&y[-1] = s[-1] = 6\
&y[0] = s[0] = 10\
&y[1] = s[1] = 13\
&y[2] = s[2] = 15\
&y[3] = s[3] = 16\
& forall n >= 3," "y[n] = 16;" "forall n < -3," "y[n] = 0.$\
#figure(image("image/03_1(b)_ans.png", width: 100%))

*(c)* 
$
  w[n] &= x[n] * h_1[n]\
  &= 2delta [n] * h_1[n] + 3delta [n-4] * h_1[n] - delta [n-12] * h_1[n]\
  &= 2h_1[n] + 3h_1[n-4] - h_1[n-12].\
  y[n] &= w[n] * h_2[n]\
  &= 2h_1[n] * h_2[n] + 3h_1[n-4] * h_2[n] - h_1[n-12] * h_2[n].
$
#figure(image("image/03_1(c)_ans.png", width: 100%))

*(d)*
$
  w[n] &= x[n] * h_1[n]\
  &= ((-1/2)^n dot u[n]) * (u[n] - u[n-4])\
  &= ((-1/2)^n dot u[n]) * u[n] * (delta[n] - delta[n-4])\
  &= (sum_(k = 0)^n (-1/2)^k) dot u[n] * (delta[n] - delta[n-4])\
  &= ((-1/2)^(n+1)-1)/((-1/2)-1) dot u[n] * (delta[n] - delta[n-4])\
  &= ((-1/2)^(n+1)-1)/((-1/2)-1) dot u[n] - ((-1/2)^(n-4+1)-1)/((-1/2)-1) dot u[n-4].\
  \
  y[n] &= w[n] * h_2[n]\
  &= w[n] * (u[n+3] - u[n-1])\
  &= ((-1/2)^(n+1)-1)/((-1/2)-1) dot u[n] * (delta[n] - delta[n-4]) * u[n] * (delta[n+3]-delta[n-1])\
  &= [((-1/2)^(n+1)-1)/((-1/2)-1) dot u[n] * u[n]] * [(delta[n] - delta[n-4]) * (delta[n+3]-delta[n-1])]\
  &= [(sum_(k = 0)^n ((-1/2)^(k+1)-1)/((-1/2)-1)) dot u[n]] * [(delta[n] - delta[n-4]) * (delta[n+3]-delta[n-1])]\
  &= [(sum_(k = 0)^(n+1) (-1/2)^k dot (n+1-k)) dot u[n]] * (delta[n+3] - 2delta[n-1] + delta[n-5]).\
$
#figure(image("image/03_1(d)_ans.png", width: 100%))

#pagebreak()
#problem(2)[
  If the input and output of a causal LTI system satisfy the difference equation $ y[n] = a y[n-1] + x[n] $ then the impulse response of the system must be $h[n] = a^n dot u[n]$.

  Consider another causal LTI system for which the input and output are related by the difference equation $ y[n] = a y[n-1] + x[n] - a^(N-1) dot x[n-N+1] $ where $N$ is a positive integer. Compute the impulse response of this system.

  Hint: Use linearity and time-invariance to simplity the solution.
]

#SOLUTION

What we know is:
$
  cases(
    y_1[n] = T_1(x[n]) = a y[n-1] + x[n],
    y_2[n] = T_2(x[n]) = a y[n-1] + x[n] - a^(N-1) dot x[n-N+1]
  )
$
Actually, $y_2[n] = T_2(x[n]) = T_1(x[n] - a^(N-1) dot x[n-N+1])$.

So, we can construct an auxiliary system: $ w[n] = T_w (x[n]) = x[n] - a^(N-1) dot x[n-N+1] $
Then we will get: $y_2[n] = T_2(x[n]) = T_1(w[n]) = T_1(T_w (x[n]))$.\
That is, if the input is the Impulse Signal $delta[x]$, the output is:
$
  h_2[n] &= T_1(T_w (delta[n])) = delta[n] * h_w [n] * h_1[n]\
  &= delta[n] * (delta[n] - a^(N-1) dot delta[n-N+1]) * h_1[n]\
  &= h_1[n] - a^(N-1)dot h_1[n-N+1]\
  &= a^n dot u[n] - a^(N-1) dot a^(n-N+1) dot u[n-N+1]\
  &= a^n dot u[n] - a^n dot u[n-N+1]\
  &= a^n dot (u[n] - u[n-N+1])
$

#pagebreak()
#problem(3)[
  A discrete-time system has the following unit-pulse response: $ h[n] = 3/(10) dot (7/(10))^n dot u[n] $ 
  *(a)* Use `conv` to calculate the response of this system ro $x[n] = u[n]$, and plot the response.\
  *(c)* Use `conv` to calculate the response of this system ro $x[n] = u[n] + sin(n pi "/" 8) dot u[n]$, and plot the response.\
]
#SOLUTION

*(a)* Obviously, 
$
  y[n] &= x[n] * h[n] = u[n] * h[n] = u[n] * 3/(10) dot (7/(10))^n dot u[n]\
  &= 3/(10) dot (7/(10))^n dot u[n]*u[n]\
  &= (sum_(k = 0)^n 3/(10) dot (7/(10))^k ) dot u[n]\
  &= (1-(7/(10))^(n+1)) dot u[n]
$
Running the MATLAB code below:\
--------------------------------------------------
```matlab
%% 3. (a)
%% Convolution - (a)
clear; clc; close all;

% Define x[n] & v[n]
nx = 0 : 10;
x = ones(length(nx), 1);
nh = 0 : 10;
h = zeros(length(nh), 1);
for i = 1 : length(nh)
    h(i) = 0.3 * (0.7)^(i-1);
end

% compute convolution
ny_start = nx(1) + nh(1);
ny_end = nx(end) + nh(end);
ny = ny_start : ny_end;
y = conv(x, h);

% Print the answer
fprintf('===== Answer =====\n');
fprintf('y[n] = x[n] * h[n] = u[n] * h[n]:\n');
for i = 1 : length(x)
    fprintf('y[%d] = %d\n', ny(i), y(i));
end

% Figure the answer
figure('Position', [100, 100, 1200, 400]);

subplot(1,3,1);
plot(nx, x, 'o', 'LineWidth', 2);
xlim([nx(1)-2, nx(end)+2]);
ylim([0, max(x)+1]);
xlabel('n', 'Interpreter', 'latex');
ylabel('$x[n] = u[n]$', 'Interpreter', 'latex');
grid on;

subplot(1,3,2);
plot(nh, h, 'o', 'LineWidth', 2);
xlim([nh(1)-2, nh(end)+2]);
ylim([0, max(h)+1]);
xlabel('n', 'Interpreter', 'latex');
ylabel('$h[n]$', 'Interpreter', 'latex');
grid on;

subplot(1,3,3);
plot(ny(1:nx(end)), y(1:nx(end)), 'o', 'LineWidth', 2);
xlim([nx(1)-2, nx(end)+2]);
ylim([0, max(y)+1]);
xlabel('n', 'Interpreter', 'latex');
ylabel('$y[n] = x[n] * h[n] = u[n] * h[n]$', 'Interpreter', 'latex');
grid on;

% save figure
saveas(gcf, "03_3(a)_ans.png");
```
--------------------------------------------------\
You will get the response:
```
===== Answer =====
y[n] = x[n] * h[n] = u[n] * h[n]:
y[0] = 3.000000e-01
y[1] = 5.100000e-01
y[2] = 6.570000e-01
y[3] = 7.599000e-01
y[4] = 8.319300e-01
y[5] = 8.823510e-01
y[6] = 9.176457e-01
y[7] = 9.423520e-01
y[8] = 9.596464e-01
y[9] = 9.717525e-01
y[10] = 9.802267e-01
```
And the Figure plotted by MATLAB:
#figure(image("image/03_3(a)_ans.png", width: 100%))
#v(2em)

*(c)*
Running the MATLAB code below:\
--------------------------------------------------
```matlab
%% 3. (c)
%% Convolution - (c)
clear; clc; close all;

% Define x[n] & v[n]
nx = 0 : 30;
x = ones(length(nx), 1);
for i = 1 : length(nx)
    x(i) = x(i) + sin((i-1) * pi / 8);
end
nh = 0 : 10;
h = zeros(length(nh), 1);
for i = 1 : length(nh)
    h(i) = 0.3 * (0.7)^(i-1);
end

% compute convolution
ny_start = nx(1) + nh(1);
ny_end = nx(end) + nh(end);
ny = ny_start : ny_end;
y = conv(x, h);

% Print the answer
fprintf('===== Answer =====\n');
fprintf('y[n] = x[n] * h[n] = u[n] * h[n]:\n');
for i = 1 : length(x)
    fprintf('y[%d] = %d\n', ny(i), y(i));
end

% Figure the answer
figure('Position', [100, 100, 1200, 400]);

subplot(1,3,1);
plot(nx, x, 'o', 'LineWidth', 2);
xlim([nx(1)-2, nx(end)+2]);
ylim([0, max(x)+1]);
xlabel('n', 'Interpreter', 'latex');
ylabel('$x[n] = u[n] + \sin \left(\frac{n\pi}{8}\right)$', 'Interpreter', 'latex');
grid on;

subplot(1,3,2);
plot(nh, h, 'o', 'LineWidth', 2);
xlim([nh(1)-2, nh(end)+2]);
ylim([0, max(h)+1]);
xlabel('n', 'Interpreter', 'latex');
ylabel('$h[n]$', 'Interpreter', 'latex');
grid on;

subplot(1,3,3);
plot(ny(1:nx(end)), y(1:nx(end)), 'o', 'LineWidth', 2);
xlim([nx(1)-2, nx(end)+2]);
ylim([0, max(y)+1]);
xlabel('n', 'Interpreter', 'latex');
ylabel('$y[n] = x[n] * h[n] = u[n] * h[n]$', 'Interpreter', 'latex');
grid on;

% save figure
saveas(gcf, "03_3(c)_ans.png");
```
--------------------------------------------------\
You will get the response:
```
===== Answer =====
y[n] = x[n] * h[n] = u[n] * h[n]:
y[0] = 3.000000e-01
y[1] = 6.248050e-01
y[2] = 9.494956e-01
y[3] = 1.241811e+00
y[4] = 1.469268e+00
y[5] = 1.605651e+00
y[6] = 1.636088e+00
y[7] = 1.560067e+00
y[8] = 1.392047e+00
y[9] = 1.159628e+00
y[10] = 8.996073e-01
y[11] = 6.466292e-01
y[12] = 4.444384e-01
y[13] = 3.238165e-01
y[14] = 3.031271e-01
y[15] = 3.855200e-01
y[16] = 5.584516e-01
y[17] = 7.955946e-01
y[18] = 1.060846e+00
y[19] = 1.313824e+00
y[20] = 1.516015e+00
y[21] = 1.636637e+00
y[22] = 1.657326e+00
y[23] = 1.574933e+00
y[24] = 1.402002e+00
y[25] = 1.164859e+00
y[26] = 8.996073e-01
y[27] = 6.466292e-01
y[28] = 4.444384e-01
y[29] = 3.238165e-01
y[30] = 3.031271e-01
```
And the Figure plotted by MATLAB:
#figure(image("image/03_3(c)_ans.png", width: 100%))
#v(2em)


#pagebreak()
#problem(4)[
  A causal linear time-invariance continuous-time system has impulse response $ h(t) = e^(-t) + sin t, t >= 0 $

  *(a)* Compute the output response for all $t >= 0$ when the input is the unit-step function $u(t)$.\
  *(b)* Compute the output response $y(t)$ for all $t >= 0$ resulting from the input $u(t) - u(t-2)$.
]

#SOLUTION

*(a)* 
$
  y(t) &= x(t) * h(t) = u(t) * [(e^(-t) + sin t) dot u(t)]\
  &= integral_(-infinity)^(infinity) h(tau) dot u(t - tau) " d"tau\
  &= integral_(-infinity)^(infinity) (e^(-tau) + sin tau) dot u(tau) dot u(t - tau) " d"tau\
  &= (integral_(0)^(t) (e^(-tau) + sin tau) " d"tau) dot u(t)\
  &= (2 - cos t - e^(-t)) dot u(t)\
$

*(b)*
$
  y(t) &= x(t) * h(t) = [u(t) - u(t-2)] * [(e^(-t) + sin t) dot u(t)]\
  &= [delta(t) - delta(t-2)] * u(t) * [(e^(-t) + sin t) dot u(t)]\
  &= [(2 - cos t - e ^(-t)) dot u(t)] * [delta(t) - delta(t-2)]\
  &= cases(
    0\, & 0>&t,
    2 - cos t - e^(-t)\, & 2>=&t>=0,
    cos (t-2) - cos t + e^(-t) dot (1 + e^2)\, && t > 2
  )
$


#pagebreak()
#problem(5)[
  The system $L$ in Figure P2.49 is known to be #emph[linear]. Shown are three output signals $y_1[n]$, $y_2[n]$, and $y_3[n]$ in response to the input signals $x_1[n]$, $x_2[n]$, and $x_3[n]$, respectively.
  #figure(image("image/03_5.png", width: 100%))
  Assuming that the above systems are all linear time-invariant systems, please determine whether the above three outputs are correct, and explain the reason.
]

#SOLUTION

(1) Assuming the system is a LTI system, then it is easy to get:
$
  y_1[n] = x_1[n] * h[n] &= (-2delta[n+1] + delta[n] - 2delta[n-1]) * h[n] \
  &= -2h[n+1] + h[n] - 2h[n-1]\
$

According to the length property of convolution, $"len"(x_1[n]) + "len"(h_1[n]) - 1 = "len"(y_1[n])$. So, we will get: $"len"(h_1[n]) = 3$.\
Let $n = -1$, $y_1[-1] = -2h[0] + h[-1] - 2h[-2] = -1$, $h[0] = 1/2.$\
Let $n = 0$, $y_1[0] = -2h[1] + h[0] - 2h[-1] = 3$, $h[1] = -4/5.$\
Let $n = 1$, $y_1[1] = -2h[2] + h[1] - 2h[0] = 3$, $h[2] = -(21)/8.$\
Let $n = 2$, $y_1[2] = -2h[3] + h[2] - 2h[1] = 0$, $h[3] = -1/8.$\
Obviously, $"len"(h_1[n]) > 3$, the output is incorrect.
\
\

(2) Assuming the system is a LTI system, then it is easy to get:
$
  y_2[n] = x_2[n] * h[n] &= (-2delta[n+1] + delta[n]) * h[n] \
  &= -2h[n+1] + h[n]\
$
According to the length property of convolution, $"len"(x_2[n]) + "len"(h_2[n]) - 1 = "len"(y_2[n])$. So, we will get: $"len"(h_2[n]) = 4$.\
Let $n = -1$, $y_2[-1] = -2h[0] + h[-1] = -1$, $h[0] = 1/2.$\
Let $n = 0$, $y_2[0] = -2h[1] + h[0] = 1$, $h[1] = -1/4.$\
Let $n = 1$, $y_2[1] = -2h[2] + h[1] = -3$, $h[2] = 11/8.$\
Let $n = 2$, $y_2[2] = -2h[3] + h[2] = 0$, $h[3] = 11/16.$\
Let $n = 3$, $y_2[2] = -2h[3] + h[2] = -1$, $h[4] = 25/32.$\
Obviously, $"len"(h_2[n]) > 4$, the output is incorrect.
\
\


(3) Assuming the system is a LTI system, then it is easy to get:
$
  y_3[n] = x_3[n] * h[n] &= (delta[n] + delta[n-1]) * h[n] \
  &= h[n] + h[n-1]\
$
According to the length property of convolution, $"len"(x_3[n]) + "len"(h_3[n]) - 1 = "len"(y_3[n])$. So, we will get: $"len"(h_3[n]) = 4$.\
Let $n = -2$, $y_3[-2] = h[-2] + h[-3] = 2$, $h[-2] = 2.$\
Let $n = -1$, $y_3[-1] = h[-1] + h[-2] = 1$, $h[0] = -1.$\
Let $n = 0$, $y_3[0] = h[0] + h[1] = -3$, $h[1] = -2.$\
Let $n = 1$, $y_3[1] = h[1] + h[2] = 0$, $h[2] = 2.$\
Let $n = 2$, $y_3[2] = h[2] + h[3] = 2$, $h[3] = 0.$\
Obviously, $"len"(h_3[n]) = 4$, so the output is correct.
