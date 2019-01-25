U1 = rand(1,500);

f1 = erfinv(2*U1 - 1);

N1 = sqrt(2)*sqrt(12)*f1 + 1 ;









 U2 = rand(1,500);
 f2 = erfinv(2*U2 - 1);
 N2 = sqrt(2)*sqrt(14)*f2 + 1;

 
 
U3 = rand(1,500);
f3 = erfinv(2*U3 - 1);
N3 = sqrt(2)*sqrt(5)*f3 + 5;

U4 = rand(1,500);
f4 = erfinv(2*U4 - 1);
N4 = sqrt(2)*sqrt(6)*f4 + 5;




X1 = vertcat(N1,N2,ones(1,500));
%X2 = vertcat(N3,N4,-1*ones(1,500));
X2 = vertcat(N3,N4,zeros(1,500));

P1 = X1(1,:);
P2 = X2(1,:);
P3 = X1(2,:);
P4 = X2(2,:);

%plot(P1,P3,'ro',P2,P4,'bo');

%hold on
X = horzcat(X1,X2);

output = rand(1,1000);

X = X';

A = X;
X = A(:,1:2);
Y = A(:,3);
m = size(X,1);
X = [ones(size(X,1),1) X];

theta = [1;1;1];

lambda = 0;

eta = 0.01;




for i=1:2000

    g = exp(-1*X*theta);
    h = rand(m,1);
    for j=1:m
       h = 1/(1 + g(j,1));  
    end
    % h = 1/(1 + (g));
     
    %h = 1/(1 + exp(-1*g));
    C = X'*(h - Y);
    theta_temp = theta - theta(1,1)*[1;0;0]'; 
C = C + lambda*2*[1 1 1]*theta_temp*ones(size(C,1),1);

    theta = theta -eta*(1/m)*C;
    
    %theta = theta - eta*(1/m)*(C + lambda*2*([1 1 1]*theta_temp));    
    
end


theta1 = theta;


% X = X';
% 
% A = X;
% X = A(:,1:2);
% Y = A(:,3);
% m = size(X,1);
% X = [ones(size(X,1),1) X];
% 
theta = [1;1;1];

lambda = 10;

eta = 0.01;




for i=1:2000

    g = exp(-1*X*theta);
    h = rand(m,1);
    for j=1:m
       h = 1/(1 + g(j,1));  
    end
    % h = 1/(1 + (g));
     
    %h = 1/(1 + exp(-1*g));
    C = X'*(h - Y);
    theta_temp = theta - theta(1,1)*[1;0;0]'; 
C = C + lambda*2*[1 1 1]*theta_temp*ones(size(C,1),1);

    theta = theta -eta*(1/m)*C;
    
    %theta = theta - eta*(1/m)*(C + lambda*2*([1 1 1]*theta_temp));    
    
end

% 

theta2 =theta;

In1 = linspace(-10,10,500)';
In2 = linspace(-10,10,500)';
[In1,In2] = meshgrid(In1,In2);
%Z = peaks(In1,In2);
%v = [1,1];
%Z = horzcat(ones(500,1),In1,In2)*theta;
%*J = [ones(size(In1,1),1) In1 In2];
% %Z = J*theta;
% Z1 = theta1(1,1) + theta1(2,1)*In1 + theta1(3,1)*In2;
% Z2 = theta2(1,1) + theta2(2,1)*In1 + theta2(3,1)*In2;
% v = [1,0];
% figure
% contour(In1,In2,Z1,v,'ShowText','on');
% hold on
% contour(In1,In2,Z2,v,'ShowText','on');
% hold on
% 
% plot(P1,P3,'ro',P2,P4,'bo');
% hold on


Wa = -0.5*inv([12 0;0 14]);
wa = inv([12 0;0 14])*[1 1]';
w1 = -0.5*[1 1]*inv([12 0;0 14])*[1 1]' + -0.5*log(det([12 0;0 14])) + log(0.5);

Wb = -0.5*inv([5 0;0 6]);
wb = inv([5 0;0 6])*[5 5]';
w2 = -0.5*[5 5]*inv([5 0;0 6])*[5 5]' + -0.5*log(det([5 0;0 6])) + log(0.5);
% 
W = Wa-Wb;
w = wa'-wb';
wr = w1 - w2;

% In1 = linspace(-10,10,500)';
% In2 = linspace(-10,10,500)';
% [In1,In2] = meshgrid(In1,In2);
% %Z = peaks(In1,In2);
%v = [1,1];
%Z = horzcat(ones(500,1),In1,In2)*theta;
%*J = [ones(size(In1,1),1) In1 In2];
%Z = J*theta;
%Z = theta(1,1) + theta(2,1)*In1 + theta(3,1)*In2;
% 
% Z3 = W(1,1)*In1*In1 + W(2,2)*In2*In2 + w(1,1)*In1 + w(1,2)*In2 + wr;
% 
% v = [1,0];
% figure
% contour(In1,In2,Z3,v,'ShowText','on');
% hold on
% plot(P1,P3,'ro',P2,P4,'bo');
% hold on



% 
% for i=1:1000
% 
%     x = X(1:2,i);
%     
%     g1 = x'*Wa*x + wa'*x + w1;
%     
%     g2 = x'*Wb*x + wb'*x + w2;
%     
%     if g1>=g2
%         
%         output(i) = 1;
%         
%     else
%         output(i) = -1;
%         
%     end
%     
% end
% 
% error = (1/2)*sum((abs(X(3,:) - output)),2);


V1 = rand(1,500);

t1 = erfinv(2*U1 - 1);

M1 = sqrt(2)*sqrt(12)*f1 + 1 ;









 V2 = rand(1,500);
 t2 = erfinv(2*U2 - 1);
 M2 = sqrt(2)*sqrt(14)*f2 + 1;

 
 
V3 = rand(1,500);
t3 = erfinv(2*U3 - 1);
M3 = sqrt(2)*sqrt(5)*f3 + 5;

V4 = rand(1,500);
t4 = erfinv(2*U4 - 1);
M4 = sqrt(2)*sqrt(6)*f4 + 5;



B1 = [ones(500,1) (M1)' (M2)']; 
B2 = [ones(500,1) (M3)' (M4)'];

B = vertcat(B1,B2);
BP = rand(2,1);
BN = rand(2,1);
LRP = rand(2,1);
LRN = rand(2,1);
LWP = rand(2,1);
LWN = rand(2,1);


k = size(B,1);


      
                            
              
for  a=1:k

if ( W(1,1)*B(a,2)*B(a,2) + W(2,2)*B(a,3)*B(a,3) + w(1,1)*B(a,2) + w(1,2)*B(a,3) + wr)>=0
BP = [BP [B(a,2); B(a,3)]];

else
    
    BN = [BN [B(a,2); B(a,3)]];
   
    
end

if theta1(1,1) + theta1(2,1)*B(a,2) + theta1(3,1)*B(a,3) >=0
LRP = [LRP [B(a,2);B(a,3)]];

else
    LRN = [LRN [B(a,2);B(a,3)]];
end

if theta2(1,1) + theta2(2,1)*B(a,2) + theta2(3,1)*B(a,3) >=0
LWP = [LWP [B(a,2);B(a,3)]];

else
    LWN = [LWN [B(a,2);B(a,3)]];
end





end

plot(BP(1,:),BP(2,:),'r+',BN(1,:),BN(2,:),'b+',LRP(1,:),LRP(2,:),'ro',LRN(1,:),LRN(2,:),'bo',LWP(1,:),LWP(2,:),'gt',LWN(1,:),LWN(2,:),'gk');






