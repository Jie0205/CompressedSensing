function y = sample(x, Phi, num_rows, num_cols, block_size)

% get the size of each block.
N = size(Phi, 2);

% reshape the image to blocks, convert each block matrix to vector, and
% sampling.
x = reshape(x, [num_rows num_cols]);
x = im2col(x, [block_size block_size], 'distinct');
y = Phi * x;

y = y(:);

