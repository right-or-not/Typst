#import "@local/zju-typst-tplt:0.2.0": *
#import "@local/cetz:0.4.2"

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2026-04-28" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Image Processing" // 课程名称
#let proj-name = "Exercises for Image Segmentation" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

// ==================== 正文内容 ==================== //
#problem(1)[
  A grayscale image has the following histogram:
  #image("image/09-01.png", width: 80%)
  Use Otsu's method to compute the optimal threshold that maximizes the between-class variance.
]
#SOLUTION

// data
#let i = (0, 1, 2, 3, 4, 5, 6, 7);
#let n_i = (40, 20, 50, 30, 10, 30, 10, 10);
#let n_all = n_i.sum();
#let length = i.len();
#let p_i = n_i.map(i => i / n_all);

// methods
#let decimal(num, n: 2) = {
  let factor = calc.pow(10, n)
  return calc.round(num * factor) / factor;
}
#let mean(i, p: none) = {
  if p == none {
    return i.sum() / i.len();
  } else {
    return i.zip(p).map(((x, y)) => x * y).sum() / p.sum();
  }
}
#let between_class_variance(i, p: none, k: 0) = {
  if p == none {
    return;
  } else {
    let p_1 = p.slice(0, k + 1).sum();
    let p_2 = p.slice(k + 1).sum();
    let m_1 = mean(i.slice(0, k + 1), p: p.slice(0, k + 1));
    let m_2 = mean(i.slice(k + 1), p: p.slice(k + 1));
    let m = p_1 * m_1 + p_2 * m_2;
    return p_1 * (m_1 - m) * (m_1 - m) + p_2 * (m_2 - m) * (m_2 - m);
  }
}

先列出直方图对应的每个灰度值的像素数量 $n_i$ 和概率 $p_i$：
#table(
  columns: (1fr, ) * (length + 1),
  [$i$], ..i.map(index => [#index]),
  [$n_i$], ..n_i.map(value => [#value]),
  [$p_i$], ..p_i.map(value => [#value]),
  table.hline()
)

由于我们希望用 Otsu's method 得到最大的类间方差，因此只需要计算每个 $k$ 对应的类间方差，就能够找到最优解。选取特定的 $k$，将其分为两类（1 和 2），分别计算：
$ p_1 = sum_(i = 0)^(i = k)p_i $
$ p_2 = sum_(i = k + 1)^(i = L - 1)p_i $
$ m_1 = sum_(i = 0)^(i = k)i dot p_i / p_1 $
$ m_2 = sum_(i = k + 1)^(i = L - 1)i dot p_i / p_2 $
有次可以算出全体数据的平均值 $ m = p_1 dot m_1 + p_2 dot m_2 $，最后计算类间方差：$ sigma_b^2 = p_1 dot (m_1 - m)^2 + p_2 dot (m_2 - m)^2 $ 由此遍历所有可能的 $k(0 ~ L - 1)$，如下表所示：
#let k = i.slice(0, i.len()-1);
#let beween_class_variances = k.map(k => between_class_variance(i, p: p_i, k: k));
#table(
  columns: (1fr, ) * (k.len() + 1),
  [$k$], ..k.map(value => [#value]),
  [$sigma_b^2$], ..beween_class_variances.map(value => [#decimal(value)]),
  table.hline()
)
即可得到最大的类间方差为 $sigma_b^2 = 3.09$，对应的 $k$ 为 3，也就是最优的全局阈值为 3。







#pagebreak()
#problem(2)[
  #image("image/09-02.png", width: 60%)
  - Divide the image into four non-overlapping '8 $times$ 8' sub-images, and analyze the local threshold for each sub-image.
  - Write down the complete '$16 times 16$' binary segmentation result, and determine whether a single global threshold can produce the same result.
]
#SOLUTION

// data
#let i_0 = (0, 0.5, 2.0, 2.5);
#let n_0 = (24, 25, 8, 7);
#let p_0 = n_0.map(value => value / n_0.sum());
#let i_1 = (1.0, 1.5, 3.0, 3.5);
#let n_1 = (21, 20, 11, 12);
#let p_1 = n_1.map(value => value / n_1.sum());
#let i_2 = (2.0, 2.5, 4.0, 4.5);
#let n_2 = (21, 20, 11, 12);
#let p_2 = n_2.map(value => value / n_2.sum());
#let i_3 = (3.0, 3.5, 5.0, 5.5);
#let n_3 = (24, 25, 8, 7);
#let p_3 = n_3.map(value => value / n_3.sum());

#let k = range(0, i_0.len()-1);
#let beween_class_variances_0 = k.map(k => between_class_variance(i_0, p: p_0, k: k));
#let beween_class_variances_1 = k.map(k => between_class_variance(i_1, p: p_1, k: k));
#let beween_class_variances_2 = k.map(k => between_class_variance(i_2, p: p_2, k: k));
#let beween_class_variances_3 = k.map(k => between_class_variance(i_3, p: p_3, k: k));

// methods
#let i_all = (i_0, i_1, i_2, i_3);
#let p_all = (p_0, p_1, p_2, p_3);
#let merge_pairs(i_arr, p_arr) = {
  let dict = (:);
  for (i_list, p_list) in i_arr.zip(p_arr) {
    for (i, p) in i_list.zip(p_list) {
      let key = str(i);
      if dict.keys().contains(key) {
        dict.insert(key, dict.at(key) + p)
      } else {
        dict.insert(key, p)
      }
    }
  }
  let keys = dict.keys().sorted();
  let merged_i = keys.map(key => float(key));
  let merged_p = keys.map(key => dict.at(key)/4);
  return (merged_i, merged_p);
}
#let (i_merged, p_merged) = merge_pairs(i_all, p_all);
#let k_merged = range(0, i_merged.len()-1);
#let beween_class_variances_merged = k_merged.map(k => between_class_variance(i_merged, p: p_merged, k: k));


1. 先依次统计出四个子图的灰度值的像素数量 $n_i$ 和概率 $p_i$
  1. 左上角 $i_0$ ， $n_0$ 和 $p_0$ #table(
    columns: (1fr, ) * (i_0.len() + 1),
    [$i_0$], ..i_0.map(value => [#decimal(value, n: 3)]),
    [$n_0$], ..n_0.map(value => [#decimal(value, n: 3)]),
    [$p_0$], ..p_0.map(value => [#decimal(value, n: 3)]),
    table.hline()
  )
  2. 右上角 $i_1$ ， $n_1$ 和 $p_1$ #table(
    columns: (1fr, ) * (i_1.len() + 1),
    [$i_1$], ..i_1.map(value => [#decimal(value, n: 3)]),
    [$n_1$], ..n_1.map(value => [#decimal(value, n: 3)]),
    [$p_1$], ..p_1.map(value => [#decimal(value, n: 3)]),
    table.hline()
  )
  3. 左下角 $i_2$ ， $n_2$ 和 $p_2$ #table(
    columns: (1fr, ) * (i_2.len() + 1),
    [$i_2$], ..i_2.map(value => [#decimal(value, n: 3)]),
    [$n_2$], ..n_2.map(value => [#decimal(value, n: 3)]),
    [$p_2$], ..p_2.map(value => [#decimal(value, n: 3)]),
    table.hline()
  )
  4. 右下角 $i_3$ ， $n_3$ 和 $p_3$ #table(
    columns: (1fr, ) * (i_3.len() + 1),
    [$i_3$], ..i_3.map(value => [#decimal(value, n: 3)]),
    [$n_3$], ..n_3.map(value => [#decimal(value, n: 3)]),
    [$p_3$], ..p_3.map(value => [#decimal(value, n: 3)]),
    table.hline()
  )
  分别对四个子图进行 Otsu's method 的计算，得到每个子图的最优阈值 $k$ 和对应的类间方差 $sigma_b^2$，如下表所示：#table(
    columns: (1fr, ) * (k.len() + 1),
    [$k$], ..k.map(value => [#value]),
    [$sigma_b^2$ for $i_0$], ..beween_class_variances_0.map(value => [#decimal(value, n: 3)]),
    [$sigma_b^2$ for $i_1$], ..beween_class_variances_1.map(value => [#decimal(value, n: 3)]),
    [$sigma_b^2$ for $i_2$], ..beween_class_variances_2.map(value => [#decimal(value, n: 3)]),
    [$sigma_b^2$ for $i_3$], ..beween_class_variances_3.map(value => [#decimal(value, n: 3)]),
    table.hline()
  )
  由此可得四个子图的最优阈值分别为：
  1. $k_0 = 1$，也就是左上角的局部最优阈值 $i_0 = 0.5$
  2. $k_1 = 1$，也就是右上角的局部最优阈值 $i_1 = 1.5$
  3. $k_2 = 1$，也就是左下角的局部最优阈值 $i_2 = 2.5$
  4. $k_3 = 1$，也就是右下角的局部最优阈值 $i_3 = 3.5$



2. 根据四个子图的局部最优阈值，得到完整的 $16 times 16$ 二值化结果如下所示：#table(
    columns: (1fr, ) * (i_all.len() * 4 - 3),
    [$i$], ..i_merged.map(value => [#decimal(value, n: 2)]),
    [$p$], ..p_merged.map(value => [#decimal(value, n: 2)]),
    table.hline()
  )
  同理，计算全局的最优阈值，得到 $k = 1$，也就是全局最优阈值为 $i = 1.5$，根据这个全局阈值进行二值化处理，得到的结果如下所示：#table(
    columns: (1fr, ) * (i_merged.len()),
    [$k$], ..k_merged.map(value => [#decimal(value, n: 2)]),
    [$sigma_b^2$], ..beween_class_variances_merged.map(value => [#decimal(value, n: 2)]),
    table.hline()
  )
  可以看到最大的全局类间方差出现在 $k = 4$ 处，也就是说，全局最优阈值为 $i = 2.0$。

  *显然：单个全局阈值无法得到与四个局部阈值相同的二值化结果。*




#let I_data = (
  (50, 55, 60, 65, 70),
  (55, 60, 70, 75, 80),
  (60, 70,150,160,90),
  (65, 75,160,170,100),
  (70, 80,90 ,100 ,110)
)

#pagebreak()
#problem(3)[
  Given a $5 times 5$ grayscale image $I$ as follows:
  $
    I = mat(
      50, 55, 60, 65, 70;
      55, 60, 70, 75, 80;
      60, 70, 150,160, 90;
      65, 75, 160, 170, 100;
      70, 80, 90, 100, 110
    )
  $
  Please apply the main steps of the edge detection algorithm to extract edges from the image. The specific requirements are as follows:
  - Compute Gradients: Use the $3 times 3$ Sobel operator to compute the gradients $G_x$ (horisontal) and $G_y$ (vertical) for the image $I$. Apply zero-padding to handle the boundaries.
  - Compute Gradient Magnitude and Direction: Based on $G_x$ and $G_y$, calculate the gradient magnnitude $sqrt(G_x^2 + G_y^2)$ and the gradient direction $arctan(G_y "/" G_x)$ for each pixel.
]
#SOLUTION

1. 计算 Sobel 算子作用下的梯度计算。Sobel 算子 $gradient_x$ 和 $gradient_y$ 分别为：
$ gradient_x = mat(
  -1, 0, 1;
  -2, 0, 2;
  -1, 0, 1
) 
$
$
  gradient_y = mat(
    -1, -2, -1;
    0, 0, 0;
    1, 2, 1
  )
$
先给原始图像 $I$ 进行零填充，得到 $I'$：
$
  I' = mat(
    0, 0, 0, 0, 0, 0, 0;
    0, 50, 55, 60, 65, 70, 0;
    0, 55, 60, 70, 75, 80, 0;
    0, 60, 70,150,160,90, 0;
    0, 65, 75,160,170,100,0;
    0, 70, 80,90 ,100 ,110 ,0;
    0, 0 ,0 ,0 ,0 ,0 ,0
   )
$
计算部分借助 Python 进行数值计算。先定义基础的矩阵图像 $I$ 和 Sobel 算子 $gradient_x$ 和 $gradient_y$，如下图所示：
#image("image/09-03.png", width: 90%)
然后定义一个完整的卷积函数，包含填充和卷积计算的过程：
#image("image/09-04.png", width: 90%)
计算得到结果：
#image("image/09-05.png", width: 85%)

2. 在（1）的基础上用 numpy 的内置函数很容易计算幅值和方向信息，结果如下所示：
#image("image/09-06.png", width: 85%)


