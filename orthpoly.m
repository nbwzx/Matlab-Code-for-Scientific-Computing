function g=orthpoly(rho,a,b,n)
syms x % 定义符号变量x
g=sym(zeros(n+1,1));
g(1)=1;
alpha(1)=inprod(rho,x*g(1),g(1),a,b)/inprod(rho,g(1),g(1),a,b);
g(2)=x-alpha(1);
for i=3:n+1
    alpha(i-1)=inprod(rho,x*g(i-1),g(i-1),a,b)/inprod(rho,g(i-1),g(i-1),a,b);
    beta(i-2)=inprod(rho,g(i-1),g(i-1),a,b)/inprod(rho,g(i-2),g(i-2),a,b);
    g(i)=(x-alpha(i-1))*g(i-1)-beta(i-2)*g(i-2);
end
g=expand(g);
%g=vpa(g,6);
function ip=inprod(rho,f,g,a,b)
% 计算函数f和g，在权rho之下的内积
ip=int(rho*f*g,a,b);

%以下为输入示例：(想要构建首项系数为1的正交多项式)
%rho=@(x) abs(x) % 定义权函数
%a=-1 % 定义积分下限
%b=1  % 定义积分上限
%n=4  % 计算前5个正交多项式
%输入：g=orthpoly(rho,a,b,n)  % 调用函数构建正交多项式
%输出：对应权的首项系数为1的正交多项式(共5个)
%制作：王子兴
%All rights reserved