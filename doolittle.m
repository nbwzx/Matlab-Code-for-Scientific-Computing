function [L,U,y,x]=doolittle(A,b)
n=length(A);     %计算A矩阵的维数
for i=1:n        %判断A矩阵的顺序主子式是否为非零
    w=det(A(1:i,1:i));
    if(w==0)
        error('Matrix must be positive!');
        return;
    end
end
U(1,1:n)=A(1,1:n);     %计算U的第一行元素
L(2:n,1)=A(2:n,1)/U(1,1);  %计算L的第一列元素
for i=1:n              %计算L的对角元素
    L(i,i)=1;
end
for k=2:n
    for j=k:n 
        sum=0;
        for s=1:(k-1)
            sum=sum+L(k,s)*U(s,j);
        end
        U(k,j)=A(k,j)-sum;    %计算U的其余元素
    end
    for i=(k+1):n
        sum=0;
        for s=1:(k-1)
            sum=sum+L(i,s)*U(s,k);
        end
        L(i,k)=(A(i,k)-sum)/U(k,k);    %计算L的其余元素
    end
end
y(1,1)=b(1);      %计算y的第一个元素
for i=2:n
    sumy=0;
    for j=1:i-1
        sumy=sumy+L(i,j)*y(j,1);
    end
    y(i,1)=b(i)-sumy;     %计算y的其余元素
end
x(n,1)=y(n,1)/U(n,n);     %计算x的最后一个元素
for i=(n-1):(-1):1
    sumx=0;
    for j=i+1:n
        sumx=sumx+U(i,j)*x(j,1);
    end
    x(i,1)=(y(i,1)-sumx)/U(i,i);    %计算x的其余元素
end
%以下为输入示例：(想要用doolittle分解(直接三角分解)求解线性方程组)
%A=[1/4,1/5,1/6;1/3,1/4,1/5;1/2,1,2]         
%b=[9;8;8]
%输入：[L,U,y,x]=doolittle(A,b)
%输出：L=.....,U=.....
%      y =[9.0000;-4.0000;-154.0000]
%      x =[-227.0769;476.9231;-177.6923]
%制作：王子兴
%All rights reserved