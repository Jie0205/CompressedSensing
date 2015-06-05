function x = sample_transpose(y, Phi, num_rows, num_cols, block_size)

% 
M = size(Phi, 1);
y = reshape(y, [M length(y)/M]);
x = Phi' * y;
x = col2im(x, [block_size block_size], [num_rows num_cols], 'distinct');
x = x(:);
