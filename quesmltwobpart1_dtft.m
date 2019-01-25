function [] = quesmltwobpart1_dtft()
%pleeeeeeease help me!!
syms n N;
p = heaviside(n) - heaviside(n - 5);

%for N = 5
syms dtft1

syms w;

dtft1 = symsum(p*exp(1i*w)^(-n),n,-100,100)

ww = linspace(-2*pi,2*pi,30)
plot(ww,subs(dtft1,w,ww))

%plot(double(w),double(dtft1))
%for N = 10
syms dtft2
p2 = heaviside(n) - heaviside(n - 10)
dtft2 = symsum(p2*exp(1i*w)^(-n),n,-100,100)

%for N = 15
syms dtft3
p3 = heaviside(n) - heaviside(n - 15)
dtft3 = symsum(p3*exp(1i*w)^(-n),n,-100,100)

