function  Cubicspline(x,y,flag,y1_deri,yn_deri)
if nargin==3
    y1_deri=0;
    yn_deri=0;
elseif nargin<3
    error
    return
end  
n = length(x);
for i = 1 : n-1
    h(i) = x(i+1) -  x(i);
end
fprintf('计算 h 结果为:\n');
h
if flag~=3 
for i = 2 : n-1
    u(i-1) = h(i-1) / (h(i-1) + h(i));      
    lambda(i) = h(i) / (h(i-1) + h(i));     
end
if flag == 1
    u(n-1) = 1;
    lambda(1) = 1;
elseif flag == 2
    u(n-1) = 0;
    lambda(1) = 0;
end
end
if flag == 3 
for i = 1 : n-1
    u(i) = h(1) / (h(i) + h(1));      
    lambda(i) = h(i) / (h(i) + h(1));
end
end
fprintf('计算 μ 结果为: \n');
u
fprintf('计算 λ 结果为：\n');
lambda
if flag~=3 
for i = 2 : n-1
    d(i) = 6 * ((y(i+1)-y(i))/(x(i+1)-x(i)) - (y(i) - y(i-1))/( x(i) - x(i-1)))/(h(i-1)+h(i));
end
if flag == 1
    d(1) = 6 / h(1) * (( y(2)-y(1) )/( x(2) - x(1) ) - y1_deri);
    d(n) = 6 / h(n-1) * (yn_deri - ((y(n) - y(n-1)) / ( x(n) - x(n-1))));
elseif flag == 2
    d(1) = 2 * y1_deri;
    d(n) = 2 * yn_deri;
end
end
if flag == 3 
for i = 1 : n-1
    d(i) = 6 * ((y(2)-y(1))/(x(2)-x(1)) - (y(i+1) - y(i))/( x(i+1) - x(i)))/(h(1)+h(i));
end
end
fprintf('计算 d 结果为：\n');
d
if flag~=3 
matrix1 = zeros(n,n);
for i = 1 : n-1
    matrix1(i,i) = 2;
    matrix1(i,i+1) = lambda(i);
    matrix1(i+1,i) = u(i);
end
matrix1(n,n) = 2;
end

if flag==3 
matrix1 = zeros(n-1,n-1);
for i = 1 : n-2
    matrix1(i,i) = 2;
    matrix1(i,i+1) = lambda(i);
    matrix1(i+1,i) = u(i+1);
end
matrix1(n-1,n-1) = 2;
matrix1(1,n-1) = u(1);
matrix1(n-1,1) = lambda(n-1);
end
fprintf('计算 matrix1 结果为:\n');
matrix1
fprintf('计算 M 结果为:\n');
M = matrix1\d'
if flag==3 
M = [M(n-1);M]
end
for i = 1 : n-1
    clear S
    syms t
    k = x(i):0.001:x(i+1);
    fprintf('区间为[ %.3f , %.3f]\n',x(i),x(i+1));
    S = M(i)*(x(i+1)-t)^3/ (6*h(i)) + M(i+1)*(t - x(i))^3/(6*h(i))+(y(i) - M(i)*h(i)^2/6)*(x(i+1) - t)/h(i) + (y(i+1) - M(i+1)*h(i)^2/6)*(t - x(i))/h(i); 
    S = collect(S);
    S = vpa(S,4)
%    s = M(i)*(x(i+1)-k).^3/ (6*h(i)) + M(i+1)*(k - x(i)).^3/(6*h(i))+(y(i) - M(i)*h(i)^2/6)*(x(i+1) - k)/h(i) + (y(i+1) - M(i+1)*h(i)^2/6)*(k - x(i))/h(i);
%    hold on;
%    plot(k,s);                     %如果要画图则取消注释
end
%以下为输入示例：(想要三次样条插值以下数据)
%x =[1,4,9,16,25,36,49,64]         %输入横坐标，格式:[x1 x2 …… xn]
%y =[1,2,3,4,5,6,7,8]              %输入纵坐标，格式:[y1 y2 …… yn]
%flag =1                           %选择边界条件：①已知两端一阶导数值，②已知两端二阶导数值  ③周期性边界条件
%y1_deri = 0.5                     %(x1,y1) 点的一阶导数值或者二阶导数值或者空
%yn_deri = 0.0625                  %(xn,yn) 点的一阶导数值或者二阶导数值或者空
%输入：Cubicspline(x,y,flag,y1_deri,yn_deri)
%输出：......
%制作：王子兴
%All rights reserved