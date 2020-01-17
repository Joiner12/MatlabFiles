%% 导入文本文件中的数据。
% 用于从以下文本文件导入数据的脚本:
%
%    C:\Users\Whtest\Desktop\卡顿监视数据.txt
%
% 要将代码扩展到其他选定数据或其他文本文件，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2020/01/08 19:18:08

%% 初始化变量。
filename = 'C:\Users\Whtest\Desktop\卡顿监视数据.txt';
delimiter = ',';
% LogValue(_s_nCnt++,_nHeightUnitP,_nNextAcc,pSelf_->nDir,_nMoveL,_nInterpUnitV,_nFollowUnitV);
%% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
%	列4: 双精度值 (%f)
%   列5: 双精度值 (%f)
%	列6: 双精度值 (%f)
%   列7: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%f%f%f%f%f%f%f%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);

%% 关闭文本文件。
fclose(fileID);

%% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的元胞，然后重新生成脚本。

%% 将导入的数组分配给列变量名称
VarName1 = dataArray{:, 1};
VarName2 = dataArray{:, 2};
VarName3 = dataArray{:, 3};
VarName4 = dataArray{:, 4};
VarName5 = dataArray{:, 5};
VarName6 = dataArray{:, 6};
VarName7 = dataArray{:, 7};


%% 清除临时变量
clearvars filename delimiter formatSpec fileID dataArray ans;
%{
typedef enum
{
	SM_NOT_READY,     //未就绪 0
	SM_IDLE,          //空闲  1
	SM_SERVO_CALI,    //伺服标定 2
	SM_POSITONING,    //定位状态 3
	SM_FOLLOWING,     //随动状态 4
	SM_PARKING,       //回停靠点 5
	SM_DRYRUNNING,              6
	SM_ERROR,         //错误状态
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