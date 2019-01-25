function [] = quesmloneb();
%i hate u all

n = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
x = 2 - 0.1*n;
b = -1*n;
y = 2 + 0.1*b;
%plot(n,x);
hold on
plot(b,y);
hold on

even = (x)/2;
odd = (x)/2;

plot(n,even);
hold on
plot(n,odd);
hold on
plot(n,(even+odd),'o');
hold on

energy1 = x.^2;
plot(n,energy1,'+');
hold on
energy2 = (even+odd).^2;
plot(n,energy2,'-');
hold on
%plot(n,(energy1 + energy2),'*');
%energy3 = even.^2;





