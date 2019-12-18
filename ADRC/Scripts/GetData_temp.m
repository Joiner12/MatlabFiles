%% �����ı��ļ��е����ݡ�
% ���ڴ������ı��ļ��������ݵĽű�:
%
%    C:\Users\Whtest\Desktop\�½��ı��ĵ�.txt
%
% Ҫ��������չ������ѡ�����ݻ������ı��ļ��������ɺ���������ű���

% �� MATLAB �Զ������� 2019/12/05 14:14:37
clc;
if false
    cnt = 0;
    while true
        cnt = cnt + 1;
        pause(rand());
        fprintf('awsl!');
        for i = 1:1:randi(5)+1
            fprintf('....')
        end
        if mod(cnt,5) == 0
            fprintf('\n');
            cnt = 1;
        end
    end
    
    for i=linspace(1,10,10)
        fprintf('AWSL!');
    end
    fprintf('\n');
end

%% ��ʼ��������
filename = 'C:\Users\Whtest\Desktop\�½��ı��ĵ�.txt';
delimiter = ',';

%% ÿ���ı��еĸ�ʽ:
%   ��1: ˫����ֵ (%f)
%	��2: ˫����ֵ (%f)
%   ��3: ˫����ֵ (%f)
%	��4: ˫����ֵ (%f)
%   ��5: ˫����ֵ (%f)
%	��6: ˫����ֵ (%f)
%   ��7: ˫����ֵ (%f)
% �й���ϸ��Ϣ������� TEXTSCAN �ĵ���
formatSpec = '%f%f%f%f%f%f%f%[^\n\r]';

%% ���ı��ļ���
fileID = fopen(filename,'r');

%% ���ݸ�ʽ��ȡ�����С�
% �õ��û������ɴ˴������õ��ļ��Ľṹ����������ļ����ִ����볢��ͨ�����빤���������ɴ��롣
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);

%% �ر��ı��ļ���
fclose(fileID);

%% ���޷���������ݽ��еĺ���
% �ڵ��������δӦ���޷���������ݵĹ�����˲�����������롣Ҫ�����������޷���������ݵĴ��룬�����ļ���ѡ���޷������Ԫ����Ȼ���������ɽű���

%% ����������������б�������
% LogValue(_s_nCnt++,_nEsoCapHeightUniP,_pLADRC->pESO->x_1,_pLADRC->pESO->x_2,
%           _pLADRC->pESO->x_3,_pLADRC->pTDB->nTracker,_nLadrcUnitV);
VarName1 = dataArray{:, 1};
VarName2 = dataArray{:, 2};
VarName3 = dataArray{:, 3};
VarName4 = dataArray{:, 4};
VarName5 = dataArray{:, 5};
VarName6 = dataArray{:, 6};
VarName7 = dataArray{:, 7};
lins = ["time","caph","x1","x2","x3","track","ctrl"];
%% �����ʱ����
clearvars filename delimiter formatSpec fileID dataArray ans;
%%
try
    close('gh')
catch
    fprintf('it seems no such figure opened\n');
end
figure('name','gh')
subplot(221)
plot(VarName1,VarName2,'LineWidth',1.0)
hold on
plot(VarName1,VarName3,'LineWidth',1.1)
hold on
plot(VarName1,VarName4,'LineWidth',1.2)
hold on
plot(VarName1,VarName5,'LineWidth',1.3)
hold on
plot(VarName1,VarName6,'LineWidth',1.4)
% legend('1','2','3','4','5')
legend(lins(2:6))

subplot(222)
plot(VarName1/2000,VarName2,'LineWidth',1.0)
hold on
plot(VarName1/2000,VarName3,'LineWidth',1.1)
hold on
plot(VarName1/2000,VarName6,'LineWidth',1.3)
legend([lins(2:3),lins(6)])

subplot(223)
plot(VarName1,VarName3,'LineWidth',1.0)
hold on
plot(VarName1,VarName7,'LineWidth',1.1)
legend(lins(3),lins(7))

subplot(224)
if true
    plot(VarName1,VarName2,'LineWidth',1.0)
    hold on
    plot(VarName1,VarName5,'LineWidth',1.1)
    legend(lins(4),lins(5))
else
    % plot(VarName1,VarName6,'LineWidth',2,'LineStyle','-')
    % hold on 
    plot(VarName1,VarName7,'LineWidth',1.2)
    grid minor
    title(lins(7))
end
