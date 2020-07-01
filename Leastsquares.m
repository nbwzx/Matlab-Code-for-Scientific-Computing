function cc=Leastsquares(x,y,k,w)
if nargin==3
    w=ones(1,length(x));
elseif nargin<3
    error
    return
end  
if(length(x) == length(y))
    n = length(x);    
else
    disp('x和y的维数不相等！');
    return;
end                                      %检错
k=k+1;
T=zeros(k,k);
b=zeros(k,1);
s=[ones(1,n)];
for i=1:(n-1)
    s=[s;x.^i];
end
for i=1:k
    for j=1:k
    T(i,j)=inprod(s([i],:),s([j],:),w);
    end
end
for i=1:k
b(i)=inprod(s([i],:),y,w);
end
T
b
cc=T\b  
function ip=inprod(w,f,g)
% 计算f和g在权w之下的内积
ip=0;
for i=1:length(f)
ip=ip+w(i)*f(i)*g(i);
end

%以下为输入示例：(想要多项式拟合以下数据)
%x=[0.0 0.1 0.2 0.3 0.5 0.8 1.0]
%y=[1.0 0.41 0.50 0.61 0.91 2.02 2.46]
%n=3
%输入：[cc,error] = polynomialfit(x,y,k)
%输出：cc =[0.9266;-4.6591;12.8147;-6.6221](代表y=0.9266-4.6591x+12.8147x^2-6.6221x^3)
%制作：王子兴
%All rights reserved