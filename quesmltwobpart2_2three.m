function [] = quesmltwobpart2_2three()

%please help!!!!!!!!!!
syms w;
syms n N;

p = heaviside(n) - heaviside(n - N);
j = sqrt(-1);
theta = ztrans(p);
thetathree = subs(theta,N,15);
%thetaonecross = subs(thetaone,z,j*w);
yozerosthree = solve(thetathree);
yopolethree = poles(thetathree);

thetacross = ztrans(p,1i*w)

thetacrossthree = subs(thetacross,N,15)

solve(thetacrossthree)
%yozeroscrossone = solve(thetacrossone,w)
