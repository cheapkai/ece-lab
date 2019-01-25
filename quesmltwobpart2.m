function [] = quesmltwobpart2()

%please help!!!!!!!!!!

syms n N;

p = heaviside(n) - heaviside(n - N);

theta = ztrans(p);
thetaone = subs(theta,N,5);

yozerosone = solve(thetaone);
yopoleone = poles(thetaone);

zplane(double(yozerosone),double(yopoleone))
