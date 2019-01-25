function [] = laplace()

syms s;syms w;
syms t;
lapt =int(exp(-1*s*t),t,0,1);

j = sqrt(-1);
fout =subs(lapt,s,j*w);

ww = linspace(1,100,100);

fft = subs(fout,w,ww);


plot3(real(fft),imag(fft),ww);


