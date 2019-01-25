function [] = quesmltwobpart2_2()

%please help!!!!!!!!!!
syms w;
syms n N;

p = heaviside(n) - heaviside(n - N);
j = sqrt(-1);
theta = ztrans(p);
thetaone = subs(theta,N,5);
%thetaonecross = subs(thetaone,z,j*w);
yozerosone = solve(thetaone);
yopoleone = poles(thetaone);

thetacross = ztrans(p,1i*w)

thetacrossone = subs(thetacross,N,5)

solve(thetacrossone)
%yozeroscrossone = solve(thetacrossone,w)
