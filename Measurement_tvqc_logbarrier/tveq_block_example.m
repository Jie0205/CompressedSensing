function [t, psnr, rec_img] = tveq_block_example(original_img, subrate)
% block cs-tv for images reconstruction
% Input
% I0: original image (required to have same height and width)
% n: size of the image [n n]
% MR: meeasurement rate
% B: block size
% 
% Output
% Rec_I: reconstructed image
% PSNR: psnr using double

I0 = double(original_img);
[m, n] = size(I0);

if m == 112
    B = 28;
elseif m == 512
    B = 32;
end

N = B*B;
K = floor(N * subrate);
% measurement matrix  
mMatrix = 'sbheMatrix.28.mat';
disp('Creating measurment matrix...');  
if(exist(mMatrix, 'file'))
    load(mMatrix);
else
    A = gen_rand_matrix('sbhe',N,K);
    save(mMatrix, 'A');
end
disp('Done.');  
  
Afun = @(z) A*z;
Atfun = @(z) A'*z;

I_block = mat2cell(I0, B*ones(1, n/B), B*ones(1, n/B));
Rec_I_block = cell(n/B, n/B);
tic;
for ii = 1:n/B
    for jj = 1:n/B
        I = double(I_block{ii, jj});
        x = reshape(I,N,1);
        
        % observations
        b = Afun(x);
        % initial point
        x0 = Atfun(b);
        % reconstruction
        xp =  tveq_logbarrier(x0, Afun, Atfun, b, 1e-3, 5, 1e-8, 200);
        Ip = reshape(xp, B, B);
        
        Rec_I_block{ii, jj} = Ip;
        fprintf('ii = %d, jj = %d\n===============\n', ii, jj);
    end
end
t = toc;
rec_img = cell2mat(Rec_I_block);
psnr = PSNR(double(original_img), double(rec_img));
end