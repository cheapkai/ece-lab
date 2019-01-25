function [] = quesmltwobpart2_3two()

%please help!!!!!!!!!!
syms w;
syms n N;

p = heaviside(n) - heaviside(n - N);
j = sqrt(-1);
theta = ztrans(p);
thetatwo = subs(theta,N,10);
%thetaonecross = subs(thetaone,z,j*w);
%yozerosone = solve(thetaone);
%yopoleone = poles(thetaone);

%thetacross = ztrans(p,1i*w)

%thetacrossone = subs(thetacross,N,5)

%solve(thetacrossone)

[N,D] = numden(thetatwo)

Cn = coeffs(N)
Cd = coeffs(D)

%yozeroscrossone = solve(thetacrossone,w)

[h,x]=freqz(double(Cn),double(Cd),100)



