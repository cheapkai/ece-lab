c = 340;                    % Sound velocity (m/s)
fs = 16000;                 % Sample frequency (samples/s)
r1 = [2 2 2];              % Receiver position [x y z] (m)
r2 = [-2 2 2];
r3 = [2 -2 2];
r4 = [2 2 -2];
r5 = [-2 -2 -2];

s = [0 0 0];              % Source position [x y z] (m)
L = [5 4 6];                % Room dimensions [x y z] (m)

%we will run for 60s

n1 = randi([2,30],1,1);  % Number of samples
n2 = randi([2,30],1,1);
n3 = randi([2,30],1,1);
n4 = randi([2,30],1,1);
n5 = randi([2,30],1,1);




beta = 0.4;                 % Reverberation time (s)
mtype = 'hypercardioid';    % Type of microphone
order = 1;                 % -1 equals maximum reflection order!
dim = 3;                    % Room dimension
orientation = [pi/2 0];     % Microphone orientation (rad)
hp_filter = 0;              % Disable high-pass filter

h1 = rir_generator(c, fs, r1, s, L, beta, n1, mtype, order, dim, orientation, hp_filter);


h2 = rir_generator(c, fs, r2, s, L, beta, n2, mtype, order, dim, orientation, hp_filter);

h3 = rir_generator(c, fs, r3, s, L, beta, n3, mtype, order, dim, orientation, hp_filter);

h4 = rir_generator(c, fs, r4, s, L, beta, n4, mtype, order, dim, orientation, hp_filter);

h5 = rir_generator(c, fs, r5, s, L, beta, n5, mtype, order, dim, orientation, hp_filter);

%disp(length(h1));disp(length(h2));disp(length(h3));disp(length(h4));disp(length(h5));






%Compute the ordinary Euclidean distance

X =  [2,2,2;-2,2,2;2,-2,2;2,2,-2;-2,-2,-2];

D = pdist(X,'euclidean');  % euclidean distance
D_Matrix = squareform(D);

%D_Matrix

H1 = h1*c;
H2 = h2*c;
H3 = h3*c;
H4 = h4*c;
H5 = h5*c;

l1 = length(H1);
l2 = length(H2);
l3 = length(H3);
l4 = length(H4);
l5 = length(H5);



%loop 
%loop
%loop
%loop
%loop

Y = zeros(5,1);


C = horzcat(D_Matrix,E);
Zr = zeros(1);

T = horzcat(E,Zr);
K = vertcat(C,T);

R = rank(K);

if R<=5
  Y = vertcat(Y,K);
end



%loop
%loop
%loop
%loop
%loop

[w,d] = size(Y);















