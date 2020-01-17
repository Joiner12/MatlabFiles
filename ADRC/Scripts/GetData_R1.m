%% �����ı��ļ��е����ݡ�
% ���ڴ������ı��ļ��������ݵĽű�:
%
%    C:\Users\Whtest\Desktop\���ټ�������.txt
%
% Ҫ��������չ������ѡ�����ݻ������ı��ļ��������ɺ���������ű���

% �� MATLAB �Զ������� 2020/01/08 19:18:08

%% ��ʼ��������
filename = 'C:\Users\Whtest\Desktop\���ټ�������.txt';
delimiter = ',';
% LogValue(_s_nCnt++,_nHeightUnitP,_nNextAcc,pSelf_->nDir,_nMoveL,_nInterpUnitV,_nFollowUnitV);
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
VarName1 = dataArray{:, 1};
VarName2 = dataArray{:, 2};
VarName3 = dataArray{:, 3};
VarName4 = dataArray{:, 4};
VarName5 = dataArray{:, 5};
VarName6 = dataArray{:, 6};
VarName7 = dataArray{:, 7};


%% �����ʱ����
clearvars filename delimiter formatSpec fileID dataArray ans;
%{
typedef enum
{
	SM_NOT_READY,     //δ���� 0
	SM_IDLE,          //����  1
	SM_SERVO_CALI,    //�ŷ��궨 2
	SM_POSITONING,    //��λ״̬ 3
	SM_FOLLOWING,     //�涯״̬ 4
	SM_PARKING,       //��ͣ���� 5
	SM_DRYRUNNING,              6
	SM_ERROR,         //����״̬
}SM_STATUS;


typedef enum
{
	FS_LOCKING,0
	FS_PREINTERPOLATE,1
	FS_SWITCHING,2
	FS_PID_CONTROL,3
}FS_STATUS;

%}
if false
    try
        close('stuckG')
    catch
    end
    
    figure('name','stuckG')
    subplot(221)
    plot(VarName1,VarName2)
    
    subplot(222)
    plot(VarName1,VarName3)
    hold on
    plot(VarName1,VarName4)
    legend('1','2')
    
    
    subplot(223)
    
    plot(VarName1,VarName6)
    hold on
    plot(VarName1,VarName7)
    legend('acc value','acc dir')
    subplot(224)
    plot(VarName1,VarName5*1e4 + 5e4)
    hold on
    plot(VarName1,VarName2)
    hold on
    plot(VarName1,VarName4*1e4)
    hold on
    plot([VarName1(1),VarName1(end)],[5e4,5e4])
    legend('dir','capheight','followstate')
end

%%
if false
    
    % LogValue(_s_nCnt++,_nHeightUnitP,_nNextAcc,pSelf_->nDir,_nMoveL,_nInterpUnitV,_nFollowUnitV);
    
    try
        close('stuckG')
    catch
    end
    
    figure('name','stuckG')
    subplot(411)
    plot(VarName1,VarName2)
    hold on
    plot(VarName1,VarName4*1e5)
    legend('height','dir')
    title('height')
    
    subplot(412)
    plot(VarName1,VarName3)
    title('next acc')
    
    subplot(413)
    plot(VarName1,VarName6)
    hold on
    plot(VarName1,VarName7)
    legend('IUnitv','PUnitV')
    
    
    subplot(414)
    plot(VarName1,VarName5)
    title('move-l')
    
    
end
%%
%{
	g_Value1 = pSelf_->nDir;
	g_Value2 = _nMoveL;
	g_Value3 = _pInterp->nRem;
	g_Value4 = _nFollowUnitV;
	g_Value5 = _nInterpUnitV;
	LogValue(_s_nCnt++,_nHeightUnitP,g_Value1,g_Value2,g_Value3,g_Value4,g_Value5);
%}

try
    close('stuckG')
catch
end

figure('name','stuckG')
subplot(411)
plot(VarName1,VarName2)
hold on
plot(VarName1,VarName3*1e5)
legend('capheight','dir')
title('height')

subplot(412)
plot(VarName1,VarName4)
hold on
plot(VarName1,VarName5)
legend('movel','rem')

subplot(413)
plot(VarName1,VarName6)
hold on
plot(VarName1,VarName7)
legend('follow','interp')