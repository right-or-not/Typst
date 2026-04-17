#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2"

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2026-04-15" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Image Processing" // 课程名称
#let proj-name = "Exercises for Image Restoration" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

// ==================== 正文内容 ==================== //
#problem(1)[
  Random noise in MR Images follows a Rician distribution in magnitude images:
  $
    p(M | I, sigma) = (M)/(sigma^2) exp(-(M^2 + I^2)/(2 sigma^2)) I_0((M I) / sigma^2)
  $
  where $I$ is the true underlying signal intensity, $M$ si the noisy measured magnitude, $sigma$ is the noise variance in the complex K-space domain, and $I_0$ is the 0-th order modified Bessel function. $I_0(0) = 1$. $I_0(z) approx e^z"/"sqrt(2 pi z)$, $z >> 1$.
  1. Show the derivation when the true signal $I = 0$. State its final Probabillity Density Function (PDF), to prove Rician is similar to Rayleigh in the background.
  2. Derive the PDF when the local Signal-to-Noise Ratio (SNR) is high ($I >> sigma$) to prove that is approaches a normal distribution $N(I, sigma^2)$. (Hint: Make good use of approximations)
  3. Based on (1) and (2), if you wre to design an adaptive Alpha-Trimmed Mean filter, how would you set the value of $d$ for the background area and the tissue area? Just provide a simple qualitative explanation.
  (In engineering practice, MRI reconstruction often employs non-local filtering. However, the objective of this question is to evaluate your fundamental understanding of the relationship between noise distributions and adaptive filtering strategies.)
]
#SOLUTION

1. When the true signal $I = 0$, the PDF simplifies to:
$
  p(M | I, sigma) 
  &= (M)/(sigma^2) exp(-(M^2 + I^2)/(2 sigma^2)) I_0((M I) / sigma^2) \ \
  &= (M)/(sigma^2) exp(-M^2/(2 sigma^2)) I_0(0) \ \
  &= (M)/(sigma^2) exp(-M^2/(2 sigma^2))
$
which is the PDF of a Rayleigh distribution.

So, in the background where $I = 0$, the Rician distribution reduces to a Rayleigh distribution. Or we can say that the Rician distribution is similar to the Rayleigh distribution in the background.

2. When the local Signal-to-Noise Ratio (SNR) is high ($I >> sigma$), we can use the approximation for the modified Bessel function:
$
  I_0(z) approx e^z"/"sqrt(2 pi z), z >> 1
$
In this case, we can approximate $p(M | I, sigma)$ as:
$
  p(M | I, sigma) 
  &approx (M)/(sigma^2) dot exp(-(M^2 + I^2)/(2 sigma^2)) dot exp(M I"/"sigma^2) / sqrt(2 pi M I"/"sigma^2) \ \
  &= (M)/(sigma^2) dot 1 / sqrt(2 pi M I"/"sigma^2) dot exp(-(M^2 + I^2 - 2 M I)/(2 sigma^2)) \ \
  &= 1 / (sqrt(2 pi) sigma) dot sqrt(M/I) dot exp(-(M - I)^2/(2 sigma^2)) \ \
  &approx 1 / (sqrt(2 pi) sigma) dot exp(-(M - I)^2/(2 sigma^2))
$
which is the PDF of a normal distribution $N(I, sigma^2)$.

So, when the local SNR is high, the Rician distribution approaches a normal distribution with mean $I$ and variance $sigma^2$.

3. Based on the above derivations, in the background area where the noise follows a *Rayleigh Distribution*, while in the tissue area where the signal is stronger and the noise follows a *Normal Distribution*. For different noise distributions, the optimal value of $d$ in the Alpha-Trimmed Mean filter would be different.
  - *Background area*: Since the noise follows a *Rayleigh distribution*, which has a heavier tail than a normal distribution, we would want to set a larger value of $d$ to effectively remove the outliers caused by the noise.
  - *Tissue area*: Since the noise follows a *Normal distribution*, which has a lighter tail, we can set a smaller value of $d$ (even set $d = 0$) to preserve more details in the tissue area while still reducing noise.
\
#v(-1em)
简而言之，选取 $d$ 是为了更好的去除噪声。对于瑞利噪声（背景区域），更可能由噪声产生极端值，因此用较大的 $d$ 先去除这些极端值，有利于之后的平均滤波处理；对于正态噪声（组织区域），极端值较少，可以用较小的 $d$ 来保留更多细节，以免删去了有效信息。



#pagebreak()
#problem(2)[
  Constrained Least Squares Filtering:
  $
    hat(F)(u, v) = [(H^*(u, v))/(abs(H(u, v))^2 + gamma abs(P(u, v))^2)] G(u, v), p(x, y) = mat(0, -1, 0; -1, 4, -1; 0, -1, 0)
  $
  1. Prove that $P(u, v) = 4 - 2cos(2 pi u"/"M) - 2 cos(2 pi v"/"N)$.
  2. Discuss $gamma = 0$, what does the CLS filter become? $gamma -> +infinity$, what happens to the restored image?
  3. Consider an image degraded by uniform linear motion. $ H(u, v) = (T)/(pi(u a + v b)) sin[pi(u a + v b)] e^(-j pi (u a + v b)) $ Assume there is slight additive noise $eta(x, y)$ in th emotion-blurred image. When we use CLS Filtering, explain why setting $gamma = 10^(-6)$ may be significantly better than $gamma = 0$. Just provide a simple qualitative explanation.
]
#SOLUTION

1. Obviously, $P(u, v)$ is the result of applying the Fourier Transform to $p(x, y)$, so just do it:
$
  P(u, v) = sum_(x=0)^(M-1) sum_(y=0)^(N-1) p(x, y) dot e^(-j 2 pi (u x"/"M + v y"/"N))
$
Select $(x, y) = (0, 0)$, $p(x, y) = 4$.\
Select $(x, y) = (1, 0) or (0, 1) or (-1, 0) or (0, -1)$, $p(x, y) = -1$.

$
  P(u, v) 
  &= 4 dot e^0 + (-1) dot [e^(-j 2 pi u"/"M) + e^(-j 2 pi v"/"N) + e^(j 2 pi u"/"M) + e^(j 2 pi v"/"N)] \ \
  &= 4 - 2cos((2 pi u)/M) - 2cos((2 pi v)/N)
$

2. When $gamma = 0$, 
$
  hat(F)(u, v) = (H^*(u, v))/(abs(H(u, v))^2) dot G(u, v) = (G(u, v))/(H(u, v))
$
which is Inverse filter. So when $gamma = 0$, the CLS filter will become Inverse filter.

When $gamma -> +infinity$,
$
  hat(F)(u, v) -> (H^*(u, v) dot G(u, v))/(gamma abs(P(u, v))^2) = 1/gamma dot (abs(H(u, v))^2)/(abs(P(u, v))^2) dot (G(u, v))/(H(u, v)) -> 0
$
which means the restored image maybe is very blurry or just a block of color.

简单来说，参数 $gamma$ 就是调控滤波结果足够准确还是足够平滑。选取 $gamma = 0$，会导致结果过于准确，也就是把高频细节都充分滤波，导致高频细节强度太高；选取 $gamma -> +infinity$ 会导致过于平滑，甚至会让整个图像平滑成类似一个方块的情况。

3. When we set $gamma = 0$, the CLS filter will become an Inverse filter. For Inverse filter, a sight additive noise $eta(x, y)$ is terrible, because 
$
  hat(F)(u, v) = (G(u, v))/(H(u, v)) = (H(u, v) dot F(u, v) + N(u, v))/(H(u, v)) = F(u, v) + (N(u, v))/(H(u, v))
$
for the point on the edge of $H(u, v)$, $H(u, v) -> 0$, and $hat(F)(u, v) -> +infinity$, which means high-frequency signal's intensity is realy high, and the image suffers from high-frequency noise and is completely illegible.

While we set $gamma = 10^(-6)$, in
$
  hat(F)(u, v) = [(H^*(u, v))/(abs(H(u, v))^2 + gamma abs(P(u, v))^2)] G(u, v)
$
$gamma abs(P(u, v))^2$ will reduce the amplification of high-frequency signals, which keep the relative intensity of low-frequency signals.

Now substitute $H(u, v)$:
$
  H(u, v) 
  &= (T)/(pi(u a + v b)) sin[pi(u a + v b)] e^(-j pi (u a + v b)) \ \
  &= T sinc(u a + v b) e^(-j pi (u a + v b))
$
then, let $gamma = 0$
$
  hat(F)(u, v) = F(u, v) + (N(u, v))/(T sinc(u a + v b) e^(-j pi (u a + v b)))
$
when $u a + v b = n in ZZ$, $H(u, v) = 0$, and $hat(F)(u, v) -> +infinity$, the image will be all high-frequency noise.

let $gamma -> 10^(-6)$,
$
  hat(F)(u, v) 
  &= [(T sinc(u a + v b) e^(j pi (u a + v b)))/(abs(T sinc(u a + v b) e^(-j pi (u a + v b)))^2 + gamma abs(P(u, v))^2)] G(u, v) \ \
  &= [(T sinc(u a + v b) e^(j pi (u a + v b)))/(abs(T sinc(u a + v b))^2 + gamma abs(P(u, v))^2)] G(u, v)
$
when $sinc(u a + v b) -> 0$, 
$
  hat(F)(u, v)  -> [0/(0 + 10^(-6)abs(P(u, v))^2)] dot G(u, v) -> 0
$
will not to $+infinity$.

所以 $gamma = 10^(-6)$ 避免了取 $gamma = 0$ 时会出现的噪声爆炸，能够在高频区域也将噪声抑制得很好。






#pagebreak()
#problem(3)[
  Suppose an image's degradation function is the convolution of original image and $ h(x, y) = (x^2 + y^2 - 2 sigma^2)/sigma^4 e^(-(x^2 + y^2)"/"2sigma^2) $ and here assume $x, y$ are continuous.
  1. Prove that the degradation in frequency filed is $ H(u, v) = -8pi^3 sigma^2 (u^2 + v^2) e^(-2pi^2 sigma^2(u^2 + v^2)) $
  2. Assume the power spectrum ratio of noise and undegraded image ($S_eta"/"S_f$) is the constant parameter $K$, give the transfer function expression of Wiener filter for this image.
]
#SOLUTION

1. Simplify $h(x, y)$ first:
$
  h(x, y) 
  &= (x^2 + y^2 - 2 sigma^2)/sigma^4 e^(-(x^2 + y^2)"/"2sigma^2) \ \ 
  &= ((x^2)/(sigma^4) - 1/(sigma^2)) e^(-(x^2 + y^2)"/"2sigma^2) + ((y^2)/(sigma^4) - 1/(sigma^2)) e^(-(x^2 + y^2)"/"2sigma^2) \ \
  &= (partial^2/(partial x^2) + partial^2/(partial y^2)) e^(-(x^2 + y^2)"/"2sigma^2)
$
so,
$
  H(u, v) 
  &= cal(F){h(x, y)} \ \
  &= cal(F){partial^2/(partial x^2) dot e^(-(x^2 + y^2)"/"2sigma^2)} + cal(F){partial^2/(partial x^2) dot e^(-(x^2 + y^2)"/"2sigma^2)} \ \
  &= (j 2 pi u)^2 dot cal(F){e^(-(x^2 + y^2)"/"2sigma^2)} + (j 2 pi v)^2 dot cal(F){e^(-(x^2 + y^2)"/"2sigma^2)}
$
Now we should calculate $cal(F){e^(-(x^2 + y^2)"/"2sigma^2)}$
$
  cal(F){e^(-(x^2 + y^2)"/"2sigma^2)} 
  &= integral_(-infinity)^(+infinity)integral_(-infinity)^(+infinity) e^(-(x^2 + y^2)"/"2sigma^2) dot e^(-j (2 pi)(u x + v y)) "d"x"d"y \ \
  &= integral_(-infinity)^(+infinity) e^(-x^2"/"2sigma^2) dot e^(-j (2 pi)u x) "d"x + integral_(-infinity)^(+infinity) e^(-y^2"/"2sigma^2) dot e^(-j (2 pi)v y) "d"y \ \
  &= cal(F){e^(-x^2"/"2sigma^2)} dot cal(F){e^(-y^2"/"2sigma^2)} 
$
So we should calculate $cal(F){e^(-x^2"/"2sigma^2)}$ first:
$
  cal(F){e^(-x^2"/"2sigma^2)} 
  &= integral_(-infinity)^(+infinity) e^(-x^2"/"2sigma^2) dot e^(-j (2 pi)u x) "d"x \ \
  &= integral_(-infinity)^(+infinity) exp(-(x^2 + j 4 pi sigma^2 u x)/(2 sigma^2)) "d"x \ \
  &= exp(-2 pi^2 sigma^2 u^2) dot integral_(-infinity)^(+infinity)exp(-((x + j 2 pi sigma^2 u)^2)/(2 sigma^2)) "d"x \ \
  &= exp(-2 pi^2 sigma^2 u^2) dot integral_(-infinity)^(+infinity)exp(-(x^2)/(2 sigma^2)) "d"x \ \
  &= sqrt(2 pi sigma^2) dot e^(-2 pi^2 sigma^2 u^2)
$
Substitute back into the original equation:
$
  cal(F){e^(-(x^2 + y^2)"/"2sigma^2)}
  &= cal(F){e^(-x^2"/"2sigma^2)} dot cal(F){e^(-y^2"/"2sigma^2)}  \ \
  &= sqrt(2 pi sigma^2) dot e^(-2 pi^2 sigma^2 u^2) dot sqrt(2 pi sigma^2) dot e^(-2 pi^2 sigma^2 v^2) \ \
  &= 2 pi sigma^2 dot e^(2pi^2 sigma^2 (u^2 + v^2))
$
So,
$
  H(u, v) 
  &= [(j 2 pi u)^2 + (j 2pi v)^2] dot cal(F){e^(-(x^2 + y^2)"/"2sigma^2)} \ \
  &= -4pi^2(u^2 + v^2) dot 2 pi sigma^2 dot e^(2pi^2 sigma^2 (u^2 + v^2)) \ \
  &= -8pi^3 sigma^2 (u^2 + v^2) e^(-2pi^2 sigma^2(u^2 + v^2))
$

2. For Wiener filter,
$
  W^* = (F^2 H)/(F^2 H^2 + N^2)
$
so,
$
  W &= (H^*)/(H^2 + N^2"/"F^2) \
  &= 1/H dot H^2/(H^2 + S_eta"/"S_f) = 1/H dot H^2/(H^2 + K)
$
Let $H(u, v) = -8pi^3 sigma^2 (u^2 + v^2) e^(-2pi^2 sigma^2(u^2 + v^2))$, we will get:
$
  W = (-8pi^3 sigma^2 (u^2 + v^2) e^(-2pi^2 sigma^2(u^2 + v^2)))/([-8pi^3 sigma^2 (u^2 + v^2) e^(-2pi^2 sigma^2(u^2 + v^2))]^2 + K)
$