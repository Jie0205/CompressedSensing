%%
clear,
clc,
% 初始化
addpath('Optimization');
addpath('BasisSampling');
addpath('Images');
subrate = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7];
t = zeros(1, 7);    psnr = zeros(1, 7);
%%

%%
% 分列采样恢复图像
filename = 'barbara.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_col_example(filename, a);
end
Mat1_barbara = [subrate; psnr; t];

filename = 'goldhill.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_col_example(filename, a);
end
Mat1_goldhill = [subrate; psnr; t];

filename = 'lenna.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_col_example(filename, a);
end
Mat1_lenna = [subrate; psnr; t];

filename = 'mandrill.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_col_example(filename, a);
end
Mat1_mandrill = [subrate; psnr; t];

filename = 'peppers.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_col_example(filename, a);
end
Mat1_peppers = [subrate; psnr; t];
%%



%%
% 分块采样恢复，分块大小为32*32
subrate = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7];
t = zeros(1, 7);    psnr = zeros(1, 7);

filename = 'barbara.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_block_Image_example(filename, a);
end
Mat_barbara = [subrate; psnr; t];

filename = 'goldhill.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_block_Image_example(filename, a);
end
Mat_goldhill = [subrate; psnr; t];

filename = 'lenna.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_block_Image_example(filename, a);
end
Mat_lenna = [subrate; psnr; t];

filename = 'mandrill.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_block_Image_example(filename, a);
end
Mat_mandrill = [subrate; psnr; t];

filename = 'peppers.pgm';
for i = 1:7
    a = subrate(i);
    [t(i), psnr(i)] = l1eq_block_Image_example(filename, a);
end
Mat_peppers = [subrate; psnr; t];
%%