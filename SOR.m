function [x,n]=SOR(A,b,x0,w,eps,M)
if nargin==4
    eps= 1.0e-6;
    M  = 200;
elseif nargin<4
    error
    return
elseif nargin ==5
    M  = 200;
end  
if(w<=0 || w>=2)
    error;
    return;
end
D=diag(diag(A));    %求A的对角矩阵
L=-tril(A,-1);      %求A的下三角阵
U=-triu(A,1);       %求A的上三角阵
B=inv(D-L*w)*((1-w)*D+w*U);
f=w*inv((D-L*w))*b;
x=B*x0+f;
n=1;                  %迭代次数
while norm(x-x0)>=eps
    x0=x;
    x =B*x0+f;
    n=n+1;
    if(n>=M)
        disp('Warning: 迭代次数太多，可能不收敛！');
        return;
    end
end
%以下为输入示例：(想要SOR迭代求解)
%A=[5,2,1;-1,4,2;2,-3,10]
%b=[-12;20;3]
%x0=[0;0;0]
%w=0.9
%eps=0.0001
%M=200
%输入：[x,n]=SOR(A,b,x0,w,eps,M)
%输出：x=[-4.0000,3.0000,2.0000]
%      n=8
%制作：王子兴
%All rights reserved