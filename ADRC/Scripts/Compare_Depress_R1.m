clc;clear;
TargetPath = 'H:\MatlabFiles\ADRC\Scripts';
CurPath = pwd;
% if CurPath == TargetPath
if strcmp(CurPath,TargetPath)
    fprintf('Road...%s\t\n%s\n',pwd,'ADRC');
else
    cd H:\MatlabFiles\ADRC\Scripts
end
clear ans CurPath TargetPath

%% 
%{
    1.�Աȷ���ADRC��3.0�����ƺ���������
    2.Ѱ�ҽ������ADRC�����ƺ����������������
    3.���ݱ�����ADRCVS3-0.mat

    
    reference:
    [1] ../..//2019-12-30-ʵ���¼/ʵ���¼.md
%}

%% below �������� import data from 3.0
% variable name
% encode_ratio1 = 
% capheight_ratio1 = 
% target_ratio1 = 
% followerr_ratio1 = 
% deplevel_ratio1 =
% maching_ratio1 = 


% �����ı��ļ��е����ݡ�
% ���ڴ������ı��ļ��������ݵĽű�:
%
%    H:\MatlabFiles\ADRC\Data\2019-12-30-ʵ���¼\3.0-DepressRatio-1.txt
%
% Ҫ��������չ������ѡ�����ݻ������ı��ļ��������ɺ���������ű���

% �� MATLAB �Զ������� 2019/12/31 11:51:45

% ��ʼ��������
filename = 'H:\MatlabFiles\ADRC\Data\2019-12-30-ʵ���¼\3.0-DepressRatio-5.txt';
delimiter = ',';

% ÿ���ı��еĸ�ʽ:
%   ��1: ˫����ֵ (%f)
%	��2: ˫����ֵ (%f)
%   ��3: ˫����ֵ (%f)
%	��4: ˫����ֵ (%f)
%   ��5: ˫����ֵ (%f)
%	��6: ˫����ֵ (%f)
%   ��7: ˫����ֵ (%f)
% �й���ϸ��Ϣ������� TEXTSCAN �ĵ���
formatSpec = '%f%f%f%f%f%f%f%[^\n\r]';

% ���ı��ļ���
fileID = fopen(filename,'r');

% ���ݸ�ʽ��ȡ�����С�
% �õ��û������ɴ˴������õ��ļ��Ľṹ����������ļ����ִ����볢��ͨ�����빤���������ɴ��롣
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

% �ر��ı��ļ���
fclose(fileID);

% ���޷���������ݽ��еĺ���
% �ڵ��������δӦ���޷���������ݵĹ�����˲�����������롣Ҫ�����������޷���������ݵĴ��룬�����ļ���ѡ���޷������Ԫ����Ȼ���������ɽű���

% ����������������б�������

time_ratio5 = dataArray{:, 1};
encode_ratio5 = dataArray{:, 2};
capheight_ratio5 = dataArray{:, 3};
target_ratio5 = dataArray{:, 4};
followerr_ratio5 = dataArray{:, 5};
deplevel_ratio5 = dataArray{:, 6};
maching_ratio5 = dataArray{:, 7};

% �����ʱ����
clearvars filename delimiter formatSpec fileID dataArray ans;
% above ��������������������������������������������������������import data from 3.0 

%% below ��������import data from adrc 
%{
LogValue(_s_nCnt++,_nHeightUnitP,pSelf_->pESO->x_1,pSelf_->pESO->x_2,
			nTargetHeightUnitP_,pSelf_->pTDB->nTracker,_nPosEncoderUnitP);
%}
% variable name
% encode_ratio1 = 
% capheight_ratio1 = 
% target_ratio1 = 
% followerr_ratio1 = 
% deplevel_ratio1 =
% maching_ratio1 = 


% �����ı��ļ��е����ݡ�
% ���ڴ������ı��ļ��������ݵĽű�:
%
%    H:\MatlabFiles\ADRC\Data\2019-12-30-ʵ���¼\3.0-DepressRatio-1.txt
%
% Ҫ��������չ������ѡ�����ݻ������ı��ļ��������ɺ���������ű���

% �� MATLAB �Զ������� 2019/12/31 11:51:45

% ��ʼ��������
filename = 'H:\MatlabFiles\ADRC\Data\2019-12-30-ʵ���¼\slope-��10����12��ӹ��ٶ�-5m-b0-1500.txt';
delimiter = ',';

% ÿ���ı��еĸ�ʽ:
%   ��1: ˫����ֵ (%f)
%	��2: ˫����ֵ (%f)
%   ��3: ˫����ֵ (%f)
%	��4: ˫����ֵ (%f)
%   ��5: ˫����ֵ (%f)
%	��6: ˫����ֵ (%f)
%   ��7: ˫����ֵ (%f)
% �й���ϸ��Ϣ������� TEXTSCAN �ĵ���
formatSpec = '%f%f%f%f%f%f%f%[^\n\r]';

% ���ı��ļ���
fileID = fopen(filename,'r');

% ���ݸ�ʽ��ȡ�����С�
% �õ��û������ɴ˴������õ��ļ��Ľṹ����������ļ����ִ����볢��ͨ�����빤���������ɴ��롣
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

% �ر��ı��ļ���
fclose(fileID);

% ���޷���������ݽ��еĺ���
% �ڵ��������δӦ���޷���������ݵĹ�����˲�����������롣Ҫ�����������޷���������ݵĴ��룬�����ļ���ѡ���޷������Ԫ����Ȼ���������ɽű���

% ����������������б�������

time_b01500 = dataArray{:, 1};
capheight_b01500 = dataArray{:, 2};
x1_b01500 = dataArray{:, 3};
x2_b01500 = dataArray{:, 4};
target_b01500 = dataArray{:, 5};
tracker_b01500 = dataArray{:, 6};
encoder_b01500 = dataArray{:, 7};




% �����ʱ����
clearvars filename delimiter formatSpec fileID dataArray ans;

% above ��������������������������������������������������������import data from adrc 

%% below �������� import data from adrc of slope 
% variable name
% encode_ratio1 = 
% capheight_ratio1 = 
% target_ratio1 = 
% followerr_ratio1 = 
% deplevel_ratio1 =
% maching_ratio1 = 


% �����ı��ļ��е����ݡ�
% ���ڴ������ı��ļ��������ݵĽű�:
%
%    H:\MatlabFiles\ADRC\Data\2019-12-30-ʵ���¼\3.0-DepressRatio-1.txt
%
% Ҫ��������չ������ѡ�����ݻ������ı��ļ��������ɺ���������ű���

% �� MATLAB �Զ������� 2019/12/31 11:51:45

% ��ʼ��������
filename = 'H:\MatlabFiles\ADRC\Data\2019-12-30-ʵ���¼\slope-��10����12��ӹ��ٶ�-2.5m-b0-2000.txt';
delimiter = ',';

% ÿ���ı��еĸ�ʽ:
%   ��1: ˫����ֵ (%f)
%	��2: ˫����ֵ (%f)
%   ��3: ˫����ֵ (%f)
%	��4: ˫����ֵ (%f)
%   ��5: ˫����ֵ (%f)
%	��6: ˫����ֵ (%f)
%   ��7: ˫����ֵ (%f)
% �й���ϸ��Ϣ������� TEXTSCAN �ĵ���
formatSpec = '%f%f%f%f%f%f%f%[^\n\r]';

% ���ı��ļ���
fileID = fopen(filename,'r');

% ���ݸ�ʽ��ȡ�����С�
% �õ��û������ɴ˴������õ��ļ��Ľṹ����������ļ����ִ����볢��ͨ�����빤���������ɴ��롣
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

% �ر��ı��ļ���
fclose(fileID);

% ���޷���������ݽ��еĺ���
% �ڵ��������δӦ���޷���������ݵĹ�����˲�����������롣Ҫ�����������޷���������ݵĴ��룬�����ļ���ѡ���޷������Ԫ����Ȼ���������ɽű���

% ����������������б�������

time_b02000slope = dataArray{:, 1};
capheight_b02000slope = dataArray{:, 2};
x1_b02000slope = dataArray{:, 3};
x2_b02000slope = dataArray{:, 4};
target_b02000slope = dataArray{:, 5};
tracker_b02000slope = dataArray{:, 6};
encoder_b02000slope = dataArray{:, 7};

% �����ʱ����
clearvars filename delimiter formatSpec fileID dataArray ans;
% above ��������������������������������������������������������import data from adrc of slope 

%%  below ��������draw figure of data from 3.0
clc;close all;
tag = {'ratio1','ratio2','ratio3','ratio4','ratio5','targetheight'};
figure
subplot(221)
plot(encode_ratio1)
hold on
plot(encode_ratio2)
hold on
plot(encode_ratio3)
hold on
plot(encode_ratio4)
hold on
plot(encode_ratio5)
title('encoder')
legend(tag(1:5))

subplot(222)
plot(capheight_ratio1)
hold on
plot(capheight_ratio2)
hold on
plot(capheight_ratio3)
hold on
plot(capheight_ratio4)
hold on
plot(capheight_ratio5)
hold on 
plot(target_ratio5)
title('capheight')
legend(tag)
% above ��������������������������������������������������������draw figure of data from 3.0

%% below �������� figure of data from adrc 
clc;close all;
fprintf('figre of data from adrc\n');

tag_a = {'200','1000','2000','3000','targetheight'};
figure 
subplot(221)
plot(capheight_b0200)
hold on 
plot(capheight_b01000)
hold on 
plot(capheight_b02000)
hold on 
plot(capheight_b03000)
hold on
plot(target_ratio5)
legend(tag_a)
title('capheight-adrc')


subplot(222)
plot(encoder_b0200)
hold on 
plot(encoder_b01000)
hold on 
plot(encoder_b02000)
hold on 
plot(encoder_b03000)
legend(tag_a(1:4))
title('encoder-adrc')


subplot(223)
plot(capheight_ratio1)
hold on
plot(capheight_ratio2)
hold on
plot(capheight_ratio3)
hold on
plot(capheight_ratio4)
hold on
plot(capheight_ratio5)
hold on 
plot(target_ratio5)
title('capheight-3.0')
legend(tag)


subplot(224)
plot(encode_ratio1)
hold on
plot(encode_ratio2)
hold on
plot(encode_ratio3)
hold on
plot(encode_ratio4)
hold on
plot(encode_ratio5)
title('encoder-3.0')
legend(tag(1:5))


% above ��������������������������������������������������������draw figure of data from adrc

%% below is detail of some figure ��������
figure
plot(capheight_b03000)
hold on 
plot(capheight_b01000)
% ��������������������������������������������������������above is detail of some figure