% tveq_example.m
%
% Test out tveq code (TV minimization with equality constraints).
%
% Written by: Justin Romberg, Caltech
% Email: jrom@acm.caltech.edu
% Created: October 2005
%

path(path, './Optimization');

filename = 'lenna_256x256.pgm';
subrate = 0.2;
block_size = 32;
original_img = imread(filename);
% original_img = rgb2gray(original_img);
I = double(original_img);
[num_rows, num_cols] = size(I);

% generate the sampling matrix based on block
N = block_size*block_size;
M = floor(subrate*N);
Phi = orth(randn(N, N))';

Phi = Phi(1:M, :);

% matrix to vector
x = I(:);

% sample and sample_transpose function handles
A = @(x) sample(x, Phi, num_rows, num_cols, block_size);
At = @(y) sample_transpose(y, Phi, num_rows, num_cols, block_size);

% sampling
y = A(x);

% initialize x
x0 = At(y);
epsilon = 5e-3;
% reconstruction
xp = tvqc_logbarrier(x0, A, At, y, epsilon, 1e-3, 5, 1e-8, 200);
x1 = reshape(xp, [num_rows num_cols]);
