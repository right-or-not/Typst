#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-11-27" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Signal Processing" // 课程名称
#let proj-name = "Second Exercise for Chapter 6" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)


#problem(1)[
  Compute the N-point DFT of the following sequence for $0 <= n <= N-1$:\
  *(1)*
  $
    x[n] = cases(
      e^(j Omega_0 n)"  "&", "0<=n<=N-1, 
      0&", others"
    )
  $\
  *(2)* $x[n] = [1, 1, 1, 0, 1]$\
  *(3)* 
  $
    x[n] = cases(
      cos((2 pi m n)"/"N)"  "&", "0<=n<=N-1,
      0&", others"
    )" , "0<m<N
  $
]
#SOLUTION

*(1)* 
$
  X_k 
  &= sum_(n = 0)^(N-1) x[n] dot exp(-j dot (2 k pi)/ N dot n) \
  & = sum_(n = 0)^(N-1) e^(j Omega_0 n) dot exp(-j dot (2 k pi)/ N dot n) \
  &= (1 - exp(j dot (N Omega_0 - 2 k pi)))/(1 - exp(j dot (Omega_0 - 2 k pi"/"N))) \
  &= (1 - exp(j N Omega_0))/(1 - exp(j dot (Omega_0 - 2 k pi"/"N))) ", " 0 <= k <= N-1 \
$\

#text(fill: red)[
  when 
  $
    Omega_0 = (2 k pi)/N, X_k = N dot delta[k - m]
  $
]

*(2)* 
$
  X_k 
  &= sum_(n = 0)^(N-1) x[n] dot exp(-j dot (2 k pi)/ N dot n) \
  &= sum_(n = 0)^(N-1) exp(-j dot (2 k pi)/ N dot n) - exp(-j dot (2 k pi)/N dot 3) \
  &= (1 - exp(-j dot 2 k pi))/(1 - exp(-j dot 2 k pi "/" N)) - exp(-j dot (2 k pi)/N dot 3) \
$
when $k = 0$, 
$
  X_k = X_0 =  
  &= (1 - exp(-j dot 2 k pi))/(1 - exp(-j dot 2 k pi "/" N)) - exp(-j dot (2 k pi)/N dot 3) \
  &= (j dot 2 pi)/(j dot 2 pi "/" N) - 1 \
  &= N - 1 \
$
when $k eq.not 0$,
$
  X_k 
  &= (1 - exp(-j dot 2 k pi))/(1 - exp(-j dot 2 k pi "/" N)) - exp(-j dot (2 k pi)/N dot 3) \
  &= - exp(-j dot (2 k pi)/N dot 3) \
  &= - exp(-j dot (6 k pi)/N) \
$ 
Let $N = 5$, we will get:
$
  X_k = 5delta[k] - e^(-j dot (6 k pi)"/"5)", "0<=k<=4
$\

*(3)* 
$
  X_k 
  &= sum_(n = 0)^(N-1) x[n] dot exp(-j dot (2 k pi)/ N dot n) \
  &= sum_(n = 0)^(N-1) 1/2[e^(j (2 pi m n)"/"N) + e^(-j (2 pi m n)"/"N)] dot exp(-j dot (2 k pi)/ N dot n) \
  &= 1/2 dot (1 - exp(j dot (2m pi - 2 k pi)))/(1 - exp(j dot (2m pi - 2k pi)"/"N)) 
  + 1/2 dot (1 - exp(-j dot (2m pi + 2 k pi)))/(1 - exp(-j dot (2m pi + 2k pi)"/"N)) \
$
when $k = m$:
$
  1/2 dot (1 - exp(j dot (2m pi - 2 k pi)))/(1 - exp(j dot (2m pi - 2k pi)"/"N)) = 1/2 dot (2j pi)/(2j pi "/"N) = N/2
$
when $k + m = N$, that is: $k = N - m$:
$
  1/2 dot (1 - exp(-j dot (2m pi + 2 k pi)))/(1 - exp(-j dot (2m pi + 2k pi)"/"N))  = 1/2 dot (2j pi)/(2j pi"/"N) = N/2
$
So the answer is:
$
  X_k = N/2 dot delta[k-m] + N/2 dot delta[k + m - N]
$





#pagebreak()
#problem(4.13)[
  Using the MATLAB M-file `dft`, compute the 32-poingt DFT of the signals (a)-(f).Express your answer by plogging the amplitude $|X_k|$ and phase $angle X_k$ of the DFTs.\
  *(c)* $x[n] = n, 0 <= n <= 20, x[n] = 0, "for all other" n$\
  *(e)* $x[n] = cos(10 pi n "/" 11), 0 <= n <= 10, x[n] = 0" for all other" n$\
  *(f)* $x[n] = cos(9 pi n "/" 11), 0 <= n <= 10, x[n] = 0" for all other" n$\
]
#SOLUTION

First, define MATLAB M-file function `dft` like below:\
------------------------------------------------------------\
```matlab 
% Dsicrete Fourier Transform
function Xk = dft(x)
    [N, M] = size(x);
    if M ~= 1
        x = x';
        N = M;
    end
    Xk = zeros(N, 1);
    n = 0 : N-1;
    for k = 0:N-1
        Xk(k+1) = exp(-j * 2 * k  * pi * n / N) * x;
    end
```
------------------------------------------------------------\
Then start plot the figure of every $x[n]$.
#v(3em)

*(c)* Write MATLAB M-file like below to caculate DFT{$x[n]$}:\
------------------------------------------------------------\
```matlab
clear; clc; close all;

% init x[n]
N = 32;
x = zeros(N, 1);
for n = 0:20
    x(n+1) = n;
end

% calculate X_k and print it
X_k = dft(x);
fprintf("X_k: \n");
for n = 0:N-1
    fprintf("X_k[%d] = %.2f + %.2fj, \n", n, real(X_k(n+1)), imag(X_k(n+1)));
end
fprintf("\n");

% plot figure
figure('Position', [100, 100, 600, 600]);

subplot(3, 1, 1);
stem(0:N-1, x, 'black', 'filled', 'LineWidth', 1);
title("(c) Time Domain: $x[n] = n$", Interpreter="latex", FontSize=12);
xlabel('$n$', Interpreter='latex');
ylabel('$x[n]$', Interpreter='latex');
grid on;

subplot(3, 1, 2);
stem(0:N-1, abs(X_k), 'r', 'filled', 'LineWidth', 1);
title('(c) Amplitude of $X_k$: $|X_k|$', Interpreter='latex', FontSize=12);
xlabel('$k$', Interpreter='latex');
ylabel('$|X_k|$', Interpreter='latex');
grid on;

subplot(3, 1, 3);
stem(0:N-1, angle(X_k), 'b', 'filled', 'LineWidth', 1);
title('(c) Phase of $X_k$: $\angle X_k$', Interpreter='latex', FontSize=12);
xlabel('$k$', Interpreter='latex');
ylabel('$\angle X_k$', Interpreter='latex');
grid on; 

% save
saveas(gcf, '09_2_(c).png');
```
------------------------------------------------------------\
Get the Output like this:\
------------------------------------------------------------\
```
X_k: 
X_k[0] = 210.00 + 0.00j, 
X_k[1] = -123.29 + -46.32j, 
X_k[2] = 43.70 + -16.57j, 
X_k[3] = -17.11 + 32.48j, 
X_k[4] = -13.41 + -24.14j, 
X_k[5] = 19.97 + 5.36j, 
X_k[6] = -15.78 + 10.81j, 
X_k[7] = 0.48 + -16.13j, 
X_k[8] = 10.00 + 10.00j, 
X_k[9] = -13.59 + 1.56j, 
X_k[10] = 6.32 + -10.36j, 
X_k[11] = 3.20 + 11.08j, 
X_k[12] = -10.59 + -4.14j, 
X_k[13] = 9.14 + -5.12j, 
X_k[14] = -2.25 + 10.26j, 
X_k[15] = -6.81 + -7.95j, 
X_k[16] = 10.00 + -0.00j, 
X_k[17] = -6.81 + 7.95j, 
X_k[18] = -2.25 + -10.26j, 
X_k[19] = 9.14 + 5.12j, 
X_k[20] = -10.59 + 4.14j, 
X_k[21] = 3.20 + -11.08j, 
X_k[22] = 6.32 + 10.36j, 
X_k[23] = -13.59 + -1.56j, 
X_k[24] = 10.00 + -10.00j, 
X_k[25] = 0.48 + 16.13j, 
X_k[26] = -15.78 + -10.81j, 
X_k[27] = 19.97 + -5.36j, 
X_k[28] = -13.41 + 24.14j, 
X_k[29] = -17.11 + -32.48j, 
X_k[30] = 43.70 + 16.57j, 
X_k[31] = -123.29 + 46.32j, 
```
------------------------------------------------------------\
And the figure:
#image("image/09_2_(c).png", width: 90%)\



*(e)* The code is like part(c), just change the definition of $x[n]$, and get the Output:\
------------------------------------------------------------\
```
X_k:
X_k[0] = 0.00 + 0.00j, 
X_k[1] = 0.74 + 0.49j, 
X_k[2] = 0.79 + -0.32j, 
X_k[3] = -0.02 + 0.10j, 
X_k[4] = 0.70 + 0.72j, 
X_k[5] = 0.87 + -0.16j, 
X_k[6] = -0.09 + 0.22j, 
X_k[7] = 0.68 + 1.06j, 
X_k[8] = 1.02 + 0.02j, 
X_k[9] = -0.27 + 0.39j, 
X_k[10] = 0.66 + 1.73j, 
X_k[11] = 1.41 + 0.34j, 
X_k[12] = -0.84 + 0.76j, 
X_k[13] = 0.57 + 4.40j, 
X_k[14] = 5.27 + 2.85j, 
X_k[15] = 4.03 + -1.62j, 
X_k[16] = 1.00 + -0.00j, 
X_k[17] = 4.03 + 1.62j, 
X_k[18] = 5.27 + -2.85j, 
X_k[19] = 0.57 + -4.40j, 
X_k[20] = -0.84 + -0.76j, 
X_k[21] = 1.41 + -0.34j, 
X_k[22] = 0.66 + -1.73j, 
X_k[23] = -0.27 + -0.39j, 
X_k[24] = 1.02 + -0.02j, 
X_k[25] = 0.68 + -1.06j, 
X_k[26] = -0.09 + -0.22j, 
X_k[27] = 0.87 + 0.16j, 
X_k[28] = 0.70 + -0.72j, 
X_k[29] = -0.02 + -0.10j, 
X_k[30] = 0.79 + 0.32j, 
X_k[31] = 0.74 + -0.49j, 
```
------------------------------------------------------------\
And the figure:
#image("image/09_2_(e).png", width: 90%)\

*(f)* Likewise, change $x[n]$ and get the Output:\
------------------------------------------------------------\
```
X_k: 
X_k[0] = 1.00 + 0.00j, 
X_k[1] = 0.27 + -0.39j, 
X_k[2] = 0.21 + 0.53j, 
X_k[3] = 1.02 + 0.23j, 
X_k[4] = 0.31 + -0.29j, 
X_k[5] = 0.11 + 0.73j, 
X_k[6] = 1.11 + 0.53j, 
X_k[7] = 0.35 + -0.20j, 
X_k[8] = -0.09 + 1.09j, 
X_k[9] = 1.34 + 1.11j, 
X_k[10] = 0.42 + -0.11j, 
X_k[11] = -0.83 + 2.23j, 
X_k[12] = 2.72 + 4.15j, 
X_k[13] = 5.55 + 0.45j, 
X_k[14] = 2.83 + -2.74j, 
X_k[15] = 0.20 + -1.50j, 
X_k[16] = 0.00 + -0.00j, 
X_k[17] = 0.20 + 1.50j, 
X_k[18] = 2.83 + 2.74j, 
X_k[19] = 5.55 + -0.45j, 
X_k[20] = 2.72 + -4.15j, 
X_k[21] = -0.83 + -2.23j, 
X_k[22] = 0.42 + 0.11j, 
X_k[23] = 1.34 + -1.11j, 
X_k[24] = -0.09 + -1.09j, 
X_k[25] = 0.35 + 0.20j, 
X_k[26] = 1.11 + -0.53j, 
X_k[27] = 0.11 + -0.73j, 
X_k[28] = 0.31 + 0.29j, 
X_k[29] = 1.02 + -0.23j, 
X_k[30] = 0.21 + -0.53j, 
X_k[31] = 0.27 + 0.39j, 
```
------------------------------------------------------------\
And the figure:
#image("image/09_2_(f).png", width: 90%)







#pagebreak()
#problem(4.17)[
  Use the MATLAB M-file `dft` with $N = 10$ to approximate the DTFT of the signal plotted in Figure P4.1b. Plot the amplitude and phase spectrum for $X_k$ versus $Omega = 2pi k "/"N$. Compare this result to the DTFT obtained in Problem 4.1 over the frequency range $Omega = 0$ to $Omega = 2pi$. Repeat for $N = 20$.
  #image("image/09_3.png", width: 90%)
]
#SOLUTION

We can write $x[n]$ as:
$
  x[n] = 2u[n+2] + u[n-3] -3u[n-5]
$
We should write the definition of function `dtft` first, because we are required to plot the DTFT figure. The definition is like this:\
------------------------------------------------------------\
```matlab
% Discrete-Time Fourier Transform
function Xw = dtft(x, w)
    [N, M] = size(x);
    if M ~= 1
        x = x';
        N = M;
    end
    if nargin < 2
        w = linspace(0, 2*pi, 1024);
    end
    if size(w, 1) > size(w, 2)
        w = w';
    end
    Xw = zeros(size(w));
    n = 0 : N-1;
    for i = 1 : length(w)
        Xw(i) = sum(x .* exp(-1j * w(i) * n'));
    end
end
```
------------------------------------------------------------\
Then with the function `dtft`, we can plot the figure with the following M-file:
------------------------------------------------------------\
```matlab
%% N = 10
clear; clc; close all;

% init x[n]
N = 10;
x = zeros(N, 1);
for n = 1:5
    x(n) = 2;
end
for n = 6:8
    x(n) = 3;
end

% calculate X_k
X_k = dft(x);
% calculate X_w
w = linspace(0, 2*pi, 1024);
X_w = dtft(x, w);
   

% plot figure
figure('Position', [100, 100, 600, 600]);

subplot(3, 1, 1);
stem(-2:-2+N-1, x, 'black', 'filled', 'LineWidth', 1);
title("Time Domain: $N = 10$", Interpreter="latex", FontSize=12);
xlabel('$n$', Interpreter='latex');
ylabel('$x[n]$', Interpreter='latex');
grid on;

subplot(3, 1, 2);
plot(w/pi, abs(X_w), 'r--', 'LineWidth', 1); hold on;
scatter((0:N-1)*2/N, abs(X_k), 'r', 'filled', 'LineWidth', 1);
title('Amplitude of $X_\omega$: $|X_\omega|$', Interpreter='latex', FontSize=12);
xlabel('$\omega$', Interpreter='latex');
ylabel('$|X_\omega|$', Interpreter='latex');
xticks([0, 0.5, 1, 1.5, 2]);
xticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});
legend('DTFT', 'DFT');
grid on;

subplot(3, 1, 3);
plot(w/pi, angle(X_w), 'b--', 'LineWidth', 1); hold on;
scatter((0:N-1)*2/N, angle(X_k), 'b', 'filled', 'LineWidth', 1);
title('Phase of $X_\omega$: $\angle X_\omega$', Interpreter='latex', FontSize=12);
xlabel('$\omega$', Interpreter='latex');
ylabel('$\angle X_\omega$', Interpreter='latex');
xticks([0, 0.5, 1, 1.5, 2]);
xticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});
legend('DTFT', 'DFT');
grid on;

% save
saveas(gcf, '09_3_10.png');
```
------------------------------------------------------------\
With above M-file, we can get the Figure:
#image("image/09_3_10.png", width: 100%)\

Likewise, just change the $N$ in above code from $10$ to $20$, we can get the figure of $N=20$:
#image("image/09_3_20.png", width: 100%)





#pagebreak()
#problem(4)[
  Given the sequence $x[n] = 3delta[n] + 5delta[n-2] + 4delta[n-4]$, its 8-point DFT can be calculated as $X_k$. If the 8-point DFT of $y[n](0 <= n <= 7)$ is $Y_k = W_8^(3k) dot X_k$ for $0 <= k <= 7$, find $y[n]$.
]
#SOLUTION

For $x[n]$ we know that:
$
  X_k = "DFT"{x[n]} = sum_(n = 0)^(7) x[n] dot e^(-j dot  (2 k pi)"/"8 dot n)
$
because:
$
  Y_k = W_8^(3k) dot X_k = e^(-j dot (2 k pi)"/"8 dot 3) dot X_k
$
So:
$
  y[n] = "IDFT"{Y_k} = "IDFT"{e^(-j dot (2 k pi)"/"8 dot 3) dot X_k} = tilde(x)[n-3] dot R_8[n]
$
That is:
$
  y[n] = 3delta[n-3] + 5delta[n-5] + 4 delta[n-7]
$






#pagebreak()
#problem(5)[
  Given a finite-length sequence $x[n]$ for $0 <= n <= N-1$, and let $X_k = "DFT"{x(n)}$ which is the N-point DFT, and
  $
    y[n] = cases(
      x[n]&", "0 <= n <= N-1,
      0&", "N <= n <= r N - 1
    )" ,  " Y_k = "DFT"{y[n]}", "0<=k<=r N -1
  $
  Please express $Y_k$ in terms of $X_k$.
]
#SOLUTION

We know $x[n]$ that:
$
  X_k = sum_(n = 0)^(N-1) x[n] dot e^(-j (2 k pi)"/"N dot n)
$
For $y[n]$, we can know:
$
  Y_k = "DFT"{y[n]} 
  &= sum_(n = 0)^(r N-1) y[n] dot e^(-j (2 k pi)"/"(r N) dot n) \
  &= sum_(n = 0)^(N-1) x[n] dot e^(-j (2 k pi)"/"(r N) dot n) \
$
Obviously,
$
  Y_(r k) = sum_(n = 0)^(N-1) x[n] dot e^(-j (2 k pi)"/"N dot n) = X_k
$
It means: we can get $X_k$ with sampling $Y_k$.

Inversely, if we want to express $Y_k$ in terms of $X_k$,   we should interpolate the signal $X_k$.