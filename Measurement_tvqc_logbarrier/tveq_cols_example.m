% tvqc_example.m
%
% Test out tvqc code (TV minimization with quadratic constraint).
%
% Written by: Justin Romberg, Caltech
% Email: jrom@acm.caltech.edu
% Created: October 2005
%
% 
% path(path, './Optimization');
% path(path, './Images');
% 
% filename = 'Vessels.tif';
function [t, psnr, rec_img] = tveq_cols_example(original_img, subrate)

I0 = double(original_img);
[m, n] = size(I0);

N = m*n;
K = floor(subrate*N);
% measurement matrix  
disp('Creating measurment matrix...');  
mMatrix = 'measurementMatrix.mat';
if(exist(mMatrix, 'file'))
    load(mMatrix);
else
    A = randn(K, N);  
    A = orth(A')'; 
    save(mMatrix, 'A');
end
disp('Done.');  

Afun = @(z) A*z;
Atfun = @(z) A'*z;

x = reshape(I0, N, 1);
% observations
b = Afun(x);
% initial point
x0 = Atfun(b);

tic;
xp =  tveq_logbarrier(x0, Afun, Atfun, b,1e-3, 5, 1e-8, 200);
t  = toc;
Ip = reshape(xp, m, n);
rec_img = Ip;

psnr = PSNR(double(original_img), double(rec_img));
end
