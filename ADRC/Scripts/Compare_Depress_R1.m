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
    1.对比分析ADRC和3.0振动抑制和爬坡能力
    2.寻找解决方案ADRC振动抑制和爬坡能力解决方案
    3.数据保存于ADRCVS3-0.mat

    
    reference:
    [1] ../..//2019-12-30-实测记录/实测记录.md
%}

%% below ↓↓↓↓ import data from 3.0
% variable name
% encode_ratio1 = 
% capheight_ratio1 = 
% target_ratio1 = 
% followerr_ratio1 = 
% deplevel_ratio1 =
% maching_ratio1 = 


% 导入文本文件中的数据。
% 用于从以下文本文件导入数据的脚本:
%
%    H:\MatlabFiles\ADRC\Data\2019-12-30-实测记录\3.0-DepressRatio-1.txt
%
% 要将代码扩展到其他选定数据或其他文本文件，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2019/12/31 11:51:45

% 初始化变量。
filename = 'H:\MatlabFiles\ADRC\Data\2019-12-30-实测记录\3.0-DepressRatio-5.txt';
delimiter = ',';

% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
%	列4: 双精度值 (%f)
%   列5: 双精度值 (%f)
%	列6: 双精度值 (%f)
%   列7: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%f%f%f%f%f%f%f%[^\n\r]';

% 打开文本文件。
fileID = fopen(filename,'r');

% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

% 关闭文本文件。
fclose(fileID);

% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的元胞，然后重新生成脚本。

% 将导入的数组分配给列变量名称

time_ratio5 = dataArray{:, 1};
encode_ratio5 = dataArray{:, 2};
capheight_ratio5 = dataArray{:, 3};
target_ratio5 = dataArray{:, 4};
followerr_ratio5 = dataArray{:, 5};
deplevel_ratio5 = dataArray{:, 6};
maching_ratio5 = dataArray{:, 7};

% 清除临时变量
clearvars filename delimiter formatSpec fileID dataArray ans;
% above ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑import data from 3.0 

%% below ↓↓↓↓import data from adrc 
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


% 导入文本文件中的数据。
% 用于从以下文本文件导入数据的脚本:
%
%    H:\MatlabFiles\ADRC\Data\2019-12-30-实测记录\3.0-DepressRatio-1.txt
%
% 要将代码扩展到其他选定数据或其他文本文件，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2019/12/31 11:51:45

% 初始化变量。
filename = 'H:\MatlabFiles\ADRC\Data\2019-12-30-实测记录\slope-左10°右12°加工速度-5m-b0-1500.txt';
delimiter = ',';

% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
%	列4: 双精度值 (%f)
%   列5: 双精度值 (%f)
%	列6: 双精度值 (%f)
%   列7: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%f%f%f%f%f%f%f%[^\n\r]';

% 打开文本文件。
fileID = fopen(filename,'r');

% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

% 关闭文本文件。
fclose(fileID);

% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的元胞，然后重新生成脚本。

% 将导入的数组分配给列变量名称

time_b01500 = dataArray{:, 1};
capheight_b01500 = dataArray{:, 2};
x1_b01500 = dataArray{:, 3};
x2_b01500 = dataArray{:, 4};
target_b01500 = dataArray{:, 5};
tracker_b01500 = dataArray{:, 6};
encoder_b01500 = dataArray{:, 7};




% 清除临时变量
clearvars filename delimiter formatSpec fileID dataArray ans;

% above ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑import data from adrc 

%% below ↓↓↓↓ import data from adrc of slope 
% variable name
% encode_ratio1 = 
% capheight_ratio1 = 
% target_ratio1 = 
% followerr_ratio1 = 
% deplevel_ratio1 =
% maching_ratio1 = 


% 导入文本文件中的数据。
% 用于从以下文本文件导入数据的脚本:
%
%    H:\MatlabFiles\ADRC\Data\2019-12-30-实测记录\3.0-DepressRatio-1.txt
%
% 要将代码扩展到其他选定数据或其他文本文件，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2019/12/31 11:51:45

% 初始化变量。
filename = 'H:\MatlabFiles\ADRC\Data\2019-12-30-实测记录\slope-左10°右12°加工速度-2.5m-b0-2000.txt';
delimiter = ',';

% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
%	列4: 双精度值 (%f)
%   列5: 双精度值 (%f)
%	列6: 双精度值 (%f)
%   列7: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%f%f%f%f%f%f%f%[^\n\r]';

% 打开文本文件。
fileID = fopen(filename,'r');

% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

% 关闭文本文件。
fclose(fileID);

% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的元胞，然后重新生成脚本。

% 将导入的数组分配给列变量名称

time_b02000slope = dataArray{:, 1};
capheight_b02000slope = dataArray{:, 2};
x1_b02000slope = dataArray{:, 3};
x2_b02000slope = dataArray{:, 4};
target_b02000slope = dataArray{:, 5};
tracker_b02000slope = dataArray{:, 6};
encoder_b02000slope = dataArray{:, 7};

% 清除临时变量
clearvars filename delimiter formatSpec fileID dataArray ans;
% above ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑import data from adrc of slope 

%%  below ↓↓↓↓draw figure of data from 3.0
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
% above ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑draw figure of data from 3.0

%% below ↓↓↓↓ figure of data from adrc 
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


% above ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑draw figure of data from adrc

%% below is detail of some figure ↓↓↓↓
figure
plot(capheight_b03000)
hold on 
plot(capheight_b01000)
% ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑above is detail of some figure