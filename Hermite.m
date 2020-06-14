function f = Hermite(x,y,y_1,x0)
syms t;
f = 0.0;
if(length(x) == length(y))
    if(length(y) == length(y_1))
        n = length(x);
    else
        disp('y��y�ĵ�����ά������ȣ�');
        return;
    end
else
    disp('x��y��ά������ȣ�');
    return;
end                                      %���
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
            f = subs(f,'t',x0);          %�����ֵ��ĺ���ֵ
        else
            f = collect(f);              %����ֵ����ʽչ��
            f = vpa(f,6);                %����ֵ����ʽ��ϵ������6λ���ȵ�С��
        end
    end
end
%����Ϊ����ʾ����(��ҪHermite��ֵ��������)
%x=[1,2,3]
%y=[4,31,202]
%y_1=[7,65,331]
%x0=4
%���룺Hermite(x,y,y_1)
%�����t^5 - 1.0*t^4 + t^3 + t^2 + t + 1.0
%���룺Hermite(x,y,y_1,x0)
%�����853
%������������
%All rights reserved