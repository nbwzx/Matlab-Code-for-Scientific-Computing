function f = Hermite(x,y,y_1,x0)
syms t;
f = 0.0;
if(length(x) == length(y))
    if(length(y) == length(y_1))
        n = length(x);
    else
        disp('y和y的导数的维数不相等！');
        return;
    end
else
    disp('x和y的维数不相等！');
    return;
end                                      %检错
for i=1:n
    h = 1.0;
    a = 0.0;
    for j=1:n
        if( j ~= i)
            h = h*(t-x(j))^2/((x(i)-x(j))^2);
            a = a + 1/(x(i)-x(j));
        end
    end
    f = f + h*((x(i)-t)*(2*a*y(i)-y_1(i))+y(i));
    if(i==n)
        if(nargin == 4)
            f = subs(f,'t',x0);          %计算插值点的函数值
        else
            f = collect(f);              %将插值多项式展开
            f = vpa(f,6);                %将插值多项式的系数化成6位精度的小数
        end
    end
end
%以下为输入示例：(想要Hermite插值以下数据)
%x=[1,2,3]
%y=[4,31,202]
%y_1=[7,65,331]
%x0=4
%输入：f = Hermite(x,y,y_1)
%输出：f=t^5 - 1.0*t^4 + t^3 + t^2 + t + 1.0
%输入：f = Hermite(x,y,y_1,x0)
%输出：f=853
%制作：王子兴
%All rights reserved
