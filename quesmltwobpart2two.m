function [] = quesmltwobpart2two()

%please help!!!!!!!!!!

syms n N;

p = heaviside(n) - heaviside(n - N);

theta = ztrans(p);
thetatwo = subs(theta,N,10);

yozerostwo = solve(thetatwo);
yopoletwo = poles(thetatwo);

zplane(double(yozerostwo),double(yopoletwo))
