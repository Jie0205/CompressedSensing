function [t, img_psnr] = l1eq_block_Image_example(filename, subrate)

original_img = double(imread(filename));
% Block size 
B = 32;
% Image size
[m, n] = size(original_img);
% Subrate rate

% Samples
num_trials = 1; % the number of the processing to the image

N = B* B;
K = ceil(N * subrate);
% measurement matrix
disp('Creating measurment matrix...');
Phi = randn(K, N);
Phi = orth(Phi')';
disp('Done.');
% dct_basis
Psi = DCT2D_Matrix(B);
% Compressed matrix and compressed function handler
Theta = Phi * Psi;
A = Theta;
Afun = @(z) A*z;
Atfun = @(z) A'*z;

I_block = mat2cell(original_img, B*ones(1, n/B), B*ones(1, n/B));
Rec_I_block = cell(n/B, n/B);

img_psnr = zeros(num_trials, 1);
t = zeros(num_trials, 1);

for trial = 1: num_trials
    tic,
    for ii = 1:n/B
        for jj = 1:n/B
            I = double(I_block{ii, jj});
            x = reshape(I,N,1);

            % observations
            b = Phi*x;

            x0 = Theta'*b;
            Sest =  l1eq_pd(x0, Afun, Atfun, b, 1e-3, 30, 1e-8, 200);
            xp = Psi * Sest;
            Ip = reshape(xp, B, B);

            Rec_I_block{ii, jj} = Ip;
            fprintf('ii = %d, jj = %d\n===============\n', ii, jj);
        end
    end

    Rec_I = cell2mat(Rec_I_block);
    t(trial) = toc;
    img_psnr(trial) = PSNR(double(original_img), double(Rec_I));
end

img_psnr = mean(img_psnr);
t = mean(t);

rec_img = Rec_I;
subplot(1,2,1),imshow(uint8(original_img)),title('original image');
subplot(1,2,2),imshow(uint8(rec_img)),title('reconstructed image');