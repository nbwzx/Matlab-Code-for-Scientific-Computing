function s=Comtrapezium(f,a,b,n)
%f为被积分函数
%a，b是积分上下限
%n是子区间个数
%s是积分值
h=(b-a)/n;
s=0;
for k=1:(n-1)
    x=a+h*k;
    s=s+feval(f,x);
end
format long
s=h*(feval(f,a)+feval(f,b))/2+h*s;
%以下为输入示例：(想要用复合梯形公式计算定积分)
%f=@(x) sqrt(x).*log(x)
%a=0.0001
%b=1
%n=32
%输入：s=Comtrapezium(f,a,b,n)
%输出：s=-0.439775629434779
%制作：王子兴
%All rights reserved