function [L,D,y,x]=improvecholesky(A,b)    %用改进平方根法求解Ax=b
n=length(b);
L=zeros(n,n);                                %L为n*n矩阵
D=diag(n,0);                                 %D为n*n的主对角矩阵
S=L*D;
for i=1:n                                    %L的主对角元素均为1
    L(i,i)=1;
end
D(1,1)=A(1,1);                               %将A分解使得A=LDLT
for i=2:n
   for j=1:i-1
       S(i,j)=A(i,j)-sum(S(i,1:j-1)*L(j,1:j-1)');
       L(i,1:i-1)=S(i,1:i-1)/D(1:i-1,1:i-1);
   end  
   D(i,i)=A(i,i)-sum(S(i,1:i-1)*L(i,1:i-1)');
end
y=zeros(n,1);                                % x, y为n*1阶矩阵
x=zeros(n,1);
for i=1:n
   y(i)=(b(i)-sum(L(i,1:i-1)*D(1:i-1,1:i-1)*y(1:i-1)))/D(i,i);  
   %通过 LDy=b解得y的值
end
for i=n:-1:1  
    x(i)=y(i)-sum(L(i+1:n,i)'*x(i+1:n));                       
   %通过LTx=y解得x的值
end
%以下为输入示例：(想要用改进的平方根法求解线性方程组)
%A=[2,-1,1;-1,-2,3;1,3,1]     
%b=[4;5;6]
%输入：[L,D,y,x]=improvecholesky(A,b)
%输出：L=.....,D=.....
%      y =[2.0000;-2.8000;2.5556]
%      x =[1.1111;0.7778;2.5556]
%制作：王子兴
%All rights reserved