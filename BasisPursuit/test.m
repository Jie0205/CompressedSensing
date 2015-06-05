
clear,
clc,
% ≥ı ºªØ
addpath('Optimization');
addpath('BasisSampling');
addpath('Images');

filename = 'lenna.pgm';
subrate = 0.3;


[t11, t1, img_psnr1] = l1eq_sbhe_block_Image_example(filename, subrate);
[t1, t, img_psnr] = l1eq_block_Image_example(filename, subrate);