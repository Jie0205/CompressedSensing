
path(path, './Optimization');
path(path, './Images');
path(path, './SensingMatrix');

filename = 'Vessels.tif';
original_img = imread(filename);
subrate = 0.3;

I0 = double(original_img);
[m, n] = size(I0);

N = m*n;
K = floor(subrate*N);
% measurement matrix  
disp('Creating measurment matrix...');  
mMatrix = 'sbheMatrix.mat';
if(exist(mMatrix, 'file'))
    load(mMatrix);
else
    A = gen_rand_matrix('sbhe',N,K);
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
% function [t, psnr, rec_img] = tveq_cols_example(original_img, subrate)
%  
% X = double(original_img);
% [m, n] = size(X);
% x = X(:);
% 
% % number of radial lines in the Fourier domain
% L = 37;
% % Fourier samples we are given
% [M,Mh,mh,mhi] = LineMask(L,n);
% OMEGA = mhi;
% A = @(z) A_fhp(z, OMEGA);
% At = @(z) At_fhp(z, OMEGA, n);
% 
% % measurements
% % 采样的点数等于，size(OMEGA, 1)*2 + 1
% y = A(x);
% 
% % min l2 reconstruction (backprojection)
% xbp = At(y);
% Xbp = reshape(xbp,n,n);
% 
% % recovery
% tic
% tvI = sum(sum(sqrt([diff(X,1,2) zeros(n,1)].^2 + [diff(X,1,1); zeros(1,n)].^2 )));
% disp(sprintf('Original TV = %8.3f', tvI));
% xp = tveq_logbarrier(xbp, A, At, y, 1e-1, 2, 1e-8, 600);
% Xtv = reshape(xp, n, n);
% t = toc;
% rec_img = Xtv;
% psnr = PSNR(double(original_img), double(Xtv));
