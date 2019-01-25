function [] = quesmltwobpart2_2two()

%please help!!!!!!!!!!
syms w;
syms n N;

p = heaviside(n) - heaviside(n - N);
j = sqrt(-1);
theta = ztrans(p);
thetatwo = subs(theta,N,10);
%thetaonecross = subs(thetaone,z,j*w);
yozerostwo = solve(thetatwo);
yopoletwo = poles(thetatwo);

thetacross = ztrans(p,1i*w)

thetacrosstwo = subs(thetacross,N,10)

solve(thetacrosstwo)
%yozeroscrossone = solve(thetacrossone,w)
