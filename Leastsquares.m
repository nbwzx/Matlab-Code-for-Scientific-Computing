function cc=Leastsquares(x,y,n,w)
if nargin==3
    w=ones(1,length(x));
elseif nargin<3
    error
    return
end  
if(length(x) == length(y))
    k = length(x);    
else
    disp('x��y��ά������ȣ�');
    return;
end                                      %���
n=n+1;
T=zeros(n,n);
b=zeros(n,1);
s=[ones(1,k)];
for i=1:(k-1)
    s=[s;x.^i];
end
for i=1:n
    for j=1:n
    T(i,j)=inprod(s([i],:),s([j],:),w);
    end
end
for i=1:n
b(i)=inprod(s([i],:),y,w);
end
T
b
cc=T\b;
function ip=inprod(w,f,g)
% ����f��g��Ȩw֮�µ��ڻ�
ip=0;
for i=1:length(f)
ip=ip+w(i)*f(i)*g(i);
end

%����Ϊ����ʾ����(��Ҫ�ö���ʽ��С���������������)
%x=[0.0 0.1 0.2 0.3 0.5 0.8 1.0]
%y=[1.0 0.41 0.50 0.61 0.91 2.02 2.46]
%n=3
%���룺cc = Leastsquares(x,y,n)
%�����cc =[0.9266;-4.6591;12.8147;-6.6221](����y=0.9266-4.6591x+12.8147x^2-6.6221x^3)
%������������
%All rights reserved