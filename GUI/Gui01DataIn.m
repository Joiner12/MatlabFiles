function varargout = Gui01DataIn(varargin)
% GUI01DATAIN MATLAB code for Gui01DataIn.fig
%      GUI01DATAIN, by itself, creates a new GUI01DATAIN or raises the existing
%      singleton*.
%
%      H = GUI01DATAIN returns the handle to a new GUI01DATAIN or the handle to
%      the existing singleton*.
%
%      GUI01DATAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI01DATAIN.M with the given input arguments.
%
%      GUI01DATAIN('Property','Value',...) creates a new GUI01DATAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui01DataIn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui01DataIn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui01DataIn

% Last Modified by GUIDE v2.5 08-Apr-2019 22:24:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui01DataIn_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui01DataIn_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Gui01DataIn is made visible.
function Gui01DataIn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui01DataIn (see VARARGIN)

% Choose default command line output for Gui01DataIn
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui01DataIn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui01DataIn_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename filepath fileindex]=uigetfile({'*.xls','Excel文件(*.xls)';'*.txt','文本文件(*.txt)';'*.*','所有文件(*.*)'},'选择文件');  %打开文件对话框
if fileindex~=0   %如果没有点击取消
    l=length(filename);   %filename包含后缀名
    if l<=4
        errordlg('错误文件','文件打开错误');  %错误对话框
        return;
    end
    test=filename(1,l-3:l);   %文件名，截取后缀名
    switch test
        case '.xls'   %如果是表格文件
            str=[filepath filename];   %拼接绝对路径
            set(handles.edit2,'String',str);  %
            h=waitbar(0,'正在读取文件....');   %进度条(打开文件比较慢)
			%根据绝对路径，打开xls文件。chengji是一个三维列向量，
			%xingming是一个一维列向量。第一个参数chengji只保存纯数字，第二个参数xingming只保存字符串。
            [chengji xingming]=xlsread(str);  
            waitbar(1,h,'完成');
            delete(h);    
            set(handles.listbox1,'String',xingming(:,1));   %设置listbox1的显示内容
            handles.chengji=chengji;     %将chengji放入到全局变量中
            guidata(hObject, handles);   %更新gui数据
        case '.txt'
            strfile=[filepath filename];   %拼接绝对路径
            set(handles.edit2,'String',strfile);  
            fin=fopen('chengji.txt','r');   %打开txt文件
            str=fgetl(fin);     %读取txt文件的第一行
            %   A=fscanf(fin,'%d','HeaderLines',1);  忽略前一行的标题内容  
            %   [A B]=textscanf(fin,'%d %d');   返回一个cell类型的数据[A B]，一列一列的读  
            %   ftell();    得到读取的位置
            
            [str1 str2 str3 str4]=strread(str,'%s %s %s %s','delimiter',' '); %以空格分割，截取每一行
            xingming(1)=str1;
            counter=2;  %txt文件的第一行是(name yuwen shuxue yuwen)，所以从第二行才是需要的内容。
            while feof(fin)==0   %如果能读到txt文件的内容，(没有到txt文件的结尾)
                str=fgetl(fin);  %读取txt文件的一行内容
                [name yuwen shuxue yingyu]=strread(str,'%s %d %d %d','delimiter',' ');
                xingming(counter)=name;
                chengji(counter-1,:)=[yuwen shuxue yingyu];
                counter=counter+1;
            end
            set(handles.listbox1,'String',xingming(1,:));
            handles.chengji=chengji;
            guidata(hObject, handles);
            fclose(fin);  %关闭文件流
            
        otherwise
            errordlg('文件类型错误','文件错误');  
            return;
    end      
end


% listbox选项改变的回调函数-----------------------------------
function listbox1_Callback(hObject, eventdata, handles)

value=get(hObject,'Value')-1;  %value表示选择了listbox的第几项(从1开始)。减1是因为第一行是标题(name yuwen shuxue yuwen)
if value>=1
set(handles.edit1,'String',num2str(handles.chengji(value,:)));
end


% 退出按钮-------------------------------------------------
function pushbutton2_Callback(hObject, eventdata, handles)

clc;
clear all;
close(gcf);

