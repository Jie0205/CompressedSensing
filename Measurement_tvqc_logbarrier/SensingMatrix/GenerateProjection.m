
function Phi = GenerateProjection(n, subrate, filename)
% 参数说明
% 输入：
% ----------
% ----------subrate 采样率
% ----------filename 保存高斯观测矩阵数据的文件名
% 输出：
% ----------Phi 大小为M*N的高斯观测矩阵, “近似为正交矩阵”
N = n;
M = round(subrate * n);

% 判断输入参数个数，以及是否有所需要的高斯矩阵文件存在
% 如果存在，则读入数据；不存在，则重新创建。
if ((nargin == 3) && exist(filename, 'file'))
    load(filename);
else
  Phi = orth(randn(N, N))';
end

% 保存高斯矩阵
if ((nargin == 3) && (~exist(filename, 'file')))
  save(filename, 'Phi');
end

%随机抽取M行
Phi = Phi(1:M, :); 
