c = 340;                    % Sound velocity (m/s)
fs = 96000;                 % Sample frequency (samples/s)
r = [3 3 3 ; 1 1 1 ;  5 4 6 ; 2 8 4 ; 4 6 9];    % Receiver positions [x_1 y_1 z_1 ; x_2 y_2 z_2] (m)
s = [3 5 6];              % Source position [x y z] (m)
L = [6 10 12];  %max distance 32.3              % Room dimensions [x y z] (m)
beta = [0.4 0.4 0.4 0.4 0.4 0.4];                 % Reverberation time (s)
n = 4096;                   % Number of samples
mtype = 'omnidirectional';  % Type of microphone
order = 1;                 % -1 equals maximum reflection order!
dim = 3;                    % Room dimension
orientation = 0;            % Microphone orientation (rad)
hp_filter = 1;              % Enable high-pass filter

h = rir_generator(c, fs, r, s, L, beta, n, mtype, order, dim, orientation, hp_filter);

h1 = h(1, :);
h2 = h(2, :);
h3 = h(3, :);
h4 = h(4, :);
h5 = h(5, :);

%[pks1,locs1] = findpeaks(h(1,4096));

%disp(locs1);

%plot(linspace(0,4096,4096),h);

%p = 

%prev = 0;
%data = [25 8 15 5 6 10 10 3 1 20 7];
%pks = findpeaks(data);

%pks1 = findpeaks(h1,fs);
%pks2 = findpeaks(h2,fs);
%pks3 = findpeaks(h3,fs);
%pks4 = findpeaks(h4,fs);
%pks5 = findpeaks(h5,fs);
[pks1,locs1] = findpeaks(h1);
[pks2,locs2] = findpeaks(h2);
[pks3,locs3] = findpeaks(h3);
[pks4,locs4] = findpeaks(h4);
[pks5,locs5] = findpeaks(h5);

[B1,I1] = sort(pks1,'descend');
[B2,I2] = sort(pks2,'descend');
[B3,I3] = sort(pks3,'descend');
[B4,I4] = sort(pks4,'descend');
[B5,I5] = sort(pks5,'descend');

K1 = I1(:,1:7);
K2 = I2(:,1:7);
K3 = I3(:,1:7);
K4 = I4(:,1:7);
K5 = I5(:,1:7);

K1 = c*K1*1/fs;
K2 = c*K2*1/fs;
K3 = c*K3*1/fs;
K4 = c*K4*1/fs;
K5 = c*K5*1/fs;


K1 = K1.*K1;
K2 = K2.*K2;
K3 = K3.*K3;
K4 = K4.*K4;
K5 = K5.*K5;

%  x = v(7:end);

D = pdist(r,'euclidean');  % euclidean distance
D_Matrix = squareform(D);

E = zeros(5,1);
Y = zeros(6,1);

%this is b{P,sstressasic

W = zeros(5,1);
Z = zeros(1,1);

%loop
for f1=1:7
E(1,1) = K1(1,f1);
    %loop
for f2=1:7
E(2,1) = K2(1,f2);
    %loop
for f3=1:7
E(3,1) = K3(1,f3);
    %loop
for f4=1:7
E(4,1) = K4(1,f4);
    %loop
for f5=1:7
E(5,1) = K5(1,f5);


W = horzcat(W,E);

C = horzcat(D_Matrix,E);
Zr = zeros(1,1);

T = horzcat((E)',Zr);
K = vertcat(C,T);

%[P,sstress] = mdscale(K,1);
%Z  =  horzcat(Z,sstress);

[P,sstress] = mdscale(K,3,'criterion','metricsstress');

Z = horzcat(Z,sstress);

Y = horzcat(Y,P);



%R = rank(K);

%disp(R);

%if R<=5
 % Y = vertcat(Y,E);
%end



%loop
end
%loop
end
%loop
end
%loop
end
%loop
end

%except first column of Y rest are candidates

W = W(:,2:end);
Z = Z(:,2:end);
Y = Y(:,2:end);

[B0,I0] = sort(Z,'descend');

IO = I0(:,1:7);

WAR = abs(sqrt(W(:,IO)));

R1 = zeros(1,3);

for u=1:7
result = interx([3 3 3],[1 1 1],[5 4 6],WAR(1,u),WAR(2,u),WAR(3,u),1);
R1 = vertcat(R1,(result)');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to calculate intersection of three spheres
% Returns NAN if no intersection or some bad condition encountered
% X1, X2, X3 are vectors of centers of three spheres
% r1, r2, r3 are radii of the three spheres
% pos =0 for lower point and 1 for higher point
% Computation Code calculated in (and copied from) Maple
% For questions/suggestions, contact hrishi.shah2002@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result=interx(X1,X2,X3,r1,r2,r3,pos)
if(nargin<7), pos=1; end % default value
x1=X1(1); y1=X1(2); z1=X1(3);
x2=X2(1); y2=X2(2); z2=X2(3);
x3=X3(1); y3=X3(2); z3=X3(3);
% convert in coord sys at [x1 y1 z1] oriented same as global
% x2=1; y2=1; z2=0.2; x3=2; y3=1; z3=1; r1=2.5; r2=2.6; r3=2.7; % TEST
x2=x2-x1; y2=y2-y1; z2=z2-z1;
x3=x3-x1; y3=y3-y1; z3=z3-z1;
a=(16*y2^2*z3*y3^2*z2*x3*r1^2*x2-4*y2^3*z3*y3*z2*x3*r1^2*x2+4*y2^3*z3*y3*z2*x3*x2*r3^2-4*y2*y3^3*z2*x2*z3*r1^2*x3+4*y2*y3^3*z2*x2*z3*r2^2*x3+16*z2*x3^2*x2^2*r1^2*y3*y2*z3-4*z2*x3^3*x2*r1^2*y3*y2*z3+4*z2*x3^3*x2*y2*z3*r2^2*y3-4*x2^3*z3*x3*y2*r1^2*z2*y3+4*x2^3*z3*x3*y2*r3^2*z2*y3-4*y2*z3*z2^3*y3*x3*r1^2*x2+4*y2*z3*z2^3*y3*x3*x2*r3^2+8*y2*z3^2*z2^2*y3*x2*r1^2*x3-4*y2*z3^2*z2^2*y3*x2*r2^2*x3+4*x2^2*y3^2*z2*y2^2*z3*x3^2-4*x2^4*z3^2*x3^2*y3*y2-2*z2^2*x3^4*x2^2*y2^2+2*z2^2*x3^3*y2^2*r1^2*x2-2*z2^2*x3^3*y2^2*x2*r3^2+2*z2^2*x3^5*x2*y2*y3+2*x2^5*z3^2*x3*y3*y2+2*z2^3*y3^2*y2^2*z3*x3^2+2*z2^3*y3^2*x2^2*z3*x3^2+2*z2^3*y3^2*x2^2*z3*r1^2-2*z2^3*y3^2*x2^2*z3*r3^2+2*x2^2*y3^4*z2*y2^2*z3-4*x2^2*y3^2*z2^2*x3^2*y2^2+2*x2^4*y3^2*z2*z3*x3^2-2*x2^2*y3^3*z2^2*y2*x3^2+2*x2^2*y3^3*z2^2*y2*z3^2+2*x2^3*y3^2*z2^2*x3*z3^2+2*x2^2*y3^2*z2*y2^2*z3^3+2*x2^2*y3^3*z2^2*y2*r1^2+2*x2^2*y3^2*z2^2*x3^2*r2^2+2*x2^4*y3^2*z2*z3*r1^2-2*x2^4*y3^2*z2*z3*r3^2-2*x2^2*y3^3*z2^2*y2*r3^2+2*x2^3*y3^2*z2^2*x3*r1^2-2*x2^3*y3^2*z2^2*x3*r3^2+2*y2^4*z3*x3^2*y3^2*z2+2*y2^2*z3*x3^4*z2*x2^2-4*y2^2*z3^2*x3^2*x2^2*y3^2+2*y2^3*z3^2*x3^2*z2^2*y3+2*y2^2*z3^2*x3^3*x2*z2^2-2*y2^3*z3^2*x3^2*x2^2*y3+2*y2^3*z3^2*x3^2*r1^2*y3+2*y2^2*z3*x3^4*z2*r1^2-2*y2^2*z3*x3^4*z2*r2^2+2*y2^2*z3^2*x3^2*x2^2*r3^2-2*y2^3*z3^2*x3^2*r2^2*y3+2*y2^2*z3^2*x3^3*x2*r1^2-2*y2^2*z3^2*x3^3*x2*r2^2-2*y2^2*z3^2*y3^2*x2^3*x3-4*y2^4*z3^2*y3^2*x2*x3+2*y2^2*z3^2*y3^2*x2^2*r3^2+4*y2^3*z3^2*y3*x2^3*x3+2*y2^5*z3^2*y3*x2*x3+4*y2*y3^3*z2^2*x3^3*x2+2*y2*y3^5*z2^2*x3*x2-2*y2^2*y3^2*z2^2*x3^3*x2-4*y2^2*y3^4*z2^2*x3*x2+2*y2^2*y3^2*z2^2*x3^2*r2^2-4*z2^2*x3^4*x2^2*y2*y3+2*z2*x3^2*x2^2*y2^2*z3^3+2*z2*x3^2*y2^4*z3*r1^2+2*z2^2*x3^2*y2^3*r1^2*y3-2*z2*x3^2*y2^4*z3*r3^2-2*z2^2*x3^2*y2^3*r3^2*y3-z2^4*y3^2*x3^2*x2^2-z2^4*y3^2*x3^2*y2^2+2*z2^3*y3^4*x2^2*z3+2*z2^3*y3^2*x2^2*z3^3+2*x2^2*y3^5*z2^2*y2-2*x2^2*y3^4*z2^2*y2^2-2*x2^4*y3^2*z2^2*x3^2+2*x2^3*y3^2*z2^2*x3^3+2*x2^4*y3^4*z2*z3+2*x2^3*y3^4*z2^2*x3+2*x2^2*y3^4*z2^2*r2^2-2*y2^4*z3^2*x3^2*y3^2+2*y2^5*z3^2*x3^2*y3+2*y2^4*z3*x3^4*z2+2*y2^2*z3^2*x3^3*x2^3-2*y2^2*z3^2*x3^4*x2^2+2*y2^4*z3^2*x3^3*x2+2*y2^2*z3*x3^4*z2^3-y2^2*z3^4*x3^2*x2^2+2*y2^4*z3^2*x3^2*r3^2-2*y2^2*z3^2*y3^4*x2^2+2*y2^3*z3^2*y3^3*x2^2-y2^2*z3^4*y3^2*x2^2-y2^4*z3^2*y3^2*x2^2+2*y2^3*y3^3*z2^2*x3^2-y2^2*y3^4*z2^2*x3^2-2*y2^4*y3^2*z2^2*x3^2-z2^4*y3^4*x2^2-2*x2^4*y3^4*z2^2-2*y2^4*z3^2*x3^4-y2^4*z3^4*x3^2-2*z2^2*x3^4*y2^4-z2^4*x3^4*y2^2-2*x2^4*z3^2*y3^4-x2^4*z3^4*y3^2-z3^2*y2^6*x3^2-x3^6*z2^2*y2^2-z3^2*x2^6*y3^2-2*y2^4*x3^4*y3^2+2*y2^4*x3^4*r3^2+2*y2^5*x3^4*y3-y2^4*x3^2*r1^4-y2^4*x3^2*y3^4+2*y2^5*x3^2*y3^3-y2^4*x3^2*r3^4-y2^6*x3^2*y3^2-y2^2*x3^4*r1^4-y2^2*x3^4*x2^4+2*y2^2*x3^5*x2^3-y2^2*x3^4*r2^4-y2^2*x3^6*x2^2-2*y2^4*x3^4*x2^2+2*y2^4*x3^4*r2^2+2*y2^4*x3^5*x2+2*x2^4*y3^5*y2-2*x2^4*y3^4*y2^2+2*x2^4*y3^4*r2^2-x2^2*y3^4*r1^4-x2^2*y3^6*y2^2+2*x2^2*y3^5*y2^3-x2^2*y3^4*y2^4-x2^2*y3^4*r2^4-x2^4*y3^2*r1^4-x2^6*y3^2*x3^2+2*x2^5*y3^2*x3^3-x2^4*y3^2*x3^4-x2^4*y3^2*r3^4+2*x2^5*y3^4*x3-2*x2^4*y3^4*x3^2+2*x2^4*y3^4*r3^2-y3^6*z2^2*x2^2-y2^4*x3^6-y2^6*x3^4-x2^6*y3^4-x2^4*y3^6-2*z2*x3^2*r1^2*y2^2*z3*r3^2-2*z2*y3^2*r2^2*x2^2*z3*r1^2+2*z2*y3^2*r2^2*x2^2*z3*r3^2+2*x2^4*y3^2*z2*z3^3+2*y2*r1^4*z2^2*y3*x3*x2+2*x2^2*y3^2*z2*y2^2*z3*r1^2-8*x2^2*y3^3*z2*r1^2*y2*z3-2*x2^2*y3^2*z2*y2^2*z3*r3^2-8*x2^3*y3^2*z2*z3*r1^2*x3+2*y2^2*z3*x3^2*r1^2*y3^2*z2-8*y2^3*z3*x3^2*r1^2*z2*y3-2*y2^2*z3*x3^2*z2*y3^2*r2^2-8*y2^2*z3*x3^3*z2*r1^2*x2-4*y2^2*z3^2*y3^2*x2*z2^2*x3-4*y2^2*z3^2*y3^2*x2*r1^2*x3+4*y2^2*z3^2*y3^2*x2*r2^2*x3-4*y2^3*z3*y3*z2*x3^3*x2-4*y2^3*z3*y3^3*z2*x3*x2-4*y2^3*z3^3*y3*z2*x3*x2+4*y2^3*z3^2*y3*x2*z2^2*x3-4*y2^3*z3^2*y3*x2*r2^2*x3-4*y2*y3^3*z2*x2^3*z3*x3+4*y2*y3^3*z2^2*x3*x2*z3^2-4*y2*y3^3*z2^3*x2*z3*x3-4*y2*y3^3*z2^2*x3*x2*r3^2-4*y2^2*y3^2*z2^2*x3*r1^2*x2+4*y2^2*y3^2*z2^2*x3*x2*r3^2-4*z2^2*x3^2*x2^2*y2*z3^2*y3+2*z2*x3^2*x2^2*y2^2*z3*r1^2-4*z2^2*x3^2*x2^2*y2*r1^2*y3-2*z2*x3^2*x2^2*y2^2*z3*r3^2+4*z2^2*x3^2*x2^2*y2*r3^2*y3-4*z2^3*x3^3*x2*y2*z3*y3+4*z2^2*x3^3*x2*y2*z3^2*y3-4*z2*x3^3*x2^3*y3*y2*z3-4*z2^2*x3^3*x2*y2*r3^2*y3+4*x2^3*z3^2*x3*y2*z2^2*y3-4*x2^3*z3^3*x3*y2*z2*y3-4*x2^3*z3^2*x3*y2*r2^2*y3+2*x2^2*z3*x3^2*r1^2*y3^2*z2-4*x2^2*z3^2*x3^2*r1^2*y3*y2-2*x2^2*z3*x3^2*z2*y3^2*r2^2+4*x2^2*z3^2*x3^2*y2*r2^2*y3-4*y2*z3^3*z2^3*y3*x3*x2+2*y2*z3^2*z2^4*y3*x2*x3+2*y2*z3^4*z2^2*y3*x3*x2-2*r1^2*y3^2*z2*x2^2*z3*r3^2-2*y2^2*z3*r1^2*z2*x3^2*r2^2+2*r1^4*y3*y2*z3^2*x2*x3+2*z2^2*x3^5*y2^2*x2+2*z2^2*x3^4*y2^3*y3+2*z2*x3^2*y2^4*z3^3+2*z2^2*x3^4*y2^2*r2^2-z2^2*x3^4*x2^2*y3^2+2*x2^5*z3^2*x3*y3^2-x2^4*z3^2*x3^2*y2^2-2*x2^4*z3^2*x3^2*y3^2+2*x2^4*z3^2*y3^3*y2+2*x2^4*z3^2*y3^2*r3^2-2*y2^2*x3^4*z2^2*y3^2-2*z2^2*x3^2*x2^2*y3^4-2*x2^2*z3^2*y2^4*x3^2-2*x2^4*y3^2*y2^2*z3^2+2*y2^2*z3^3*z2^3*x3^2-z3^2*y2^2*r1^4*x3^2-z3^2*y2^2*z2^4*x3^2-z3^2*y2^2*r2^4*x3^2-2*z3^2*y2^4*x3^2*z2^2+2*z3^2*y2^4*x3^2*r2^2-2*x3^4*z2^2*y2^2*z3^2+2*x3^4*z2^2*y2^2*r3^2-x3^2*z2^2*y2^2*r1^4-x3^2*z2^2*y2^2*z3^4-x3^2*z2^2*y2^2*r3^4-2*z3^2*x2^4*y3^2*z2^2+2*z3^2*x2^4*y3^2*r2^2-z3^2*x2^2*r1^4*y3^2-z3^2*x2^2*z2^4*y3^2-z3^2*x2^2*r2^4*y3^2+2*y2^3*x3^4*r1^2*y3-2*y2^3*x3^4*x2^2*y3-2*y2^3*x3^4*r2^2*y3+2*y2^4*x3^3*r1^2*x2-2*y2^4*x3^3*x2*y3^2-2*z2^2*x3^2*x2^2*y3^2*z3^2+2*z2^2*x3^2*x2^2*y3^2*r3^2-2*x2^2*z3^2*y2^2*x3^2*z2^2+2*x2^2*z3^2*y2^2*x3^2*r2^2+2*x2^2*y3^2*y2^2*z3^2*r2^2+2*y2^2*z3^3*z2*x3^2*r1^2-2*y2^2*z3^3*z2*x3^2*r2^2+2*z2^3*x3^2*y2^2*z3*r1^2-2*z2^3*x3^2*y2^2*z3*r3^2+2*x2^2*z3^3*r1^2*y3^2*z2-2*x2^2*z3^3*z2*y3^2*r2^2+2*r1^4*y3^2*z2*x2^2*z3+2*y2^2*z3*r1^4*z2*x3^2+2*x2^2*z3*y3^4*r1^2*z2+2*x2^2*z3^2*y3^3*r1^2*y2-2*x2^2*z3*y3^4*z2*r2^2-2*x2^2*z3^2*y3^3*y2*r2^2+2*x2^3*z3^2*y3^2*r1^2*x3-2*x2^3*z3^2*y3^2*r2^2*x3-2*y2^2*z3^2*z2^2*y3^2*x2^2-2*y2^2*x3^2*z2^2*y3^2*z3^2+2*y2^2*x3^2*z2^2*y3^2*r3^2-4*y2*z3^2*z2^2*y3*x3*x2*r3^2-4*y2*z3^3*z2*y3*x2*r1^2*x3+4*y2*z3^3*z2*y3*x2*r2^2*x3-4*r1^4*y3*y2*z3*z2*x3*x2-4*r1^2*y3*y2*z3^2*x2*r2^2*x3-4*y2*r1^2*z2^2*y3*x3*x2*r3^2+4*r1^2*y3*y2*z3*z2*x3*x2*r3^2+4*y2*r1^2*z2*y3*x2*z3*r2^2*x3+2*z2*x3^2*r2^2*y2^2*z3*r3^2+2*y2*z3^2*r2^4*y3*x2*x3+2*y2*r3^4*z2^2*y3*x3*x2+4*y2^2*x3*x2*y3^2*r1^2*r3^2+4*y2^2*x3*x2*y3^2*r1^2*r2^2-4*y2^2*x3*x2*y3^2*r3^2*r2^2+4*y2*x3^2*x2^2*y3*r1^2*r2^2+4*y2*x3^2*x2^2*y3*r1^2*r3^2-4*y2*x3^2*x2^2*y3*r2^2*r3^2-4*y2^3*x3*x2*y3*z3^2*r3^2-4*y2*x3*x2*y3^3*r1^2*r2^2-4*y2^3*x3*x2*y3*r1^2*r3^2-4*y2*x3*x2*y3^3*z2^2*r2^2-4*y2*x3*x2^3*y3*r1^2*r3^2-4*y2*x3^3*x2*y3*r1^2*r2^2-4*y2*x3^3*x2*y3*z2^2*r2^2-4*y2*x3*x2^3*y3*z3^2*r3^2-4*z3^2*y2^2*r1^2*x3^2*z2^2+2*z3^2*y2^2*r1^2*x3^2*r2^2+2*z3^2*y2^2*z2^2*x3^2*r2^2+2*x3^2*z2^2*y2^2*z3^2*r3^2+2*x3^2*z2^2*y2^2*r1^2*r3^2-4*z3^2*x2^2*r1^2*y3^2*z2^2+2*z3^2*x2^2*r1^2*y3^2*r2^2+2*z3^2*x2^2*z2^2*y3^2*r2^2-2*y2^3*x3^2*r1^2*y3*r3^2-2*y2^3*x3^2*x2^2*y3*r1^2+2*y2^3*x3^2*x2^2*y3*r3^2-2*y2^3*x3^2*r1^2*r2^2*y3+2*y2^3*x3^2*r3^2*r2^2*y3-2*y2^2*x3^3*r1^2*x2*r2^2-2*y2^2*x3^3*r1^2*x2*y3^2-2*y2^2*x3^3*r1^2*x2*r3^2+2*y2^2*x3^3*r2^2*x2*y3^2+2*y2^2*x3^3*r2^2*x2*r3^2+2*y2^2*x3^2*r1^2*y3^2*r2^2+4*y2^2*x3^2*x2^2*y3^2*r2^2+2*y2^2*x3^2*r1^2*x2^2*r3^2+4*y2^2*x3^2*x2^2*y3^2*r3^2-8*y2^3*x3^3*r1^2*x2*y3-2*x2^2*y3^3*r1^2*y2*x3^2-2*x2^2*y3^3*r1^2*y2*r3^2-2*x2^2*y3^3*y2*r1^2*r2^2+2*x2^2*y3^3*y2*x3^2*r2^2+2*x2^2*y3^3*y2*r3^2*r2^2-2*x2^3*y3^2*r1^2*y2^2*x3-2*x2^3*y3^2*r1^2*r2^2*x3-2*x2^3*y3^2*r1^2*x3*r3^2+2*x2^3*y3^2*y2^2*x3*r3^2+2*x2^3*y3^2*r2^2*x3*r3^2+2*x2^2*y3^2*y2^2*r1^2*r3^2-4*y2*z3*r2^2*y3*z2*x3*x2*r3^2-4*x2^4*y3^2*r1^2*x3^2+2*x2^4*y3^2*r1^2*r3^2+2*x2^3*y3^2*r1^2*x3^3+2*x2^4*y3^2*x3^2*r2^2-2*x2^5*y3^2*x3*r3^2-2*x2^3*y3^2*r2^2*x3^3+2*x2^4*y3^2*x3^2*r3^2-y3^2*z2^2*r1^4*x2^2-y3^2*z2^2*x2^2*z3^4-y3^2*z2^2*x2^2*r3^4-2*y3^4*z2^2*x2^2*z3^2+2*y3^4*z2^2*x2^2*r3^2+4*y2^3*x3*x2^3*y3^3+4*y2^3*x3^3*x2*y3^3+2*y2*x3*x2^5*y3^3+2*y2^3*x3^5*x2*y3+2*y2^3*x3*x2*y3^5-4*y2^4*x3*x2*y3^4+2*y2^5*x3*x2*y3^3+2*y2*x3^3*x2^5*y3-4*y2*x3^4*x2^4*y3+2*y2^5*x3^3*x2*y3+2*y2*x3^5*x2^3*y3+2*y2*x3*x2^3*y3^5+4*y2^3*x3^3*x2^3*y3+4*y2*x3^3*x2^3*y3^3-2*y2^4*x3^3*x2*r3^2-2*y2^5*x3^2*r3^2*y3+2*y2^4*x3^2*y3^2*r2^2+2*y2^3*x3^2*r1^2*y3^3+2*y2^3*x3^2*r1^4*y3-4*y2^4*x3^2*r1^2*y3^2-3*y2^4*x3^2*x2^2*y3^2+2*y2^4*x3^2*r1^2*r3^2+2*y2^5*x3^2*r1^2*y3+2*y2^4*x3^2*y3^2*r3^2-2*y2^3*x3^2*y3^3*r2^2-y2^2*x3^2*r1^4*y3^2-3*y2^2*x3^2*x2^4*y3^2-y2^2*x3^2*r2^4*y3^2-y2^2*x3^2*r1^4*x2^2-3*y2^2*x3^2*x2^2*y3^4-y2^2*x3^2*x2^2*r3^4+2*y2^2*x3^3*r1^4*x2+2*y2^2*x3^3*r1^2*x2^3-4*y2^2*x3^4*r1^2*x2^2+2*y2^2*x3^4*r1^2*r2^2+2*y2^2*x3^5*r1^2*x2+2*y2^2*x3^4*x2^2*r2^2-2*y2^2*x3^3*x2^3*r3^2-2*y2^2*x3^5*r2^2*x2-3*y2^2*x3^4*x2^2*y3^2+2*y2^2*x3^4*x2^2*r3^2+2*x2^4*y3^3*y2*r1^2-2*x2^4*y3^3*y2*x3^2-2*x2^4*y3^3*y2*r3^2+2*x2^3*y3^4*r1^2*x3-2*x2^3*y3^4*y2^2*x3-2*x2^3*y3^4*r2^2*x3-2*x2^2*y3^3*y2^3*r3^2+2*x2^2*y3^4*y2^2*r2^2+2*x2^2*y3^5*r1^2*y2+2*x2^2*y3^3*r1^4*y2-4*x2^2*y3^4*r1^2*y2^2+2*x2^2*y3^4*r1^2*r2^2+2*x2^2*y3^3*y2^3*r1^2+2*x2^2*y3^4*y2^2*r3^2-2*x2^2*y3^5*y2*r2^2-x2^2*y3^2*y2^2*r1^4-x2^2*y3^2*y2^2*r3^4-x2^2*y3^2*r1^4*x3^2-x2^2*y3^2*r2^4*x3^2+2*x2^3*y3^2*r1^4*x3+2*x2^5*y3^2*r1^2*x3+2*x2^2*y3^2*r1^2*x3^2*r2^2-8*x2^3*y3^3*r1^2*y2*x3+2*y3^2*z2^2*r1^2*x2^2*r3^2+2*y3^2*z2^2*x2^2*z3^2*r3^2+4*y2^4*x3*x2*y3^2*r3^2+4*y2^3*x3*x2*y3^3*z2^2-4*y2^3*x3*x2*y3^3*r2^2-4*y2^2*x3*x2*y3^4*r1^2-4*y2^2*x3*x2*y3^2*r1^4+8*y2^3*x3*x2*y3^3*r1^2+4*y2*x3*x2^3*y3^3*z2^2-4*y2*x3*x2^3*y3^3*r2^2-4*y2^4*x3*x2*y3^2*r1^2+4*y2^3*x3^3*x2*y3*z3^2-4*y2^3*x3^3*x2*y3*r3^2+4*y2^3*x3*x2*y3^3*z3^2-4*y2^3*x3*x2*y3^3*r3^2+4*y2^2*x3*x2*y3^4*r2^2+2*y2*x3*x2*y3^3*r1^4+2*y2^3*x3*x2*y3*r1^4+2*y2^3*x3*x2*y3*z3^4+2*y2^3*x3*x2*y3*r3^4+2*y2*x3*x2*y3^3*z2^4+2*y2*x3*x2*y3^3*r2^4+2*y2*x3*x2^3*y3*r1^4+2*y2*x3^3*x2*y3*r1^4+2*y2*x3^3*x2*y3*z2^4+2*y2*x3^3*x2*y3*r2^4+2*y2*x3*x2^3*y3*z3^4+2*y2*x3*x2^3*y3*r3^4-4*y2*x3^2*x2^2*y3*r1^4-4*y2*x3^2*x2^4*y3*r1^2+8*y2*x3^3*x2^3*y3*r1^2-4*y2*x3^4*x2^2*y3*r1^2+4*y2*x3^3*x2^3*y3*z2^2-4*y2*x3^3*x2^3*y3*r2^2+4*y2*x3^2*x2^4*y3*r3^2+4*y2^3*x3^3*x2*y3*z2^2-4*y2^3*x3^3*x2*y3*r2^2+4*y2*x3^4*x2^2*y3*r2^2+4*y2*x3^3*x2^3*y3*z3^2-4*y2*x3^3*x2^3*y3*r3^2+4*y2*x3*x2^3*y3^3*z3^2-4*y2*x3*x2^3*y3^3*r3^2+16*y2^2*x3^2*x2^2*y3^2*r1^2);
b=(-z2^3*y3^2-x2^2*y3^2*z2-y2^2*z3*x3^2-y2^2*z3*y3^2+y2^3*z3*y3+y2*y3^3*z2-y2^2*y3^2*z2-z2*x3^2*x2^2-z2*x3^2*y2^2+z2*x3^3*x2+x2^3*z3*x3-x2^2*z3*x3^2-x2^2*z3*y3^2+y2*z3*z2^2*y3+y2*x3^2*z2*y3+y2*z3^2*z2*y3+z2*x3*x2*y3^2+z2*x3*x2*z3^2+x2*z3*y2^2*x3+x2*z3*z2^2*x3+x2^2*y3*y2*z3-y2^2*z3^3-z2^3*x3^2-x2^2*z3^3-r1^2*y3^2*z2-y2^2*z3*r1^2+r1^2*y3*y2*z3+y2*r1^2*z2*y3+z2*y3^2*r2^2-z2*x3^2*r1^2+z2*x3^2*r2^2-x2^2*z3*r1^2+x2^2*z3*r3^2+y2^2*z3*r3^2-y2*z3*r2^2*y3-y2*r3^2*z2*y3+z2*x3*r1^2*x2-z2*x3*x2*r3^2+x2*z3*r1^2*x3-x2*z3*r2^2*x3);
c=(-2*y2*z3*z2*y3-2*z2*x3*x2*z3+z3^2*y2^2+x3^2*z2^2+z3^2*x2^2+y2^2*x3^2+x2^2*y3^2+y3^2*z2^2-2*y2*x3*x2*y3);
if(a<0||c==0), result=[nan;nan;nan]; return; end % coz c is the denominator and a is under a root
%     error('Error in interx.m at z'); end
za=-1/2*(b-a^(1/2))/c;
zb=-1/2*(b+a^(1/2))/c;
if(za>zb)
    if(pos), z=za; else z=zb; end
else
    if(pos), z=zb; else z=za; end
end
a=(2*z*z2*x3-2*x2*z*z3+r1^2*x2-r1^2*x3-x2^2*x3-y2^2*x3-z2^2*x3+r2^2*x3+x2*x3^2+x2*y3^2+x2*z3^2-x2*r3^2);
b=(-2*y2*x3+2*x2*y3);
if(b==0), result=[nan;nan;nan]; return; end % coz b is the denominator in the expression
%     error('Error in interx.m at y'); end
y=a/b;
if(x2==0), result=[nan;nan;nan]; return; end
%     error('Error in interx.m at x'); end
x = 1/2*(r1^2+x2^2-2*y*y2+y2^2-2*z*z2+z2^2-r2^2)/x2;
%% convert result back to global
result=[x1;y1;z1;1]+[x;y;z;0];
% disp([x1 y1 z1 x2+x1 y2+y1 z2+z1 x3+x1 y3+y1 z3+z1]);
disp('Solution'); disp(result');
disp('Constraints'); % check distances to three centers
disp((result(1)-X1(1))^2+(result(2)-X1(2))^2+(result(3)-X1(3))^2-r1^2);
disp((result(1)-X2(1))^2+(result(2)-X2(2))^2+(result(3)-X2(3))^2-r2^2);
disp((result(1)-X3(1))^2+(result(2)-X3(2))^2+(result(3)-X3(3))^2-r3^2);

end



