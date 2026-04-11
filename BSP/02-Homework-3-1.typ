#import "@local/zju-typst-tplt:0.2.0": *

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-10-11" // 日期，格式为 YYYY-MM-DD
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
For the following systems, determine the ① Linearity ② Time-Invariance ③ Causality, and explain the reason.

(1) $y[n] = T(x[n]) = limits(sum)_(k=n-n_0)^(n+n_0) x[k]$

(2) $y[n] = T(x[n]) = x[-n]$

(3) $y[n] = T(x[n]) = x[n] + 3u[n-1]$
]
#SOLUTION

(1) $y[n] = T(x[n]) = limits(sum)_(k=n-n_0)^(n+n_0) x[k]$ 

① *Linearity:* Obviously, $ T(a x_1[n] + b x_2[n]) &= limits(sum)_(k=n-n_0)^(n+n_0) a x_1[k] + b x_2[k] \ &= limits(sum)_(k=n-n_0)^(n+n_0) a x_1[k] + limits(sum)_(k=n-n_0)^(n+n_0) b x_2[k] = a y_1[n] + b y_2[n] $ So, the system is linear.

② *Time-Invariance:* $ T(x[n-N])= limits(sum)_(k=n-n_0)^(n+n_0) x[k-N]  = limits(sum)_(k=n-N-n_0)^(n-N+n_0) x[k] = y[n-N] $ So, the system is time-invariant.

③ *Causality:* Obviously, $y[n]$ is related to $x[n+n_0]$, so the system is noncausal.

(2) $y[n] = T(x[n]) = x[-n]$

① *Linearity:* Obviously, $ T(a x_1[n] + b x_2[n]) &= a x_1[-n] + b x_2[-n] = a y_1[n] + b y_2[n] $ So, the system is linear.

② *Time-Invariance:* $ T(x[n-N]) = x[-n-N] != x[-n+N] = y[n-N] $ So, the system is time-varying.

③ *Causality:* Obviously, Let $n < 0$, $y[n]$ is related to $x[-n]$, which is noncausal.

(3) $y[n] = T(x[n]) = x[n] + 3u[n-1]$

① *Linearity:* Obviously, $ T(a x_1[n] + b x_2[n]) = a x_1[n] + b x_2[n] + 3u[n-1] != a y_1[n] + b y_2[n] $ So the system is nonlinear.

② *Time-Invariance: * Obviously, $ T(x[n-N]) = x[n-N] + 3u[n-1] != y[n-N] $ So the system is time-varying.

③ *Causality: * Obviously, $y[n]$ is only related to $x[n]$ and $u[n-1]$, so the system is causal.

#problem(2)[
    Considering the following differential equation: $ ("d"^2y(t))/("d" t^2) + 2("d" y(t))/("d"t) + y(t) = 0, y(0)=2, y'(0)=-1 $ 

    *(a)* Show that the solution is given by $y(t) = 2e^(-t) + t e^(-t)$ \
    *(b)* Using Euler's approximation of derivatives with $T$ arbitrary and input $x(t)$ arbitrary, derive a difference equation model.\
    *(c)* Using the answer in part (b) and the M-file `recur` with $T = 0.4$, compute the approximation to $y(t)$.\
    *(d)* Repear part (c) for $T = 0.1$ seconds.\
    *(e)* Plot the repenses obtained in parts (a), (c), and (d) for $0 <= t <= 10$, and compare the results.
]
#SOLUTION

*(a)* Get the characteristic equation of 2th homogeneous differential equation. $ lambda^2+2lambda+1=0 $ and it's easy to get the solution: $lambda_1 = lambda_2 = -1$, then the solution of the diffenrential equation must be: $y(t) = c_1e^(-t) + c_2t e^(-t)$.Then, let's think about the condition $y(0) = 2, y'(0) = -1$, we will get: $ cases(
    c_1 = 2,
    -c_1 + c_2 = -1
) $ Obviously, $ cases(
    c_1 = 2,
    c_2 = 1
) $ So the solution of the differential equation is: $ y(t) = 2e^(-t) + t e^(-t) $\

*(b)* Using Euler's approximation, we will get: $ cases(
    "d"y = y[n],
    "d"y"/""d"t = (y[n+1] - y[n])"/"T,
    "d"^2y"/""d"t^2 = (y[n+2]-2y[n+1]+y[n])"/"T^2
) $ put it into the original differential equation, we will get: $ 
   &(y[n+2]-2y[n+1]+y[n])/(T^2) + 2dot (y[n+1] - y[n])/T + y[n] = 0\ 
=> &y[n+2] + 2(T-1)y[n+1] + (1-T)^2y[n] = 0\
=> &y[n+2] = 2(1-T)y[n+1] - (1-T)^2y[n]\
=> &y[n] = 2(1-T)y[n-1] - (1-T)^2y[n-2]\
 $ and $ 
 &because y(0) = y[0] = 2, y'(0) = (y[1] - y[0])/T = -1\
 &therefore cases(
    y[0] = 2,
    y[1] = 2-T
 )
 $ Now, we get the recursive formula: $y[n] + 2(T-1)y[n-1] + (T-1)^2y[n-2] = 0$. It's characteristic equation is: $lambda^2 + 2(T-1)lambda + (T-1)^2 = 0$. Obviously, the solution is: $lambda_1 = lambda_2 = 1-T$. We know that the solution of the sequence must be: $y[n] = (A+B n)dot lambda^n$. Substitute the above equation, we will get: $ cases(
    y[0] = A = 2,
    y[1] = (A + B)dot lambda = (A + B)dot (1-T) = 2-T
 ) $ The solution is: $ cases(
    A = 2,
    B = T"/"(1-T)
 ) $ So the solution of original difference equation is: $ y[n] = (2 + (T n)/(1-T))dot (1-T)^n $\

 *(c)* put $T = 0.4$ into the answer in part (b), we will get: $ y[n] = (2 + (T n)/(1-T))dot (1-T)^n = (2 + (2n)/(3))dot (3/5)^n $ The conparison figure will be seen in (e).\ 

 *(d)* put $T = 0.1$ into the answer in part (b), we will get: $ y[n] = (2 + (T n)/(1-T))dot (1-T)^n = (2 + (n)/(9))dot (9/10)^n $ The conparison figure will be seen in (e).\

 *(e)* Write the MATLAB code below:\
--------------------------------------------------------------------------------
 ```MATLAB
%% 2.27 (e)
clear; clc; close all;

% 1. Set Time
t_a = 0 : 0.001 : 10;
t_c = 0 : 0.4 : 10;
t_d = 0 : 0.1: 10;
n_c = t_c / 0.4;
n_d = t_d / 0.1;

% 2. Signal
y_a = 2 * exp(-t_a) + t_a .* exp(-t_a);
y_c = (2 + 2*n_c/3) .* (3/5).^n_c;
y_d = (2 + n_d/9) .* (9/10).^n_d;

% 3. Figure
figure;
plot(t_a, y_a, 'LineWidth', 4, "Color", "red");
hold on
plot(t_c, y_c, 'o', 'MarkerSize', 6, 'LineWidth', 1, "Color", "blue");
plot(t_d, y_d, 'o', 'MarkerSize', 4, 'LineWidth', 1, "Color", "green");
hold off;
title('Compare the solution of the differencial equation with the aprroximation', 'FontSize', 13)
xlim([0, max(t_a)]);
ylim([0, max([y_a, y_c, y_d])]);

% 4. Add legend
legend({'(a) $y(t) = 2e^{-t} + te^{-t}$', ...
        '(c) $y[n] = \left(2 + \frac{2n}{3}\right)\left(\frac{3}{5}\right)^n,\ T = 0.4$', ...
        '(d) $y[n] = \left(2 + \frac{n}{9}\right)\left(\frac{9}{10}\right)^n,\ T = 0.1$'}, ...
       'Interpreter', 'latex', 'FontSize', 12, 'Location', 'northeast');

% 5. Add watermark
watermark = annotation('textbox', ...
    'String', '3230100633\_HZJ', ...
    'FontSize', 40, ...
    'Color', [0.9, 0.9, 0.9, 0.01], ...
    'Rotation', 30, ...
    'EdgeColor', 'none', ...
    'Position', [0.33, 0.22, 0.5, 0.2], ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'FitBoxToText', 'off'); 
uistack(watermark, 'bottom');

% 6. save
saveas(gcf, '02_2.27(e).png');
 ```
--------------------------------------------------------------------------------

 Then, we will get the figure: 

 #figure(image("image/02_2.27(e).png", width: 100%))

#problem(3)[
    Compute the unit-pulse response $h[n]$ for $n = 0, 1, 2, 3$ for each of the following discrete-time systems:\
    *(a)* $y[n+1] + y[n] = 2x[n]$\
    *(e)* $y[n+2] + 1"/"4y[n+1] - 3"/"8y[n] = 2x[n+2] - 3x[n]$
]

#SOLUTION

*(a)* $ y[n+1] + y[n] = 2x[n] => h[n+1] + h[n] = 2delta [n] $
Assuming that $forall n < 0, h[n] = 0$, then we will get:\
Let $n = -1, h[0] + h[-1] = 2delta [-1] = 0 => h[0] = 0$.\
Let $n = 0, h[1] + h[0] = 2delta [0] = 2 => h[1] = 2$.\
Let $n = 1, h[2] + h[1] = 2delta [1] = 0 => h[2] = -2$.\
Let $n = 2, h[3] + h[2] = 2delta [2] = 0 => h[3] = 2$.\

*(e)* $ &y[n+2] + 1"/"4y[n+1] - 3"/"8y[n] = 2x[n+2] - 3x[n] \ => &h[n+2] + 1"/"4h[n+1] - 3"/"8h[n] = 2delta [n+2] - 3delta [n] $
Assuming that $forall n < 0, h[n] = 0$, then we will get:\
Let $n = -2, h[0] + 1"/"4h[-1] - 3"/"8h[-2] = 2delta [0] - 3delta [-2] = 2 => h[0] = 2$.\
Let $n = -1, h[1] + 1"/"4h[0] - 3"/"8h[-1] = 2delta [1] - 3delta [-1] = 0 => h[1] = -0.5$.\
Let $n = 0, h[2] + 1"/"4h[1] - 3"/"8h[0] = 2delta [2] - 3delta [0] = -3 => h[2] =  -2.125$.\
Let $n = 1, h[3] + 1"/"4h[2] - 3"/"8h[1] = 2delta [3] - 3delta [1] = 0 => h[3] = 0.34375$.\

#problem(4)[
    For the discrete-time signals $x[n]$ and $v[n]$ shown in Figure P2.7, do the following:

     #figure(image("image/02_2.7(a).png", width: 100%))
     #figure(image("image/02_2.7(c).png", width: 100%))

     *(a)* Compute the convolution $x[n]*v[n]$ for all $n >= 0$. Sketch the results.  \
     *(b)* Repeat part (a), using the M-file conv
]

#SOLUTION

*(a)* 
for (a) in Figure P2.7, the following is the convolution: $ 
        because &x[n] * v[n] = sum_(k = -infinity)^infinity x[k] dot v[n-k] \
        therefore &x[0] * v[0] = sum_(k = -infinity)^infinity x[k] dot v[-k] = x[0] dot v[0] = 1 \
        &x[1] * v[1] = sum_(k = -infinity)^infinity x[k] dot v[1-k] = 2 \
        &x[2] * v[2] = sum_(k = -infinity)^infinity x[k] dot v[2-k] = 3 \
        &x[3] * v[3] = sum_(k = -infinity)^infinity x[k] dot v[3-k] = 3 \
        &x[4] * v[4] = sum_(k = -infinity)^infinity x[k] dot v[4-k] = 2 \
        &x[5] * v[5] = sum_(k = -infinity)^infinity x[k] dot v[5-k] = x[2] dot v[3] = 1 \
        &x[n] * v[n] = sum_(k = -infinity)^infinity x[k] dot v[n-k] = 0, forall n in.not \{0, 1, ..., 5\}. \
        $\
for (c) in Figure P2.7, the following is the convolution: $ 
        because &x[n] * v[n] = sum_(k = -infinity)^infinity x[k] dot v[n-k] \
        therefore &x[1] * v[1] = sum_(k = -infinity)^infinity x[k] dot v[1-k] = x[0] dot v[1] = 2 \
        &x[2] * v[2] = sum_(k = -infinity)^infinity x[k] dot v[2-k] = 1 + 4 = 5 \
        &x[3] * v[3] = sum_(k = -infinity)^infinity x[k] dot v[3-k] = x[1] dot v[2] = 2 \
        &x[n] * v[n] = sum_(k = -infinity)^infinity x[k] dot v[n-k] = 0, forall n in.not \{1, 2, 3\}. \
        $\

*(b)* 
For (a) in Figure P2.7,  write the MATLAB code below:\
--------------------------------------------------------------------------------
```MATLAB
%% Convolution - (a)
clear; clc; close all;

% Define x[n] & v[n]
nx = 0 : 2;
x = [1, 1, 1];
nv = 0 : 3;
v = [1, 1, 1, 1];

% compute convolution
ny_start = nx(1) + nv(1);
ny_end = nx(end) + nv(end);
ny = ny_start : ny_end;
y = conv(x, v);

% Print the answer
fprintf('===== Answer =====\n');
fprintf('x[n] = ');
fprintf('%d ', x);
fprintf('(n = %d to %d)\n', nx(1), nx(end));

fprintf('v[n] = ');
fprintf('%d ', v);
fprintf('(n = %d to %d)\n', nv(1), nv(end));

fprintf('y[n] = x[n]*v[n]:\n');
for i = 1 : length(y)
    fprintf('y[%d] = %d\n', ny(i), y(i));
end

% Figure the answer
figure('Position', [100, 100, 1200, 400]);

subplot(1,3,1);
plot(nx, x, 'o', 'LineWidth', 2);
xlim([-2, 4]);
ylim([0, 3]);
xlabel('n', 'Interpreter', 'latex');
ylabel('x[n]', 'Interpreter', 'latex');
axis equal;
grid on;

subplot(1,3,2);
plot(nv, v, 'o', 'LineWidth', 2);
xlim([-2, 4]);
ylim([0, 3]);
xlabel('n', 'Interpreter', 'latex');
ylabel('v[n]', 'Interpreter', 'latex');
axis equal;
grid on;

subplot(1,3,3);
plot(ny, y, 'o', 'LineWidth', 2);
xlim([-2, 6]);
ylim([0, 3]);
xlabel('n', 'Interpreter', 'latex');
ylabel('x[n] * v[n]', 'Interpreter', 'latex');
axis equal;
grid on;

% save figure
saveas(gcf, "02_2.7(a)_ans.png");
```
--------------------------------------------------------------------------------

Then, you will git the answer:

```
===== Answer =====
x[n] = 1 1 1 (n = 0 to 2)
v[n] = 1 1 1 1 (n = 0 to 3)
y[n] = x[n]*v[n]:
y[0] = 1
y[1] = 2
y[2] = 3
y[3] = 3
y[4] = 2
y[5] = 1
```

And the figure: 
#figure(image("image/02_2.7(a)_ans.png", width: 100%))


For (c) in Figure P2.7,  write the MATLAB code below:\
--------------------------------------------------------------------------------
```MATLAB
%% Convolution - (c)
clear; clc; close all;

% Define x[n] & v[n]
nx = 0 : 2;
x = [2, 1, 0];
nv = 0 : 2;
v = [0, 1, 2];

% compute convolution
ny_start = nx(1) + nv(1);
ny_end = nx(end) + nv(end);
ny = ny_start : ny_end;
y = conv(x, v);

% Print the answer
fprintf('===== Answer =====\n');
fprintf('x[n] = ');
fprintf('%d ', x);
fprintf('(n = %d to %d)\n', nx(1), nx(end));

fprintf('v[n] = ');
fprintf('%d ', v);
fprintf('(n = %d to %d)\n', nv(1), nv(end));

fprintf('y[n] = x[n]*v[n]:\n');
for i = 1 : length(y)
    fprintf('y[%d] = %d\n', ny(i), y(i));
end

% Figure the answer
figure('Position', [100, 100, 1200, 400]);

subplot(1,3,1);
plot(nx, x, 'o', 'LineWidth', 2);
xlim([-2, 4]);
ylim([0, 3]);
xlabel('n', 'Interpreter', 'latex');
ylabel('x[n]', 'Interpreter', 'latex');
axis equal;
grid on;

subplot(1,3,2);
plot(nv, v, 'o', 'LineWidth', 2);
xlim([-2, 4]);
ylim([0, 3]);
xlabel('n', 'Interpreter', 'latex');
ylabel('v[n]', 'Interpreter', 'latex');
axis equal;
grid on;

subplot(1,3,3);
plot(ny, y, 'o', 'LineWidth', 2);
xlim([-2, 6]);
ylim([0, 3]);
xlabel('n', 'Interpreter', 'latex');
ylabel('x[n] * v[n]', 'Interpreter', 'latex');
axis equal;
grid on;

% save figure
saveas(gcf, "02_2.7(c)_ans.png");
```

Then, you will git the answer:

```
===== Answer =====
x[n] = 2 1 0 (n = 0 to 2)
v[n] = 0 1 2 (n = 0 to 2)
y[n] = x[n]*v[n]:
y[0] = 0
y[1] = 2
y[2] = 5
y[3] = 2
y[4] = 0
```

And the figure: 
#figure(image("image/02_2.7(c)_ans.png", width: 100%))

#problem(5)[
    For the discrete-time signals $x[n]$ and $v[n]$ given in each of the following parts, compute the convolution $x[n]*v[n]$ for $n >= 0$ \[ compute $x[n]*v[n]$ for $n >= -2$ in part (b) \].\
    *(b)* $x[n] = 1$ for $-1 <= n <= 2$ and $x[n] = 0$ for all other integers $n$; $v[-1] = -1; v[0] = 0; v[1] = 8; v[2] = 2;  v[3] = 3$ and $v[n] = 0$ for all other integers $n$.\
    *(e)* $x[n] = u[n]$, $v[n] = u[n]$, where $u[n]$ is the discrete-time step function. \
    *(g)* $x[n] = delta [n] - delta [n-2]$, where $delta [n]$ is the unit pulse concentrated at $n = 0$; $v[n] = cos(pi n"/"3)$ for all integers $n >= 0$, $v[n] = 0$ for all integers $n < 0$.
]

#SOLUTION\

*(b)* $ 
        because &x[n] * v[n] = sum_(k = -infinity)^infinity x[k] dot v[n-k] \
        therefore &x[-2] * v[-2] = sum_(k = -infinity)^infinity x[k] dot v[-2-k] = x[-1] dot v[-1] = -1 \
        &x[-1] * v[-1] = sum_(k = -infinity)^infinity x[k] dot v[-1-k] = -1 \
        &x[0] * v[0] = sum_(k = -infinity)^infinity x[k] dot v[-k] = 7 \
        &x[1] * v[1] = sum_(k = -infinity)^infinity x[k] dot v[1-k] = 9 \
        &x[2] * v[2] = sum_(k = -infinity)^infinity x[k] dot v[2-k] = 13 \
        &x[3] * v[3] = sum_(k = -infinity)^infinity x[k] dot v[3-k] = 13 \
        &x[4] * v[4] = sum_(k = -infinity)^infinity x[k] dot v[4-k] = 5 \
        &x[5] * v[5] = sum_(k = -infinity)^infinity x[k] dot v[5-k] = x[2] dot v[3] = 3 \
        &x[n] * v[n] = sum_(k = -infinity)^infinity x[k] dot v[n-k] = 0, forall n in.not \{0, 1, ..., 5\}. \
        $\

*(e)* $
        because &x[n] * v[n] = sum_(k = -infinity)^infinity u[k] dot u[n-k] \
        therefore &forall n < 0, x[n] * v[n] = 0. \
        & forall n >= 0, sum_(k = -infinity)^infinity u[k] dot u[n-k] = sum_(k = 0)^n u[k] dot u[n-k] = n + 1.\
        therefore & x[n] * v[n] = (n+1)dot  u[n]
        $\

*(g)* $
        because & x[n] = delta [n] - delta [n-2], v[n] = cos((n pi)/(3)) dot u[n]. \
        therefore &x[n] * v[n] = sum_(k = -infinity)^infinity (delta [k] - delta [k-2]) dot v[n-k] \
        =& sum_(k = -infinity)^infinity delta [k] dot v[n-k] - sum_(k = -infinity)^infinity delta [k-2] dot v[n-k] \
        =& v[n] - v[n-2]\
        =& cos((n pi)/(3)) dot u[n] - cos(((n-2) pi)/(3)) dot u[n-2]
        $\
For $n < 0$: $x[n] * v[n] = 0$,\
For $n = 0$: $x[n] * v[n] = x[0] * v[0]  = v[0] = cos(0) - 0 = 1$,\
For $n = 1$: $x[n] * v[n] = x[1] * v[1]  = v[1] = cos(pi "/" 3) - 0 = 0.5$,\
For $n >= 2$: $x[n] * v[n] = cos((n pi)/(3)) - cos(((n-2) pi)/(3)) = -sqrt(3)dot sin(((n-1)pi)/(3))$.


















































