function [] = quesmltwobpart2()

%please help!!!!!!!!!!

syms n N;

p = heaviside(n) - heaviside(n - N);

theta = ztrans(p);
thetathree = subs(theta,N,5);

yozerosthree = solve(thetathree);
yopolethree = poles(thetathree);

zplane(double(yozerosthree),double(yopolethree))
