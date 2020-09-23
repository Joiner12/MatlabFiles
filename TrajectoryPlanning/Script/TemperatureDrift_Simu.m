clc;
cprintf('Systemcommand','Simulator figure running...\n');
% global variables
global refresh_button ;
global editor_1 editor_1_val editor_2 editor_2_val ;
global editor_3 editor_3_val editor_4 editor_4_val;
global textLine_1;
% % axis
% global  ax_1 ax_2;

% main figure
tcf('TdSimu');
SimuFig = figure('name','TdSimu',...
    'DeleteFcn',@CloseMain,...
    'CreateFcn',@CreateMain);
% SimuFig = figure('name','TdSimu');
% set axes
% ax_1 = axes('units','normalized','position',[.05 .07 .4 .4]);
% ax_2 = axes('units','normalized','position',[.5 .07 .4 .4]);

% constructor control
refresh_button =  uicontrol('units','normalized','position',...
    [.05 .9 .1 .05],'style',...
    'pushbutton','String','Load',...
    'Callback',@RefreshValues);

% editor - 1
editor_1 = uicontrol('units','normalized',...
    'position',[.15 .9 .1 .05],'style','edit',...
    'String','1');

% editor - 2
editor_2 = uicontrol('units','normalized',...
    'position',[.25 .9 .1 .05],'style','edit',...
    'String','2');

% editor - 3
editor_3 = uicontrol('units','normalized',...
    'position',[.35 .9 .1 .05],'style','edit',...
    'String','3');

% editor - 4
editor_4 = uicontrol('units','normalized',...
    'position',[.45 .9 .1 .05],'style','edit',...
    'String','4');

% testline - 1
% textLine_1 = uicontrol(SimuFig,... 
%     'position',[.6 .7 .25 .2],'Style','text',... 
%     'String','IT must be ');
textLine_1 = uicontrol(SimuFig,... 
    'position',[20 20 50 100],'Style','text',... 
    'String','IT must be ');

% refresh values in editors
function RefreshValues(~,~)
global editor_1 editor_1_val editor_2 editor_2_val ;
global editor_3 editor_3_val;
global textLine_1;
value_1 = get(editor_1,'String');
value_2 = get(editor_2,'String');
value_3 = get(editor_3,'String');
try
    value_1 = str2double(value_1);
catch
    
end

try
    value_2 = str2double(value_2);
catch
    
end

try
    value_3 = str2double(value_3);
catch
end

editor_1_val = value_1;
editor_2_val = value_2;
editor_3_val = value_3;
a = tic;
while(toc(a) < 1)
    cprintf('Systemcommand','values update : %.0f;%.0f,%0.f\n+%.6f\n',...
        editor_1_val,editor_2_val,editor_3_val,toc(a));
    
    set(textLine_1,'String',num2str(rand()))
end

end

function CloseMain(~,~)
clc;
cprintf('comment','Simulator Closed .\n');
end

function CreateMain(~,~)
% global editor_1_val,editor_2_val,editor_3_val;
% editor_1_val = 0;
end

