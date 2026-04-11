#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2" as cetz
#import "@local/cetz-plot:0.1.3": plot

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-10-30" // 日期，格式为 YYYY-MM-DD
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
  The Fourier transform of $x(t)$ is given as:
  $
    |X(omega)| = 2{u(omega + 1) - u(omega - 5)} \
    angle X(omega) = - 3/2 omega + pi
  $
  Determine the value of $t$ when $x(t) = 0$.
]

#SOLUTION

According to the information given, it's easy to get:
$
  X(omega) = 2 dot e^(j\( - 3/2 omega + pi \)) dot {u(omega + 1) - u(omega - 5)}
$
Let's do the inverse Fourier transform to find $x(t)$:
$
  x(t) &= 1/(2pi) dot integral_(-infinity)^(+infinity) X(omega) dot e^(j omega t) " d"omega \
  &= 1/(2pi) dot integral_(-1)^(5) 2 dot e^(j\( - 3/2 omega + pi \)) dot e^(j omega t) " d"omega \
  &= (-1)/(pi) dot integral_(-1)^(5) e^(j omega \( t - 3/2 \)) " d"omega \
  &= (-1)/(pi) dot integral_(-1)^(5) e^(j omega alpha) " d"omega \
$
where $alpha = t - 3/2$,
$
  x(t) &= (-1)/(j alpha pi) dot integral_(-1)^(5) e^(j omega alpha) " d"(j alpha omega) \
  &= (-1)/(j alpha pi) dot [e^(j alpha dot (5)) - e^(j alpha dot (-1))] \
  &= (-1 dot e^(j alpha dot (2)))/(j alpha pi) dot [e^(j alpha dot (3)) - e^(j alpha dot (-3))] \
  &= (-2 dot e^(j alpha dot (2)))/(alpha pi) dot (e^(j alpha dot (3)) - e^(j alpha dot (-3)))/(2j) \
  &= (-2 dot e^(j alpha dot (2)))/(alpha pi) dot sin(3alpha) \
$
Let $x(t) = 0$, which means $sin(3alpha) = 0$ and $alpha pi eq.not 0$. So the answer is $3alpha = k pi$, where $k eq.not 0$.

Recall $alpha = t - 3/2$, so the answer is 
$
  t = (k pi) /3 + 3/2, k eq.not 0.
$





#pagebreak()
#problem(2)[
    By first expressing $x(t)$ in terms of rectangeular pulse functions and triangular pulse functions, compute the Fourier transform of the signals in Figure P3.19.  Plot the magnitude and phase of the Fourier transform.

    #grid(
        columns: (1fr, 1fr),
        column-gutter: 15pt,
        [
            #image("image/05_2(b).png", width: 90%, height: 200pt)
        ],
        [
            #image("image/05_2(d).png", width: 90%, height: 200pt)
        ]
    )
]

#SOLUTION

*(b)* Obviously, 
$
  x(t) = p_(3)(t - 1/2) + p_(2)(t) = p_(3)(t) * delta(t - 1/2) + p_(2)(t)
$
According to the Fourier transform for $p_tau (t)$:
$
  cal(F){p_3 (t)} = 3 dot sinc(3 / 2 dot omega) \
  cal(F){p_2 (t)} = 2 dot sinc(omega) \
$
So:
$
  cal(F){x(t)} 
  &= cal(F) {p_(3)(t) * delta(t - 1/2) + p_(2)(t)} \
  &= cal(F) {p_(3)(t)} dot cal(F) {delta(t - 1/2)} +  cal(F) {p_(2)(t)} \
  &= 3 dot sinc(3/2 dot omega) dot e^(j omega (-1/2)) +  2 dot sinc(omega) \
$\

Then, before we plot the magnitude and phase of the Fourier transform, let us simplify the equation:
$
  cal(F) {x(t)} = 3 dot sinc(3/2 dot omega) dot e^(j omega (-1/2)) +  2 dot sinc(omega) 
$
Use the Eular's formula:
$
  cal(F) {x(t)}  = 3 dot sinc(3/2 dot omega) dot [cos(-1/2 omega) + j dot sin(-1/2 omega)] +  2 dot sinc(omega)
$
Separate the real and imaginary parts:
$
  cal(F) {x(t)} = 2/omega dot [sin(3/2 omega) dot cos(-1/2 omega)] + 2/omega dot sin(omega) + j dot [2/omega dot sin(3/2 omega) dot sin(-1/2 omega)]
$
Use the Sum difference product:
$
  cal(F) {x(t)} = (3sin(omega) + sin(2 omega))/omega + j dot (cos(2omega) - cos(omega))/omega
$
Now, it is easy to get:
$
  |X(omega)| = sqrt([(3sin(omega) + sin(2 omega))/omega]^2 + [(cos(2omega) - cos(omega))/omega]^2) \
  angle X(omega) = arctan((cos(2omega) - cos(omega))/(3sin(omega) + sin(2 omega)))
$
Then, let us plot the magnitude and phase of the Fourier transform. Following is the MATLAB code:\
------------------------------------------------------------
```MATLAB
% 傅里叶变换幅度和相位谱可视化
clear; clc; close all;

%% 参数设置
omega = linspace(-20, 20, 5000);  % 频率范围，避开 omega=0
omega(omega == 0) = [];  % 移除 omega=0 避免除以零

%% 计算幅度谱 |X(omega)|
% |X(omega)| = sqrt([(3sin(omega) + sin(2omega))/omega]^2 + [(cos(2omega) - cos(omega))/omega]^2)
numerator_real = 3*sin(omega) + sin(2*omega);
numerator_imag = cos(2*omega) - cos(omega);

magnitude = sqrt((numerator_real./omega).^2 + (numerator_imag./omega).^2);

%% 计算相位谱 angle X(omega)
% angle X(omega) = arctan((cos(2omega) - cos(omega))/(3sin(omega) + sin(2omega)))
phase = atan2(numerator_imag, numerator_real);  % 使用 atan2 处理四象限相位

%% 创建图形
figure('Position', [100, 100, 1200, 500]);

%% 左图：幅度谱
subplot(1,2,1);
plot(omega, magnitude, 'b', 'LineWidth', 2);
xlabel('$\omega$ (rad/s)', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$|X(\omega)|$', 'Interpreter', 'latex', 'FontSize', 14);
title('$|X(\omega)|$', 'Interpreter', 'latex', 'FontSize', 16);
grid on;
xlim([-20, 20]);

% 添加坐标轴
hold on;
plot([-20, 20], [0, 0], 'k-', 'LineWidth', 0.5);
plot([0, 0], [0, max(magnitude)*1.1], 'k-', 'LineWidth', 0.5);
hold off;

% 设置美观的图形属性
set(gca, 'FontSize', 12, 'TickLabelInterpreter', 'latex');
box on;

%% 右图：相位谱
subplot(1,2,2);
plot(omega, phase, 'r', 'LineWidth', 2);
xlabel('$\omega$ (rad/s)', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\angle X(\omega)$ (rad)', 'Interpreter', 'latex', 'FontSize', 14);
title('$\angle X(\omega)$', 'Interpreter', 'latex', 'FontSize', 16);
grid on;
xlim([-20, 20]);
ylim([-pi, pi]);

% 添加坐标轴和相位边界
hold on;
plot([-20, 20], [0, 0], 'k-', 'LineWidth', 0.5);
plot([0, 0], [-pi, pi], 'k-', 'LineWidth', 0.5);
plot([-20, 20], [pi, pi], 'k--', 'LineWidth', 0.5, 'Color', [0.5, 0.5, 0.5]);
plot([-20, 20], [-pi, -pi], 'k--', 'LineWidth', 0.5, 'Color', [0.5, 0.5, 0.5]);
hold off;

% 设置 y 轴刻度
yticks([-pi, -pi/2, 0, pi/2, pi]);
yticklabels({'$-\pi$', '$-\pi/2$', '$0$', '$\pi/2$', '$\pi$'});

% 设置美观的图形属性
set(gca, 'FontSize', 12, 'TickLabelInterpreter', 'latex');
box on;

%% 添加总标题
sgtitle('$|X(\omega)|$ and $\angle X(\omega)$', ...
        'Interpreter', 'latex', 'FontSize', 18, 'FontWeight', 'bold');


%% 显示关键特征
fprintf('=== 傅里叶变换特征分析 ===\n');
fprintf('幅度最大值: %.4f\n', max(magnitude));
fprintf('相位范围: [%.4f, %.4f] rad\n', min(phase), max(phase));

% 找到幅度谱的零点
zero_crossings = find(diff(sign(magnitude(omega>0))) ~= 0);
if ~isempty(zero_crossings)
    fprintf('幅度谱在 ω ≈ %.2f rad/s 附近有零点\n', omega(zero_crossings(1) + find(omega>0,1)-1));
end

saveas(gcf, "05_2_b.png");
```
------------------------------------------------------------\
Then get the figure below:
#image("image/05_2_b_ans.png", width: 90%, height: 200pt)

#pagebreak()



*(d)* As we all know:
$
  p_tau (t) * p_tau (t) = cases(
    t + tau"     " & ", " t in (-tau, 0),
    -t + tau  & ", " t in (0, tau),
    0 & ", " "others"
  )
$
Let define the result as $q_tau (t)$, then the $x(t)$ in (d) could be:
$
  x(t) = 2 p_4 (t) + q_1(t) - q_2(t)
$
Then we should compute the Fourier transform of $q_tau (t)$:
$
  cal(F) {q_tau (t)} 
  &= cal(F) {p_tau (t) * p_tau (t)} \
  &= cal(F) {p_tau (t)} dot cal(F) {p_tau (t)} \
  &= tau dot sinc((tau omega) / 2) dot tau dot sinc((tau omega) / 2) \
  &= tau^2 dot sinc^2((tau omega)/2)
$
So:
$
  cal(F) {x(t)} 
  &= cal(F) {2 p_4 (t) + q_1(t) - q_2(t)} \
  &= 2 dot cal(F) {p_4(t)} + cal(F) {q_1(t)} - cal(F) {q_2 (t)} \
  &= 8 dot sinc(2 omega) + sinc^2(omega/2) - 4dot sinc^2(omega)
$

Then, let us plot the magnitude and phase of the Fourier transform. Following is the MATLAB code:\
------------------------------------------------------------\
```MATLAB
% 傅里叶变换可视化: X(ω) = 8·sinc(2ω) + sinc²(ω/2) - 4·sinc²(ω)
clear; clc; close all;

%% 参数设置
omega = linspace(-15, 15, 5000);  % 频率范围

%% 总表达式
term1 = 8 * sinc(2*omega/pi);  % sinc(2ω/π) = sin(2ω)/(2ω)
term2 = (sinc(omega/(2*pi))).^2;
term3 = 4 * (sinc(omega/pi)).^2;
X_omega = term1 + term2 - term3;

%% 计算幅度和相位
magnitude = abs(X_omega);      % 幅度谱
phase = angle(X_omega);        % 相位谱

%% 创建图形
figure('Position', [100, 100, 1200, 500]);

%% 左图：幅度谱
subplot(1,2,1);
plot(omega, magnitude, 'b-', 'LineWidth', 2);
xlabel('$\omega$ (rad/s)', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$|X(\omega)|$', 'Interpreter', 'latex', 'FontSize', 14);
title('$|\mathcal{F}\{x(t)\}|$', ...
      'Interpreter', 'latex', 'FontSize', 12);
grid on;
xlim([-8, 8]);

% 添加坐标轴
hold on;
plot([-8, 8], [0, 0], 'k-', 'LineWidth', 0.5);
plot([0, 0], [0, max(magnitude)*1.1], 'k-', 'LineWidth', 0.5);
hold off;

% 设置美观的图形属性
set(gca, 'FontSize', 12, 'TickLabelInterpreter', 'latex');
box on;

%% 右图：相位谱
subplot(1,2,2);
plot(omega, phase, 'r-', 'LineWidth', 2);
xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\angle X(\omega)$', 'Interpreter', 'latex', 'FontSize', 14);
title('$\angle\mathcal{F}\{x(t)\}$', ...
      'Interpreter', 'latex', 'FontSize', 12);
grid on;
xlim([-8, 8]);
ylim([0-1, pi+1]);

% 添加坐标轴和相位边界
hold on;
plot([-8, 8], [0, 0], 'k-', 'LineWidth', 0.5);
plot([0, 0], [-pi, pi], 'k-', 'LineWidth', 0.5);
plot([-8, 8], [pi, pi], 'k--', 'LineWidth', 0.5, 'Color', [0.5, 0.5, 0.5]);
plot([-8, 8], [-pi, -pi], 'k--', 'LineWidth', 0.5, 'Color', [0.5, 0.5, 0.5]);
hold off;

% 设置 y 轴刻度
yticks([-pi, -pi/2, 0, pi/2, pi]);
yticklabels({'$-\pi$', '$-\pi/2$', '$0$', '$\pi/2$', '$\pi$'});

% 设置美观的图形属性
set(gca, 'FontSize', 12, 'TickLabelInterpreter', 'latex');
box on;

%% 显示关键特征值
fprintf('=== 傅里叶变换特征分析 ===\n');
fprintf('DC分量 (ω=0): X(0) = %.4f\n', X_omega(omega==0));
fprintf('幅度最大值: %.4f\n', max(magnitude));
fprintf('幅度在 ω=0 的值: %.4f\n', magnitude(omega==0));

% 找到幅度谱的主要特征
[peaks, locs] = findpeaks(magnitude(omega>=0), 'SortStr', 'descend');
if length(peaks) >= 2
    fprintf('主瓣峰值: %.4f at ω = %.2f rad/s\n', peaks(1), omega(locs(1) + find(omega>=0,1)-1));
    if length(peaks) >= 2
        fprintf('次瓣峰值: %.4f at ω = %.2f rad/s\n', peaks(2), omega(locs(2) + find(omega>=0,1)-1));
    end
end

%% 验证数学公式
% 在 ω=0 处的极限值
% term1(0) = 8, term2(0) = 1, term3(0) = 4
% X(0) = 8 + 1 - 4 = 5
fprintf('\n=== 数学验证 ===\n');
fprintf('在 ω=0 处:\n');
fprintf('  8·sinc(2ω) → 8\n');
fprintf('  sinc²(ω/2) → 1\n');
fprintf('  4·sinc²(ω) → 4\n');
fprintf('  X(0) = 8 + 1 - 4 = 5\n');
fprintf('计算值 X(0) = %.6f\n', X_omega(omega==0));

saveas(gcf, "05_2_d.png");
```
------------------------------------------------------------\
Then get the figure below:
#image("image/05_2_d_ans.png", width: 90%, height: 200pt)



#pagebreak()
#problem(3)[
    A continuous-time signal $x(t)$ has Fourier transform
    $
      X(omega) = 1 / (j omega + b)
    $
    where $b$ is a constant. Determine the Fourier transform $V(omega)$ of the following signals:\
    *(a)* $v(t) = x(5t - 4)$\
    *(c)* $v(t) = x(t) dot e^(j dot 2t)$\
    *(d)* $v(t) = x(t) dot cos(4t)$\
    *(f)* $v(t) = x(t) * x(t)$\
    *(g)* $v(t) = x^2(t)$\
    *(h)* $v(t) = 1 "/" (j t - b)$
]

#SOLUTION

*(a)* Obviously,
$
  V(omega) 
  &= cal(F){v(t)} = cal(F){x(5t - 4)} \
  &= cal(F){x(5t) * delta(t - 4/5)} \
  &= cal(F){x(5t)} dot cal(F) {delta(t - 4/5)} \
  &= 1/5 dot 1/(j omega"/"5 +b) dot 1 dot e^(-j omega 4/5) \
  &= 1/(j omega + 5b) dot e^(-j omega 4/5) \
$\

*(c)* Obviously,
$
  V(omega) 
  &= cal(F){v(t)} = cal(F){x(t) dot e^(j dot 2t)} \
  &= X(omega - 2) \
  &= 1 / (j (omega-2) + b) \
$\

*(d)* Obviously,
$
  V(omega) 
  &= cal(F){v(t)} = cal(F){x(t) dot cos(4t)} \
  &= 1/(2pi) dot cal(F){v(t)} * cal(F) {cos(4t)}  \
  &= 1/(2pi) dot cal(F){v(t)} * cal(F) {cos(4t)}  \
  &= 1/(2pi) dot cal(F){v(t)} * [1/2 cal(F){e^(j(4t))} + 1/2 cal(F) {e^(-j(4t))}]  \
  &= 1/(2pi) dot 1/(j omega + b) * [pi dot delta(omega - 4) + pi dot delta(w + 4)]  \
  &= 1/(2) dot [1/(j (omega-4) + b) + 1/(j (omega+4) + b)] \
$\

*(f)* Obviously,
$
  V(omega) 
  &= cal(F){v(t)} = cal(F){x(t) * x(t)} \
  &= cal(F){x(t)} dot cal(F){x(t)} \
  &= (1/(j omega + b))^2 \
$\

*(g)* Obviously,
$
  V(omega) 
  &= cal(F){v(t)} = cal(F){x^2(t)} \
  &= 1 / (2pi) dot cal(F){x(t)} * cal(F){x(t)} \
  &= 1 / (2pi) dot 1/(j omega + b) * 1/(j omega + b)\
  &= 1 / (2pi) dot integral_(-infinity)^(+infinity) 1/(j v + b) dot 1/(j (omega-v) + b) " d"v \
  &= 1 / (2pi) dot (2 pi j) dot "RES"(f(v); j b) \
  &= 1 / (2pi) dot (2 pi j) dot (omega - 2 j b)/((j omega + 2b)^2) \
  &= 1 / (j omega + 2b) \
$\

*(h)* Obviously,
$
  v(omega) = 1/(j omega - b) = cal(F){x(t)}
$
So, 
$
  x(t) = cal(F)^(-1){v(omega)} = e^(b t) dot u(t)
$
Then, it is easy to get:
$
  V(omega) = cal(F){v(t)} = 2pi dot x(-omega) = 2pi dot e^(-b omega) dot u(-omega)
$
So the answer is:
$
  V(omega) = -2pi dot e^(-b omega) dot u(omega)
$






#pagebreak()
#problem(4)[
    Ginven the following relationships:
    $
      cases(
        y(t) = x(t) * h(t) ,
        g(t) = x(3t) * h(3t)
      )
    $
    and given that the Fourier transform of $x(t)$ is $X(omega)$ and the Fourier transform of $h(t)$ is $H(omega)$, use the properties of the Fourier transform to prove that $g(t) = A dot y(B t)$, and determine the values of $A$ and $B$.
]

#SOLUTION

What we know is:
$
  cases(
        y(t) = x(t) * h(t) ,
        g(t) = x(3t) * h(3t),
        cal(F){x(t)} = X(omega),
        cal(F){h(t)} = H(omega)
      )
$
According to the properties of Fourier transform, we can get:
$
  cal(F){y(t)}
  &= cal(F){x(t) * h(t)} \
  &= cal(F){x(t)} dot cal(F){h(t)} \
  &= X(omega) dot H(omega) \
$
Likewise,
$
  cal(F){g(t)}
  &= cal(F){x(3t) * h(3t)} \
  &= cal(F){x(3t)} dot cal(F){h(3t)} \
  &= 1/3 dot X(omega/3) dot 1/3 dot H(omega/3) \
  &= 1/9 dot X(omega/3) dot H(omega/3)
$
And:
$
  cal(F){A y(B t)}
  &= A dot cal(F){y(B t)} \
  &= A dot 1/B dot X(omega/B) dot H(omega/B) \
$
So, it is to get:
$
  cases(
    A = 1"/"3,
    B = 3
  )
$






#pagebreak()
#problem(5)[
    For the Fourier transform $X(omega)$ given in Figure P3.26, what characteristic does $x(t)$ have(i.e., real-valued, complex-valued, even, odd)?|Calculate $x(0)$.
    #image("image/05_5(a).jpg", width: 70%)
    #image("image/05_5(c).png", width: 50%)
]

#SOLUTION

*(a)* According to the relationship between $x(t)$ and $X(omega)$, and $X(omega)$ is a real-valued odd function. So $x(t)$ should be a complex-valued odd function.

We could compute the $x(t)$ like this:
$
  X(omega) 
  &= -u(omega+2) + u(omega+1) + u(omega-1) - u(omega-2) \
  &= u(omega) * [ -delta(omega+2) + delta(omega+1) + delta(omega-1) - delta(omega-2)] \
$
So,
$
  2pi dot x(-omega)
  &= cal(F){X(t)} \
  & = cal(F){u(t) * [ -delta(t+2) + delta(t+1) + delta(t-1) - delta(t-2)]} \
  & = cal(F){u(t)} dot cal(F) {[ -delta(t+2) + delta(t+1) + delta(t-1) - delta(t-2)]} \
  & = (pi dot delta(omega) + 1/(j omega)) dot 2 dot [cos(omega) - cos(2omega)] \
$
Then we get:
$
  x(t) 
  &= 1 /(2pi) dot (pi dot delta(-t) + 1/(j (-t))) dot 2 dot [cos(-t) - cos(-2t)] \
  &= (delta(t) - 1/(j pi t)) dot [cos(t) - cos(2t)] \
  &=  j/(pi t) dot [cos(t) - cos(2t)] \
$
So $x(t)$ is complex-valued odd function, let $t = 0$,
$
  x(0) = j/(pi t) dot [cos(t) - cos(2t)] = 0
$\

*(c)* According to the figure (c), we could get:
$
  X(omega) = cases(
    -2j"     " & ", " -2 < omega < 0,
    2j"     " & ", " 0 < omega < 2,
    0"     " & ", " "others",
  )
$\

Obviously, $X(omega)$ is a complex-valued odd function, so $x(t)$ should be real-valued odd function.

Like the process above, we could compute the $x(t)$:
$
  x(t) = -(4 sin^2(t))/(pi t)
$
So $x(t)$ is a real-valued odd function, let $t = 0$:
$
  x(0) = lim_(t -> 0) - (8sin t cos t)/(pi) = 0
$