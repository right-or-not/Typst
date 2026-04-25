#import "@local/zju-typst-tplt:0.2.0": *

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2026-04-24" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Sensing and Detection" // 课程名称
#let proj-name = "Exercises for Chapter 3" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with(
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
    first-line-indent-all: true,
)

#set par(first-line-indent: 2em)


// ==================== 正文内容 ==================== //
#problem(17)[
    请解释光敏二极管或三极管传感器的光谱特性？并指出下图中（图7）Ge（锗）传感器和 Si（硅）光电传感器光谱特性的区别？
    #image("image/03-11.png", width: 50%)
]
#SOLUTION





#pagebreak()
#problem(18)[
    请解释光敏电阻传感器的频率特性？并说明图中（图 8）两种光敏电阻（硫化铅和硫化镉）传感器点频率响应特性的区别？
    #image("image/03-12.png", width: 50%)
]
#SOLUTION






#pagebreak()
#problem(19)[
    说明金属导体和半导体材料的电阻温度传感器检测温度的原理？用图或特性曲线说明金属热电阻传感器（RTD）与半导体热敏电阻（PTC 和 NTC）传感器的主要区别和特点是什么？
]
#SOLUTION




#pagebreak()
#problem(20)[
    热电偶传感器检测温度的原理是什么？热电偶传感器使用时为什么要冷端补偿。用图说明热电偶传感器冷端温度补偿的方法的工作原理？
]
#SOLUTION