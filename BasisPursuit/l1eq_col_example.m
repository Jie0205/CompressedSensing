function [t, img_psnr] = l1eq_col_example(filename, subrate)

n = 512;
original_img = double(imread(filename));
num_trials = 1; % the number of the processing to the image

% building the DCT basis
Psi = dct_basis(n);
img_psnr = zeros(num_trials, 1);
t = zeros(num_trials, 1);
for trial = 1: num_trials
     % form the observation matrix
     projection_matrix_file = ['projections.' num2str(trial) '.mat'];
     Phi = GenerateProjection(n, subrate, projection_matrix_file);

     % projection
     y = Phi * original_img;
     
     tic
    %-------- recover using Basis Pursuit ------------
    sparse_rec=zeros(n, n);            
    Theta = Phi * Psi;
    A = Theta;
    Afun = @(z) A*z;
    Atfun = @(z) A'*z;
    for i=1:n
        b = y(:, i);
        x0 = Theta' * b;
        Sest = l1eq_pd(x0, Afun, Atfun, b, 1e-3, 30, 1e-8, 200);
        sparse_rec(:,i) = Sest;          % sparse representation
    end
    img_rec_1d=Psi * sparse_rec;      % inverse transform
    img_psnr(trial) = PSNR(original_img, img_rec_1d);
    t(trial) = toc;
    
end

img_psnr = mean(img_psnr);
t = mean(t);

rec_img = img_rec_1d;
subplot(1,2,1),imshow(uint8(original_img)),title('original image');
subplot(1,2,2),imshow(uint8(rec_img)),title('reconstructed image');