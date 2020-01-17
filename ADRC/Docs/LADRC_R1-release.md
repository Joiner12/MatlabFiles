# ladrc & adrc

## 1.控制器框图

### 1.1 ADRC系统框图

<img src= "figures/ADRC-1.png">

### 1.2 LADRC系统框图

<center>
    <img src= "figures/sec-order.png" style="width:800px;height:495px;">
    <p style = "align:auto">
        PD+一阶扩张观测器（D = 1，现采用）
    </p>
    <p>
        输入量为速度控制量
    </p>
</center>

 ADRC(active disturbance rejection control)相对于LADRC(linear active disturbance rejection control)最大的区别在于是否采用Fal非线性函数，Fal函数形式比较复杂，也有很多不同的其他形式，比如改进sigmoid、tanh、反双曲正弦；非线性函数参数比较多，不容易调试。LADRC采用了线性形式代替ADRC中非线性函数。需要调试的参数较小，但是是否非线性函数带来的性能上降低足够明显。

<center>
    <p>
    </p>
    <img src= "figures/kalman-eso-2.png" style="width:800px;height:495px;">
    <p style = "align:auto;font-family:'consoles';">
        kalman-version1(Todo) 
    </p>
    <p>
    通过Kalman滤波器对输出位置偏差进行滤波
</p>
</center>



<center>
    <p> 
    </p>
    <img src= "figures/kalman-eso-3.png" style="width:800px;height:495px;">
    <p style = "align:auto;font-family:'consoles';">
        kalman-version2(Todo) 
    </p>
    <p>
    通过Kalman滤波器对输出位置偏差进行滤波
</p>
</center>

  扩张状态观测器具有扰动估计的能力，扰动估计能力是否足够应对比较极端的情况，比如说反馈系数偏差很大，管切过楞的抖动情况。此外状态观测器设计上有个前提，noise free(即假设系统反馈端不存在噪声)。无Kalman系统是将随动头包括加工工件视为一体，都作为被控对象，加入kalman滤波器的系统是将切割头和板分开为两个子系统处理；无Kalman滤波器系统没有使用编码器的反馈信息，同电容传感器反馈信息比较，编码器反馈的信息更为精准，包含系统外部扰动小。通过信息融合的方式，加入编码器反馈可以可能效果会更好，关于kalman滤波器的测试效果，之前在尝试解决管切抖纹的时候使用过，经过kalman滤波之后的管切过楞高度反馈相比较于直接从电容查表获得的反馈更为精准、噪声更小。






## 2.复合微分跟踪器

**（1）跟踪器作用说明**

​	微分跟踪器根据最速综合函数原理，有两个作用：1、原始信号跟踪（安排过度过程、滤波。）;2、提取一（高）阶微分信号，设定值单位是高度，一阶微分信号即速度。一般形式[H .Jq]的微分跟踪器存在问题，跟踪快速性和噪声放大的问题，因此采用复合微分跟踪器。

​	复合微分跟踪器的本质是，带前馈的微分跟踪器，复合微分跟踪器相比较于一般形式的微分从仿真结果看信号频率比较小的时候（< 5hz），白噪声协方差为输入正弦信号0.04的仿真情况下，跟踪相位滞后同一般形式的微分跟踪器小，一阶微分信号相差也不大，由于前馈的参数是定值，输入信号频率增大的时候，跟踪出来的信号会出现超调的问题（跟踪信号幅值比原始信号大）。



### 2.1 微分跟踪器

$$
\begin{align}
&\bold{General- form:一般形式（等效线性）微分跟踪器}\\
&\begin{cases}

\dot x_1(t) = x_2(t)\\
\dot x_2(t) = R^2[-k_1(x_1(t)-v(t)) - k_2\frac{x_2(t)}{R}]\\
\end{cases}\\
& f(.)：作用函数 \\
& f(.) = R^2[-k_1(x_1(t)-v(t)) - k_2\frac{x_2(t)}{R}] + \alpha \dot v(t)\\
& 只要f(.) 渐进稳定，x1(t) 收敛于 v(t)，x(2)t 收敛于\dot {v(t)}\\
\end{align}
$$

---


$$
\begin{align}
&\bold{General- Forward -Form:复合微分跟踪器}\\
& \\
&\begin{cases}

\dot x_1(t) = x_2(t)\\
\dot x_2(t) = R^2[-k_1(x_1(t)-v(t)) - k_2\frac{x_2(t)}{R}] + \alpha \dot v(t)\\


\end{cases}\\
\end{align}
$$

---

$$
\begin{align}
&\bold{Discrete- Forward-Form:复合微分跟踪器离散形式}\\
&\begin{cases}
T:sample-period\\
x_1(k+1)  = x_2(k)*T + x_1(k) \\
x_2(k+1)= x_2(k) + T[R^2 f(.)] + \alpha [v(k+1) - v(k)]\\
f(.)  = -k_1[x_1(t)-v(t)] - k_2\frac{x_2(t)}{R}\\
\end{cases}
\end{align}
$$
---

---

**系统跟踪输出与输入信号传递函数：**
$$
\begin{align}
& \bold{微分跟踪器参数调试依据}\\
& \frac{x_1}{v} = \frac{k_1R^2}{S^2 + k_2RS + k_1R^2}\\
& 系统固有频率:\omega _n = R*\sqrt{k_1},阻尼系数：\xi = \frac{k_2}{2*\sqrt{k_1}}\\

& \frac{x_2}{v} = \frac{R^2k_1S}{S^2 + Rk_2S+k_1R^2}\\
\end{align}
$$

### 2.2 系统框图



<img src="figures/CompoundTd.png"  style="zoom:50%">



### 2.3 仿真结果

仿真参数：

```matlab
%{
TDA:2.2,1.3,15,5
TDB:2.2,2.8,150,40
%}

% 2019-12-1
TDA:2.2,1.3,30,15
TDB:2.2,2.8,30,18

```

仿真结果：阶跃信号跟踪10，高斯白噪：方差0，协方差：0.01

<center>
    <img src= "C:\Users\Whtest\Desktop\Figures\跟踪器.png" style="width:800px;height:495px;">
    <p style = "align:auto">
        跟踪输出
    </p>
</center>



<center>
    <img src= "C:\Users\Whtest\Desktop\Figures\微分.png" style="width:800px;height:495px;">
    <p style = "align:auto">
        微分信号估计
    </p>
</center>



### 2.4 代码

##### ELDT.h

```c
/*-----------------------ELDT_R1.h----------------------*/
```

##### ELDT.c

```c
#include "ELDT.h"
```



## 3.ESO（扩张状态观测器）

### 3.1 被控对象数学模型

#### 1、一类非线性形式被控对象

$$
\begin{align}
&\bold{单输入单输出（非线性）系统}\\
& \begin{cases} 

x^{(n)}(t) = f(t,x(t),\dot x(t), \ddot x(t),...x^{(n-1)}(t)) + \omega(t) + u(t)\\
y(t) = x(t)\\
 
\end{cases}\\
& x^{n}(t) ：n阶微分\\
& y(t) :系统输出，u(t)：系统输入
\end{align}
$$

#### 2、线性系统状态空间表达式

$$
\begin{align}
&\begin{cases}
\dot x_1(t) = x_2(t),x_1(0)=x_{10}\\
\dot x_2(t) = x_3(t),x_2(0)=x_{20}\\

.\\.\\.\\
\dot x_n(t) = f(t,x_1(t),...x_{n}(t)) + \omega(t) + u(t),x_{n0}(0) = x_{n0} \\
y(t) = x_1(t)
\end{cases}\\
&状态空间表达式:\\
&\begin{cases}
\dot x = Ax + Bu\\
y = Cx\\
系统状态选取：x_1 = y（位置）,x_2 = \dot y（速度）
\end{cases}\\


\end{align}
$$

#### 3.扩张观测器

$$
\begin{align}
&\bold{扩张状态观测器（本质是一个龙伯格观测器）：}\\
&系统状态选取：x_1 = y（位置）,x_2 = \dot y（速度）,x_3 = \ddot y(加速度|扩张状态)\\

&\begin{cases}
\widehat x = A\widehat x + Bu + L(y-\widehat y) \\
\widehat y = C\widehat x
\\
观测器参数L=[\beta1,\beta2,\beta3]
\end{cases}\\
\\ \\
\\

&\bold{扩张状态观测器连续形式：}\\
&\begin{cases}
\varepsilon_1 = x_1(t) - y\\
\dot x_1(t) = x_2(t) - \beta_1 \varepsilon_1\\
\dot x_2(t) = x_3(t) - \beta_2 \varepsilon_1 + b_0u\\
\dot x_3(t) = -\beta_3 \varepsilon_1\\
&\end{cases}\\
&u = \frac{-x_3(t)+u_0}{b_0} \\
& u :控制输入量
\\ \\
\\

&\bold{扩张状态观测器离散形式：}\\
& 离散方式：显示欧拉\\
&\begin{cases}
h:sample \space period \\
\varepsilon_1 = x_1(k) -y(k)\\
x_1(k+1) = x_1(k) + (x_2(t)-\beta_1\varepsilon_1)h\\
x_2(k+1) = x_2(k) + (x_3(k)-\beta_2 \varepsilon_1+ b_0u(k))h \\
x_3(k+1) = x_3(k) - \beta_3\varepsilon_1\\
\end{cases}\\


\end{align}
$$



#### 4.控制律

$$
\begin{align}
& 形式一（）：\\
& u_0 ：虚拟控制量 \\
& u_0 = kp*(track - \widehat x_1) + kd*(diff - \widehat x_2)\\
&track:微分跟踪器跟踪输出，diff ：微分跟踪器一阶导数\\

& 形式二：\\
& u_0 = kp*(r - y) + kd*(- \dot y)  \\
& r：设定值 ,\dot r 一阶导数 \\

& 形式三：\\
& u_0 = kp*(r - y) + kd*(\dot r - \dot y) + \ddot r (现在采用方式)\\
& r：设定值 ,\dot r 一阶导数 ,\ddot r 二阶导数 \\
&u(k) = \frac{u_0 - \widehat x_{n+1}}{b_0}\\
& b_0:估计等效控制增益\\
\end{align}
$$



关于线性扩张观测器参数整定，有一个通用公式（GetLADRCParam），

关于扩张观测器参数说明：

1.观测器带宽选取存在系统噪声放大和观测结果准确矛盾。

2.根据参数计算公式，参数上升很快，计算过程中会出现很大的值，（1E7 ）

3.b0：等效控制增益，越大对扰动抑制效果越明显，不合适会出现抖动问题。

4.最终的控制输出量是速度，暂没尝试修改驱动器为转矩（加速度）控制模式。

5.采用控制形式三，能初步调试出符合要求的控制效果；

```matlab
function GetLADRCParam(w0)
%{
    β1 = 3*ω0，β2 = 3*ω0^2 β3 = ω0^3,ω0(rad/s)是观测器带宽，
    现在使用参数：800,90,2700,27000
%}
    beta_1 = w0*w0;
    beta_2 = 3*beta_1;  
    beta_3 = w0*beta_1;
    fprintf('bandwidth of eso is %d rad/s,beta_1:%d,beta_2:%d,beta_3:%d\nParams:%d,%d,%d\n'...
        ,w0,beta_1,beta_2,beta_3,beta_1,beta_2,beta_3);
end
```



### 3.2 离散方式

**显示欧拉（前向差分）:**

**代码实现过程中，统一使用显示欧拉形式进行计算离散。**
$$
\begin{align}
&\Rightarrow\dot x_1(t) = x_2(t)\\
& \Rightarrow \frac{x_1(k+1) - x_1(k)}{h} = x_2(k)\\
&\Rightarrow x_1(k+1) = h*x_2(k) + x_1(k)\\
&采样周期h：[5e-4] ms (1/2000)\\
\end{align}
$$
**隐式欧拉（后向差分):**
$$
\begin{align}
&\Rightarrow\dot x_1(t) = x_2(t)\\
& \Rightarrow \frac{x_1(k) - x_1(k-1)}{h} = x_2(k)\\
&\Rightarrow x_1(k) = h*x_2(k-1) + x_1(k)\\

\end{align}
$$



### 3.4 对于ESO限幅的思考

##### 1.参考高增益观测器

控制器设计中，通常会存在快速性和噪声敏感性之间的矛盾，ESO同样如此。此外还存在峰值现象（'peaking' phenomenon），从频域分析角度看，ESO参数随着级数增大速度上升很大，超过三阶就很容易出现溢出问题，但是实际情况是，不会有这么大的值出现，已有的解决方案是对于高阶状态进行限幅。直接对ESO高阶状态限幅，直观理解是类似于输出饱和以及加速度限制，两种方式并存（[TodoList](验证有效性)）。

[ From High Gain Observer](https://www.researchgate.net/post/What_are_the_advantages_of_a_High-Gain_observer_in_comparison_to_standard_observers_like_ELO_EKF_or_UKF_without_time-consuming_high-gain_operations)

 扩张状态（x2(t)）表示速度，UnitP/Step = 1UnitP/5e-4ms  = 2000 UnitP/ms另外一种操作方式是对其加速度进行限制。

##### 2.使用kalman方式

 使用kalman滤波之后的电容位置作为输出量。

### 3.5 代码 

#### ESO.h

```c
#ifndef ESO_H_
#define ESO_H_
#endif
```

####  ESO.c

```c
#include "ESO.h"

```



#### LADRC.h

```c
#ifndef LADRC_H_
#define LARDC_H_
#include "ELDT.h"
#include "ESO.h"
#include "global.h"
#include "FollowPID.h"
#endif
```

#### LADRC.c

```c
#include "LADRC.h"
#include "ELDT.h"
#include "FollowPID.h"
#include "CapSensor.h"

```



#### FollowCtrl.c

```c
void Follow_OnStep(Follow* pSelf_)
{
    static int _s_nCnt = 0;
    if (_s_nCnt > MAXINT32)
    {
        _s_nCnt = 0;
    }
    LogValue(_s_nCnt++,CapheightUnitP_,EncoderP_,X_1,X_2,CtrlUnitV_);
    
}
```



## 4.Kalman

#### 4.1原理解析

#### 4.2 代码

##### Kalman_Int.h



##### Kalman_Int.c





## 5.仿真实验方案

### 4.1 测试实验方案

- 正弦信号跟踪（理论）

- 阶跃信号测试（测试中）

- ITAE性能指标（理论）

- 抗扰动能力测试实验方案

  边缘开随动，振动抑制

- 首次开随动时间

- 参数简化

- 高位阶跃（1mm → 10mm）(实测)

### 4.2 仿真结果

#### 1.阶跃+正弦含噪问题

<center>
    <img src="figures\阶跃+1hz.png" style="width:800px;height:495px">
    <p>
        阶跃 + 1hz
    </p>
</center>



#### 2.Chirp信号跟踪

<center>
    <img src="figures\chirp.png" style="width:800px;height:495px">
    <p>
        (0 - 5hz sin函数)
    </p>
</center>



#### 3.Square信号跟踪

<center>
    <img src="figures\square.png" style="width:800px;height:495px">
    <p>
        方波信号
    </p>
</center>



### 4.3 实测结果

##### 1.阶跃1-10mm测试

<center>
    <img src="figures\state-1.png" style="width:800px;height:495px">
    <p>
        阶跃测试状态
    </p>
</center>



<center>
    <img src="figures\1mmTo10mm-1.png" style="width:800px;height:495px">
    <p>
        阶跃测试编码器位置反馈
    </p>
</center>



##### 2.方波测试

<center>
    <img src="figures\方波-1.png" style="width:800px;height:495px">
    <p>
        方波测试状态
    </p>
</center>



##### 3.边缘测试

<center>
    <img src="figures\edge-step-1.png" style="width:800px;height:495px">
    <p>
        边缘随动阶跃测试 电容 状态估计器2mm → 5mm 
    </p>
</center>



<center>
    <img src="figures\encoder-step-1.png" style="width:800px;height:495px">
    <p>
        边缘随动阶跃测试 编码器位置2mm → 5mm<br>
        实际运动运动：2.16mm
    </p>
</center>

<center>
    <img src="figures\state-step-1.png" style="width:800px;height:495px">
    <p>
        边缘随动阶跃测试 编码器位置2mm → 5mm<br>
        系统一阶状态有抖动趋势
    </p>
</center>





 说明：

1.边缘测试阶跃响应，出光口完全在板材内部，进行1mm → 5mm 阶跃测试会抖动；

2.出边过多（二分之一出边）首次开随动会出现撞板问题；

3.实测发现，出光口一半在外的情况下，出现随动高度阶跃（4mm）实际编码器只运动3mm，仿真过程中，如果将电容反馈乘上系数gain(gain > 1)出现类似情况；





## 6. 关键（TODO）问题

1.控制器形式确定；

2.参数整定（微分跟踪器+PD参数）；

3.实测（波浪板模拟-sin波形）；

4.ESO出现peak phonomena 导致溢出问题；

5.扰动测试结果；

6.管切测试；



## 7.被控对象模型

（机理推断）速度控制方式：
$$
\begin{align}
& 积分环节+一阶惯性环节:
G(s) = \frac{b_0}{S(aS+1)}\\
& 
\end{align}
$$


System Identification:

```c
                16.75 (+/- 0.2556) s - 0.2331 (+/- 1.816)
            --------------------------------------------------
            s^2 + 0.3274 (+/- 0.1804) s + 0.06028 (+/- 0.3627)
```



