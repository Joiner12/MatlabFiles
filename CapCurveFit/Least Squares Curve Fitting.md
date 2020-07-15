## 最小二乘直线拟合

　最小二乘拟合 是一种数学上的近似和优化，利用已知的数据得出一条直线或者曲线，使之在坐标系上与已知数据之间的距离的平方和最小。TLS(Total Least Squares) vs OLS(Ordinary Least Squares)

![image-20200715151613078](C:\Users\Whtest\AppData\Roaming\Typora\typora-user-images\image-20200715151613078.png)







![image-20200715150936513](C:\Users\Whtest\AppData\Roaming\Typora\typora-user-images\image-20200715150936513.png)



通过解 XB=Y 我们就能解出 B=[m b]：
$$
\begin{align}
&B = [m \ b]\\
&m = \frac{ \sum x_i^2 \sum y_i - \sum x_i (\sum x_i y_i)}{n\sum x_i^2 - (\sum x_i)^2}\\
&b= \frac{n \sum x_i \sum y_i - \sum x_i (\sum x_i y_i)}{n\sum x_i^2 - (\sum x_i)^2}
\end{align}
$$


```c
OrdinaryLeastSquare(const vector<double>& x, const vector<double>& y) {
        double t1=0, t2=0, t3=0, t4=0;  
        for(int i=0; i<x.size(); ++i)  { 
            t1 += x[i]*x[i];  
            t2 += x[i];  
            t3 += x[i]*y[i];  
            t4 += y[i];  
        }
        m = (t3*x.size() - t2*t4) / (t1*x.size() - t2*t2);
        b = (t1*t4 - t2*t3) / (t1*x.size() - t2*t2);
}
```



OLS 这种 least square 存在问题，比如针对垂直线段就不行，于是引入第二种 Total Least Square。

![image-20200715152134782](C:\Users\Whtest\AppData\Roaming\Typora\typora-user-images\image-20200715152134782.png)





### References:

[1] https://durant35.github.io/2017/07/21/Algorithms_LeastSquaresLineFitting/