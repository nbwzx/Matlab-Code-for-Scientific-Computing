function  [s,err]=Romberg(f,a,b,n)
%f为被积分函数
%a，b是积分上下限
%n+1是T数表的列数
%T表示T数表
%s是所求积分值
m=1;
h=b-a;
err=1;J=0;
T=zeros(n,n);%定义T表初始值
T(1,1)=h*(feval(f,a)+feval(f,b))/2;
while (J<n)
    J=J+1;
    h=h/2;
    s=0;
    for k=1:m
        x=a+h*(2*k-1);
        s=s+feval(f,x);
    end
    T(J+1,1)=T(J,1)/2+h*s;
    m=2*m;
    for i=1:J
        T(J+1,i+1)=T(J+1,i)+(T(J+1,i)-T(J,i))/(4^i-1);
    end
    err=abs(T(J,J)-T(J+1,i+1));
end
format long
s=T(J+1,J+1);
T
%以下为输入示例：(想要用龙贝格求积)
%f=@(x) sqrt(x).*log(x)
%a=0.0001
%b=1
%n=16
%输入：[s,err]=Romberg(f,a,b,n)
%输出：s=-0.444437859772903
%      err=1.445721320436633e-11
%制作：王子兴
%All rights reserved