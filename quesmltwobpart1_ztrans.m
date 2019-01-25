function [] = quesmltwobpart1_ztrans()

%hahahahaha.....N = 5

syms n N;
syms v;
p = heaviside(n) - heaviside(n - 5);

%for N = 5
syms zt1 

syms z;
zt1 = symsum(p*z^(-n),n,-100,100)

ww = linspace(-2*pi,2*pi,30)

plot(ww,subs(zt1,z,exp(1i*ww)))


%for N = 10
syms zt2
p2 = heaviside(n) - heaviside(n - 10);
zt2 = symsum(p2*z^(-n),n,-100,100)


%for v -100:1:100
 %   dtft = simplify(symsum(dtft,

syms zt3
p3 = heaviside(n) - heaviside(n - 15);
zt3 = symsum(p3*z^(-n),n,-100,100)



%end    






































