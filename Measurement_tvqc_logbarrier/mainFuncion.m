clc,
clear,

path(path, './Optimization');
path(path, './Images');
path(path, './SensingMatrix');

filename = 'Vessels.tif';
original_img = imread(filename);
subrate = 0.3;


% [t3, psnr3, rec_img3] = tveq_cols_example(original_img, subrate);
[t4, psnr4, rec_img4] = tveq_block_example(original_img, subrate);

% lastData = [t3, psnr3; t4, psnr4];
% xlswrite('lastData.xls', lastData);