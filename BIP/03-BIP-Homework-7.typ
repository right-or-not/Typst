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
  1. Show the derination when the true signal $I = 0$. State tis final Probabillity Density Function (PDF), to prove Rician is similar to Rayleigh in the background.
  2. Derive the PDF when the local Signal-to-Noise Ratio (SNR) is high ($I >> sigma$) to prove that is approaches a normal distribution $N(I, sigma^2)$. (Hint: Make good use of approximations)
  3. Based on (1) and (2), if you wre to design an adaptive Alpha-Trimmed Mean filter, how would you set the balue of $d$ for the background area and the tissue area? Just provide a simple qualitative explanation.
  (In engineering practice, MRI reconstruction often employs non-local filtering. However, the objective of this question is to evaluate your fundamental understanding of the relationship between noise distributions and adaptive filtering strategies.)
]
#SOLUTION




#pagebreak()
#problem(2)[
  Constrained Least Squares Filtering:
  $
    hat(F)(u, v) = [(H^*(u, v))/(abs(H(u, v))^2 + gamma abs(P(u, v))^2)] G(u, v), p(x, y) = mat(0, -1, 0; -1, 4, -1; 0, -1, 0)
  $
  1. Prove that $P(u, v) = 4 - 2cos(s pi u"/"M) - 2 cos(2 pi v"/"N)$.
  2. Discuss $gamma = 0$, what does the CLS filter become? $gamma -> +infinity$, what happens to the restored image?
  3. Consider an image degraded by uniform linear motion. $ H(u, v) = (T)/(pi(u a + v b)) sin[pi(u a + v b)] e^(-j pi (u a + v b)) $ Assume there is slight additive noise $eta(x, y)$ in th emotion-blurred image. WHen we use CLS Filtering, explain why setting $gamma = 10^(-6)$ may be significantly better than $gamma = 0$. Just provide a simple qualitative explanation.
]
#SOLUTION






#pagebreak()
#problem(3)[
  Suppose an image's degradation function is the convolution of original image and $ h(x, y) = (x^2 + y^2 - 2 sigma^2)/sigma^4 e^(-(x^2 + y^2)"/"2sigma^2) $ and herre assume $x, y$ are continuous.
  1. Prove that the degradation in frequency filed is $ H(u, v) = -8pi^3 sigma^2 (u^2 + v^2) e^(-2pi^2 sigma^2(u^2 + v^2)) $
  2. Assume the power spectrum ratio of noise and undegraded image ($S_eta"/"S_f$) is the constant parameter $K$, give the transfer function expression of Wiener filter for this image.
]
#SOLUTION
