%% 导入文本文件中的数据。
% 用于从以下文本文件导入数据的脚本:
%
%    C:\Users\Whtest\Desktop\新建文本文档.txt
%
% 要将代码扩展到其他选定数据或其他文本文件，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2019/12/05 14:14:37
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

%% 初始化变量。
% filename = 'C:\Users\Whtest\Desktop\新建文本文档.txt';
filename = 'H:\MatlabFiles\ADRC\Data\realtime.txt';
delimiter = ',';

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
% LogValue(_s_nCnt++,_nEsoCapHeightUniP,_pLADRC->pESO->x_1,_pLADRC->pESO->x_2,
%           _pLADRC->pESO->x_3,_pLADRC->pTDB->nTracker,_nLadrcUnitV);
VarName1 = dataArray{:, 1};
VarName2 = dataArray{:, 2};
VarName3 = dataArray{:, 3};
VarName4 = dataArray{:, 4};
VarName5 = dataArray{:, 5};
VarName6 = dataArray{:, 6};
VarName7 = dataArray{:, 7};
lins = ["time","capheight","x1","x2","target","track","encoder"];
%% 清除临时变量
clearvars filename delimiter formatSpec fileID dataArray ans;
%%
try
    close('gh')
catch
    fprintf('it seems no such figure opened\n');
end
figure('name','gh')
subplot(321)
plot(VarName1,VarName2,'LineWidth',1.0)
hold on
plot(VarName1,VarName3,'LineWidth',1.1)
hold on
plot(VarName1,VarName4,'LineWidth',1.2)
hold on
plot(VarName1,VarName5,'LineWidth',1.3)
hold on
plot(VarName1,VarName6,'LineWidth',1.4)
hold on
plot(VarName1,VarName7,'LineWidth',1.4)
grid minor
% legend('1','2','3','4','5')
legend(lins(2:7))



subplot(322)
plot(VarName1/2000,VarName2,'LineWidth',1.0)
hold on
plot(VarName1/2000,VarName3,'LineWidth',1.1)
hold on
plot(VarName1/2000,VarName5,'LineWidth',1.3)
hold on
plot(VarName1/2000,VarName6,'LineWidth',1.3)
grid minor
legend([lins(2:3),lins(5:6)])

subplot(323)
plot(VarName1,VarName3,'LineWidth',1.0)
hold on
plot(VarName1,VarName7,'LineWidth',1.1)
grid minor
legend(lins(3),lins(7))

subplot(324)
if false
    plot(VarName1,VarName5,'LineWidth',1.0)
    hold on
    plot(VarName1,VarName6,'LineWidth',1.1)
    hold on 
    plot(VarName1,VarName7,'LineWidth',1.2)
    legend([lins(2),lins(6:7)])
    grid minor
else
    plot(VarName1,VarName4,'LineWidth',1.5,'LineStyle','-')
    hold on 
    plot(VarName1,VarName7,'LineWidth',1.2)
    grid minor
    legend([lins(4),lins(7)])
end

subplot(325)
plot(VarName1,VarName7./1000,'LineWidth',1)
grid minor
legend(lins(7))
ylabel('MM')

subplot(326)
if mod(100*rand,2)==0
    a=rand(40,40);
    image(a,'CDataMapping','scaled');
    colorbar off
else
    impath = 'H:\MatlabFiles\ADRC\Docs\figures';
    pages = dir(impath);
    showpng = fullfile(impath,pages(randi([3,length(pages)])).name);
    imshow(showpng)
end
