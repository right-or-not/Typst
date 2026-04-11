#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-12-11" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "First Exercise for Chapter 7" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

#problem(6.1)[
  Determine the Laplace transform of the following signals: \
  *(a)* $cos(3t) u(t)$ \
  *(b)* $e^(-10t) u(t)$ \
  *(d)* $e^(-10t) cos(3t - 1) u(t)$ \
]
#SOLUTION

*(a)* Let $f(t) = cos(3t) u(t)$, then:
$
  F(s) = cal(L){f(t)} = cal(L){cos(3t) u(t)} = s/(s^2 + 9)
$ \

*(b)* Let $f(t) = e^(-10t) u(t)$, then:
$
  F(s) = cal(L){f(t)} = cal(L){e^(-10t) u(t)} = 1/(s + 10)
$ \

*(d)* Let $f(t) = e^(-10t) cos(3t - 1) u(t)$, then:
$
  F(s) 
  &= cal(L){f(t)} = cal(L){e^(-10t) cos(3t - 1) u(t)} \
  &= cal(L){cos(3t - 1) u(t)}(s + 10) \
  &= cal(L){[cos(3t)cos 1 + sin(3t) sin 1] u(t)}(s + 10) \
  &= [cos 1 dot s/(s^2 + 9) + sin 1 dot 3/(s^2 + 9)]_(s -> s+10) \
  &= ((s + 10)cos 1 + 3sin 1)/((s + 10)^2 + 9)
$ \







#pagebreak()
#problem(6.2)[
  A continuous-times signal $x(t)$ has the Laplace transform
  $
    X(s) = (s+1)/(s^2 + 5s + 7)
  $
  Determine the Laplace transform $V(s)$ of the following signals: #v(0.5em)
  *(b)* $v(t) = t x(t)$ #v(0.5em)
  *(d)* $v(t) = display(integral)_0^t x(tau) "d"tau$ #v(0.5em)
  *(e)* $v(t) = x(t) sin(2t)$ #v(0.5em)
]
#SOLUTION

*(b)* Obviously,
$
  V(s) 
  &= cal(L){v(t)} = cal(L){t x(t)} = - X'(s) \
  &= - (1 dot (s^2 + 5s + 7) - (s + 1) dot (2s + 5))/((s^2 + 5s + 7)^2) \
  &= (s^2 + 2s -2)/((s^2 + 5s + 7)^2)
$ \

*(d)* Obviously,
$
  V(s) 
  &= cal(L){v(t)} = cal(L){integral_0^t x(tau)"d"tau} = 1/s dot X(s) \ 
  &= (s+1)/(s dot (s^2 + 5s + 7))
$ \

*(e)* Obviously,
$
  V(s) 
  &= cal(L){v(t)} = cal(L){x(t) sin(2t)} = cal(L){x(t) dot (e^(j 2t) - e^(-j 2t))/(2j)} \   
  &= 1/(2j) dot [X(s - 2j) - X(s + 2j)] \
  &= 1/(2j) dot (j(4s^2 + 8s + 8))/(s^4 + 10s^3 + 47s^2 + 110s + 109) \
  &= (2s^2 + 4s + 4)/(s^4 + 10s^3 + 47s^2 + 110s + 109)
$








#pagebreak()
#problem("6.10")[
  Determine the inverse Laplace transform of each of the functions that follow. Compute the partial fraction expansion analytically for each case. You may use the MATLAB command `residue` to check your answerw for parts (a) to (e). #v(0.5em)
  *(a)* $display(X(s) = (s+2)/(s^2 + 7s + 12))$ #v(0.5em)
  *(c)* $display(X(s) = (2s^2 - 9s - 35)/(s^2 + 4s + 2))$ #v(0.5em)
]
#SOLUTION

*(a)* Obviously,
$
  X(s) = (s+2)/(s^2 + 7s + 12) = (s+2)/((s + 3)(s + 4)) = c_1/(s+3) + c_2/(s+4)
$
It is easy to get:
$
  c_1 &= "Res"[X(s); -3] = lim_(s -> -3) (s+3)X(s) = lim_(s -> -3) (s+2)/(s+4) = -1 \
  c_2 &= "Res"[X(s); -4] = lim_(s -> -4) (s+4)X(s) = lim_(s -> -4) (s+2)/(s+3) = 2 \
$
So,
$
  x(t) 
  &= cal(L)^(-1){X(s)} = cal(L)^(-1){(-1) dot 1/(s+3) + 2 dot 1/(s+4)} \
  &= (-1) dot e^(-3t)u(t) + 2 dot e^(-4t) u(t) \
  &= (-e^(-3t) + 2e^(-4t))u(t)
$ 
Using MATLAB command `residue` can compute residue and pole of function. With following code: \
----------------------------------------------------------------------\
```MATLAB
% 1. 定义多项式系数
% 分子 N(s) = s + 2 => [1, 2]
N1 = [1, 2];
% 分母 D(s) = s^2 + 7s + 12 => [1, 7, 12]
D1 = [1, 7, 12];

% 2. 使用 residue 命令计算留数 Rk 和极点 Pk
[R1, P1] = residue(N1, D1);

% 3. 显示结果
disp('--- Problem 6.10 (a) 结果 ---');
disp('留数 (Rk):'); disp(R1);
disp('极点 (Pk):'); disp(P1);
```
----------------------------------------------------------------------\
We can get the answer: \
----------------------------------------------------------------------\
```
--- Problem 6.10 (a) 结果 ---
留数 (Rk):
     2
    -1

极点 (Pk):
    -4
    -3
```
----------------------------------------------------------------------\
The output is same as my answer. \
#v(4em)


*(c)* Obviously,
$
  X(s) 
  &= (2s^2 - 9s - 35)/(s^2 + 4s + 2) = 2 + (-17s - 39)/((s+2-sqrt(2))(s+2+sqrt(2))) \
  &= 2 + c_1/(s+2-sqrt(2)) + c_2/(s+2+sqrt(2))
$
It is easy to get:
$
  c_1 &= "Res"[X(s); -2+sqrt(2)] = lim_(s -> -2+sqrt(2)) (-17s - 39)/(s + 2 + sqrt(2)) = (-5-17sqrt(2))/(2sqrt(2)) \
  c_2 &= "Res"[X(s); -2-sqrt(2)] = lim_(s -> -2-sqrt(2)) (-17s - 39)/(s + 2 - sqrt(2)) = (5-17sqrt(2))/(2sqrt(2)) \
$
So,
$
  x(t)
  &= cal(L)^(-1){X(s)} = cal(L)^(-1){2 + c_1/(s+2-sqrt(2)) + c_2/(s+2+sqrt(2))} \
  &= cal(L)^(-1){2 + (-5-17sqrt(2))/(2sqrt(2)) dot 1/(s+2-sqrt(2)) + (5-17sqrt(2))/(2sqrt(2)) dot 1/(s+2+sqrt(2))} \
  &= [2delta(t) + (-5-17sqrt(2))/(2sqrt(2)) dot e^(-(2-sqrt(2))t) + (5-17sqrt(2))/(2sqrt(2)) dot e^(-(2+sqrt(2))t)]u(t) \
$
Like part (a), using MATLAB command `residue` to compute residue and pole of function: \
----------------------------------------------------------------------\
```MATLAB
% 1. 定义多项式系数
% 分子 N(s) = 2s^2 - 9s - 35
N2 = [2, -9, -35];
% 分母 D(s) = s^2 + 4s + 2
D2 = [1, 4, 2];

% 2. 使用 residue 命令计算留数 Rk 和极点 Pk
[R2, P2] = residue(N2, D2);

% 3. 显示结果
disp('--- Problem 6.10 (c) 结果 ---');
disp('留数 (Rk):'); disp(R2);
disp('极点 (Pk):'); disp(P2);
```
----------------------------------------------------------------------\
We can get the answer: \
----------------------------------------------------------------------\
```
--- Problem 6.10 (c) 结果 ---
留数 (Rk):
   -6.7322
  -10.2678

极点 (Pk):
   -3.4142
   -0.5858
```
----------------------------------------------------------------------\
The output is same as my answer. \
\






#pagebreak()
#problem(6.14)[
  Use Laplace transform to compute the solution to the following differential equations: #v(0.5em)
  *(a)* $display(("d"y)/("d"t) + 2y = u(t)", "y(0) = 0)$ #v(0.5em)
  *(c)* $display(("d"y)/("d"t) + 10y = 4 sin(2t) u(t)", "y(0) = 1)$ #v(0.5em)
]
#SOLUTION

*(a)* Perform Laplace transform on the formula:
$
  (s+2)Y(s) = 1/s
$
So,
$
  Y(s) = 1/(s(s+2)) = c_1/s + c_2/(s+2)
$
It is easy to get:
$
  c_1 &= "Res"[Y(s); 0] = lim_(s -> 0) 1/(s+2) = 1/2 \
  c_2 &= "Res"[Y(s); -2] = lim_(s -> 0) 1/(s) = -1/2 \
$
So,
$
  y(t) 
  &= cal(L)^(-1){Y(s)} = cal(L)^(-1){1/2 dot 1/s - 1/2 dot 1/(s+2)} \
  &= 1/2 dot u(t) - 1/2 dot e^(-2t) dot u(t) \
  &= 1/2(1-e^(-2t)) u(t)
$ \

*(c)* Perform Laplace transform on the formula:
$
  s Y(s) - y(0) + 10Y(s) = 4 dot 2/(s^2 + 4)
$
Simplify it,
$
  Y(s) = 1/(s + 10) dot (8/(s^2 + 4) + 1) = (s^2+12)/((s^2 + 4)(s + 10))
$
Assume that:
$
  Y(s) = (A s+B)/(s^2 + 4) + C/(s+10)
$
We can get the formulas:
$
  cases(
    A + C = 1,
    10A + B = 0,
    10B + 4C = 12
  )
$
The solution is:
$
  cases(
    display(A = -1/13),
    display(B = 10/13),
    display(C = 14/13),
  )
$
So,
$
  Y(s) 
  &= -1/13 dot s/(s^2 + 4) + 10/13 dot 1/(s^2 + 4) + 14/13 dot 1/(s + 10) \
  y(t)
  &= [-1/13 dot cos(2t) + 5/13 dot sin(2t) + 14/13 dot e^(-10t)] u(t) \
$




#pagebreak()
#problem(6.15)[
  A continuous-time system is given by the input/output differential equation:
  $
    ("d"^2 y(t))/("d"t^2) + 2 ("d"y(t))/("d"t) + 3y(t) = ("d"x(t))/("d"t) + x(t-2)
  $
  *(a)* Compute the transfer function $H(s)$ of the system. \
  *(b)* Compute the impulse response $h(t)$. \
  *(c)* Compute the step response. \
  *(d)* Verify the results of (b) and (c) by simulation, using `lsim` (or `step` and `impulse`) or Simulink.
]
#SOLUTION

*(a)* Let $x(t) = delta(t)$ and $y(t) = h(t)$, then:
$
  (s^2 + 2s + 3s)H(s) = (s + e^(-2s)) dot 1
$
That is:
$
  H(s) = (s + e^(-2s))/(s^2 + 2s + 3)
$ \

*(b)* Simplify $H(s)$ first:
$
  H(s) = s/(s^2 + 2s + 3) + e^(-2s)/(s^2 + 2s + 3)
$
Let $G(s) = display(1/(s^2 + 2s + 3))$, perform inverse Laplace transform on it:
$
  g(t) 
  &= cal(L)^(-1){G(s)} = cal(L)^(-1){1/(s^2 + 2s + 3)} \
  &= cal(L)^(-1){1/((s+1)^2 + 2)} \
  &= e^(-t) dot cal(L)^(-1){1/(s^2 + 2)} \
  &= e^(-t) dot 1/(sqrt(2)) dot sin(sqrt(2)t) u(t) \
$
So,
$
  h(t) = cal(L)^(-1){H(s)} = "d"/("d"t) dot g(t) + g(t - 2)
$
That is:
$
  h(t) = e^(-t) dot [cos(sqrt(2)t) - 1/sqrt(2) sin(sqrt(2)t)] u(t) + 1/sqrt(2) e^(-(t-2))sin[sqrt(2)(t-2)]u(t-2)
$ \

*(c)* Let $x(t) = u(t)$, then:
$
  (s^2 + 2s + 3)Y(s) = (s + e^(-2s)) dot 1/s
$
So,
$
  Y(s) = (s + e^(-2s))/(s dot (s^2 + 2s + 3)) = 1/(s^2 + 2s + 3) + e^(-2s)/(s dot (s^2 + 2s + 3))
$
Where,
$
  cal(L)^(-1){1/(s dot (s^2 + 2s + 3))} = integral_0^t g(tau)"d"tau  = integral_0^t e^(-t) dot 1/(sqrt(2)) dot sin(sqrt(2)t) "d"t eq.delta f(t)
$
After double integral:
$
  f(t) = -1/2 dot [e^(-t)cos(sqrt(2)t) -1 + 1/sqrt(2) e^(-t) sin(sqrt(2)t) + f(t)]
$
So,
$
  f(t) = -1/3 dot [e^(-t)cos(sqrt(2)t) -1 + 1/sqrt(2) e^(-t) sin(sqrt(2)t)]
$
Then,
$
  y(t) = cal(L)^(-1){Y(s)} = g(t) + f(t-2)
$
That is:
$
  y(t) 
  &= e^(-t) dot 1/(sqrt(2)) dot sin(sqrt(2)t)u(t) \
  &-1/3 dot {e^(-(t-2))cos[sqrt(2)(t-2)] -1 + 1/sqrt(2) e^(-(t-2)) sin(sqrt(2)(t-2))}u(t-2)
$\
#v(4em)

*(d)* Let's using MATLAB command `step` and `impulse` to verify the results of (b) and (c), the code is like following: \
------------------------------------------------------------\
```MATLAB
clc; clear; close all;

%% 1. 系统
s = tf('s');
H = (s + exp(-2*s)) / (s^2 + 2*s + 3);

%% 2. 仿真
% 时间
t = 0:0.01:10; 

[h_sim, t_sim] = impulse(H, t);
[y_sim, ~]     = step(H, t);

%% 3. 我的答案
sqrt2 = sqrt(2);
u  = @(t) (t >= 0); % 定义单位阶跃函数
u2 = @(t) (t >= 2); % 定义延时2秒的阶跃函数

% --- (b) 冲击响应 h(t) ---
term1_h = exp(-t) .* (cos(sqrt2*t) - (1/sqrt2)*sin(sqrt2*t)) .* u(t);
term2_h = (1/sqrt2) * exp(-(t-2)) .* sin(sqrt2*(t-2)) .* u2(t);
h_analytical = term1_h + term2_h;

% --- (c) 阶跃响应 y(t) ---
g_t = exp(-t) .* (1/sqrt2) .* sin(sqrt2*t) .* u(t);
dt = t - 2; % delayed time
term_inside = exp(-dt).*cos(sqrt2*dt) - 1 + (1/sqrt2)*exp(-dt).*sin(sqrt2*dt);
f_t_delayed = (-1/3) * term_inside .* u2(t);
y_analytical = g_t + f_t_delayed;

%% 4. 画图
figure('Name', 'Problem 6.15 Verification', 'Color', 'w');

% --- 子图 1: 冲击响应对比 ---
subplot(2,1,1);
plot(t, h_sim, 'b-', 'LineWidth', 2); hold on;
plot(t, h_analytical, 'r--', 'LineWidth', 2);
title('Verify (b): Impulse Response h(t)');
xlabel('Time (s)'); ylabel('Amplitude');
legend('MATLAB Simulation (impulse)', 'Analytical Result', 'Location', 'Best');
grid on;

% --- 子图 2: 阶跃响应对比 ---
subplot(2,1,2);
plot(t, y_sim, 'b-', 'LineWidth', 2); hold on;
plot(t, y_analytical, 'r--', 'LineWidth', 2);
title('Verify (c): Step Response y(t)');
xlabel('Time (s)'); ylabel('Amplitude');
legend('MATLAB Simulation (step)', 'Analytical Result', 'Location', 'Best');
grid on;
```
------------------------------------------------------------\
The output figure is:
#image("image/11_6_15_d.png", width: 90%)
Obviously, the output(#text(fill: blue)[Blue Line]) is same as my answer(#text(fill: red)[Red Dotted Line]), so MATLAB verify my answer.