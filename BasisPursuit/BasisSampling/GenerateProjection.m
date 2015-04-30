
function Phi = GenerateProjection(n, subrate, filename)
% ����˵��
% ���룺
% ----------
% ----------subrate ������
% ----------filename �����˹�۲�������ݵ��ļ���
% �����
% ----------Phi ��СΪM*N�ĸ�˹�۲����, ������Ϊ��������
N = n;
M = round(subrate * n);

% �ж���������������Լ��Ƿ�������Ҫ�ĸ�˹�����ļ�����
% ������ڣ���������ݣ������ڣ������´�����
if ((nargin == 3) && exist(filename, 'file'))
    load(filename);
else
  Phi = orth(randn(N, N))';
end

% �����˹����
if ((nargin == 3) && (~exist(filename, 'file')))
  save(filename, 'Phi');
end

%�����ȡM��
Phi = Phi(1:M, :); 
