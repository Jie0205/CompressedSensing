function  Phi=sbhe(blockNum, B, m)
%
% Function implementing measurement matrix as given in  
% "Fast compressive imaging using scrambled block Hadamard ensemble."
%  by Lu Gan, Thong Do and Trac Tran
%
% Written by Jie.
%
% Input:
%     blockNum : number of hadamard matrix blocks
%     B: size of Hadamard matrix
%     t: number of rows of Phi
% Output:
%     Phi: matrix with (blockNum*B) columns and m rows
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% e.g.
% k=16;
% hd = 32;
% mt = 30;
% we sample 30*(32*16) points for the (32*16)*(32*16) image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


N = B * blockNum;
Had = hadamard(B);
st1='';
for i=1:blockNum-1
	st1 = strcat(st1,'Had,');
end
st1= strcat(st1,'Had');
eval(['w = blkdiag(' st1 ')']);
u = randperm(N);
wnew = zeros(N, N);
for ii=1:N
	wnew(:,ii)=w(:,u(ii));
end

vv = randperm(N, m);

Phi = zeros(m, N);
for j=1:m
	Phi(j,:) = wnew(vv(j),:);
end


