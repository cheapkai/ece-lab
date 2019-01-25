function [] = quesmltwobpart1()
%please help me
syms n N;
syms w;
p = heaviside(n) - heaviside(n - N);
j = sqrt(-1);
l = p*exp(-j*w*n);
%s1 = symsum(l,n,-1*Inf,Inf);
%Nt = [5,10,15];
%dtft =  subs(s1,N,Nt)

%syms dtft;
dtft = 0;
for q= 1:1:3
dtft = 0;
for v= 0:1:20
y = 10 - v;
%dtft=simplify(plus(dtft,exp(-j*w*y)*(heaviside(y) - heaviside(y - q*5))));
%dtft = simplify(dtft + exp(-j*w*y)*(heaviside(y) - heaviside(y - q*5)));
dtft = simplify(symsum(dtft + exp(-j*w*y)*(heaviside(y) - heaviside(y - q*5))));
end
disp(dtft);
end





%disp(dtft);
%disp();



























