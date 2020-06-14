function  s=Comsimpson(f,a,b,n)
%f为被积分函数
%a，b是积分上下限
%n是子区间个数
%s是积分值
h=(b-a)/(2*n);
s1=0;s2=0;
for k=1:n
    x=a+h*(2*k-1);
    s1=s1+feval(f,x);
end
 for k=1:(n-1)
     x=a+h*2*k;
     s2=s2+feval(f,x);
 end
 format long
 s=h*(feval(f,a)+feval(f,b)+4*s1+2*s2)/3;
%以下为输入示例：(想要用复合Simpson公式计算定积分)
%f=@(x) sqrt(x).*log(x)
%a=0.0001
%b=1
%n=32
%输入：s=Comsimpson(f,a,b,n)
%输出：s=-0.443683060926222
%制作：王子兴
%All rights reserved