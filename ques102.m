X = [1 15;3 35;9 95;200 2005];

Cov = X*X';

%rank(Cov)

kernel = X'*X;

disp(rank(kernel));
disp(rank(Cov));
