% l1eq_example.m
%
% Test out l1eq code (l1 minimization with equality constraints).
%
% Written by: Justin Romberg, Caltech
% Email: jrom@acm.caltech.edu
% Created: October 2005
%

% put key subdirectories in path if not already there
path(path, './Optimization');

% signal length
N = 200;
% number of spikes in the signal
T = 10;
% number of observations to make
K = 50;

% % random +/- 1 signal
% x = zeros(N,1);
% q = randperm(N);
% x(q(1:T)) = sign(randn(T,1));

% random from 0 to 256
x = zeros(N,1);
for i = 1:T
    x(10*i) = rand(1)*256;
end


% measurement matrix
disp('Creating measurment matrix...');
A = randn(K,N);
A = orth(A')';
disp('Done.');
	
% observations
y = A*x;

% initial guess = min energy
x0 = A'*y;

% % solve the LP
% tic
% xp = l1eq_pd(x0, A, [], y, 1e-3);
% toc

% large scale
Afun = @(z) A*z;
Atfun = @(z) A'*z;
tic
xp = l1eq_pd(x0, Afun, Atfun, y, 1e-3, 30, 1e-8, 200);
toc

% figure 
plot((1:N), x, 'gO');
hold on;
plot((1:N), xp, 'r+');


