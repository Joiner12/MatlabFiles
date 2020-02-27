%% �����ź�����
%{
    ���ɵ��͵��ź����� 

    ref:
    [1] �������е�MATLABʵ�� https://blog.csdn.net/zhengqijun_/article/details/53265625
   
%}
clc;
fprintf('Just for test\n');
[x,y]=stepseq(20,0,1000);
figure
plot(x)

%% 1. ��λ��������
function[x,n] = impseq(n0,ns,nf)
% ns=���е���㣻nf=���е��յ㣻n0=������n0����һ����λ���塣
% x=�����ĵ�λ�������У�n=�������е�λ����Ϣ
n = [ns:nf];
x = [(n-n0)==0];
end

%% 2. ��λ��Ծ����
% ns=���е���㣻nf=���е��յ�
% n0=��n0����ʼ���ɵ�λ��Ծ����
% x=�����ĵ�λ��Ծ���У� n=�������е�λ����Ϣ
function[x,n] = stepseq(n0,ns,nf)
n = [ns:nf];
x = 10.*[(n-n0)>=0];
end


%% 3. ��������
function[x,n] = rectseq(n0,ns,nf,N)
% ns=���е���㣻nf=���е��յ㣻n0=�������п�ʼ��λ��
% N=�������еĳ��ȣ�x=�����ľ������У�n=�������е�λ����Ϣ
n = [ns:nf];
x = [(n - n0) >= 0 & ((n0 + N - 1) - n) >= 0];
end


%% 4. ʵָ������
function[x,n] = realindex(ns,nf,a)
% ns=���е���㣻nf=���е��յ㣻n0=ʵָ����ֵ
% x=������ʵָ�����У�n=�������е�λ����Ϣ
n = [ns:nf];
x = a.^n;
end

%% 5. ��������
function[x,n] = sinseq(ns,nf,A,w0,alpha)
% ns=���е���㣻nf=���е��յ㣻A=�������еķ���
% w0=�������е�Ƶ�ʣ�alpha=�������еĳ�ʼ��λ
% x=�������������У�n=�������е�λ����Ϣ
n = [ns:nf];
x = A * sin(w0 * n + alpha);
end
%% 6. ��ָ������
function[x,n] = complexindex(ns,nf,index)
% ns=���е���㣻nf=���е��յ㣻index=��ָ����ֵ
% x=�����ĸ�ָ�����У�n=�������е�λ����Ϣ
n = [ns:nf];
x = exp(index.*n);
end