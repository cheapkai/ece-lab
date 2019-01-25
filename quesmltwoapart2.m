function [] = laplace2()

syms t s;
unit1 = heaviside(t);
unit2 = heaviside(t-1);

x = unit1;


lapt = laplace(x);
lapt2 = exp(-s)*lapt;

laptr = lapt-lapt2;
%disp(lapt);
%disp(laptr);

yothezeroes = solve(laptr);
yothepoles = poles(laptr);
disp(yothepoles);




pzmap([],[double(real(yothezeroes));double(imag(yothezeroes))]);

%lapt = laplace(x);
