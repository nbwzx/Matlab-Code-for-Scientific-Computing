function [cc,error] = polynomialfit(x,y,n)
cc=polyfit(x,y,n)                   %拟合函数的各次项系数
xx=x(1):0.01:x(length(x));
yy=polyval(cc,xx);
plot(xx,yy,'r');
hold on;
plot(x,y,'x');
xlabel('x');
ylabel('y');
xx=x;
yy=polyval(cc,xx);
error=sum((yy-y).^2);
error=vpa(error,6)                   %误差
end
%以下为输入示例：(想要多项式拟合以下数据)
%x=[0.0 0.1 0.2 0.3 0.5 0.8 1.0]
%y=[1.0 0.41 0.50 0.61 0.91 2.02 2.46]
%n=3
%输入：[cc,error] = polynomialfit(x,y,n)
%输出：cc=[-6.6221,12.8147,-4.6591,0.9266](代表y=-6.6221x^3+12.8147x^2-4.6591x+0.9266)
%      error=0.0525501
%制作：王子兴
%All rights reserved