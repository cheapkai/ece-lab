function [] = quesmlonea(tin);
%i hate u all
t = linspace(0,0.2+tin,150);
G = (1+0.4*cos(15*pi*t)).*(t>=zeros(1,150));
V = (t>=zeros(1,150)) + 3*(t>=ones(1,150)) - 2*(t>=(zeros(1,150)-ones(1,150))); 

f = (t>=(zeros(1,150)+tin));

I = ((V.*G).*f);

plot(t,I);

%axis('equal');
title(['yo the plot die switch closes at tin',num2str(tin)]);




