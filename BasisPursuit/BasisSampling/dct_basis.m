function matrix = dct_basis(n)

Psi = zeros(n, n);
for i = 1: n
    X = zeros(n, 1);
    X(i, 1) = 1;
    x = idct(X);
    Psi(:, i) = x;
end
matrix = Psi;