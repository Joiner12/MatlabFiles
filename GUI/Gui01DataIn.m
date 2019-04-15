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
[filename filepath fileindex]=uigetfile({'*.xls','Excel�ļ�(*.xls)';'*.txt','�ı��ļ�(*.txt)';'*.*','�����ļ�(*.*)'},'ѡ���ļ�');  %���ļ��Ի���
if fileindex~=0   %���û�е��ȡ��
    l=length(filename);   %filename������׺��
    if l<=4
        errordlg('�����ļ�','�ļ��򿪴���');  %����Ի���
        return;
    end
    test=filename(1,l-3:l);   %�ļ�������ȡ��׺��
    switch test
        case '.xls'   %����Ǳ���ļ�
            str=[filepath filename];   %ƴ�Ӿ���·��
            set(handles.edit2,'String',str);  %
            h=waitbar(0,'���ڶ�ȡ�ļ�....');   %������(���ļ��Ƚ���)
			%���ݾ���·������xls�ļ���chengji��һ����ά��������
			%xingming��һ��һά����������һ������chengjiֻ���洿���֣��ڶ�������xingmingֻ�����ַ�����
            [chengji xingming]=xlsread(str);  
            waitbar(1,h,'���');
            delete(h);    
            set(handles.listbox1,'String',xingming(:,1));   %����listbox1����ʾ����
            handles.chengji=chengji;     %��chengji���뵽ȫ�ֱ�����
            guidata(hObject, handles);   %����gui����
        case '.txt'
            strfile=[filepath filename];   %ƴ�Ӿ���·��
            set(handles.edit2,'String',strfile);  
            fin=fopen('chengji.txt','r');   %��txt�ļ�
            str=fgetl(fin);     %��ȡtxt�ļ��ĵ�һ��
            %   A=fscanf(fin,'%d','HeaderLines',1);  ����ǰһ�еı�������  
            %   [A B]=textscanf(fin,'%d %d');   ����һ��cell���͵�����[A B]��һ��һ�еĶ�  
            %   ftell();    �õ���ȡ��λ��
            
            [str1 str2 str3 str4]=strread(str,'%s %s %s %s','delimiter',' '); %�Կո�ָ��ȡÿһ��
            xingming(1)=str1;
            counter=2;  %txt�ļ��ĵ�һ����(name yuwen shuxue yuwen)�����Դӵڶ��в�����Ҫ�����ݡ�
            while feof(fin)==0   %����ܶ���txt�ļ������ݣ�(û�е�txt�ļ��Ľ�β)
                str=fgetl(fin);  %��ȡtxt�ļ���һ������
                [name yuwen shuxue yingyu]=strread(str,'%s %d %d %d','delimiter',' ');
                xingming(counter)=name;
                chengji(counter-1,:)=[yuwen shuxue yingyu];
                counter=counter+1;
            end
            set(handles.listbox1,'String',xingming(1,:));
            handles.chengji=chengji;
            guidata(hObject, handles);
            fclose(fin);  %�ر��ļ���
            
        otherwise
            errordlg('�ļ����ʹ���','�ļ�����');  
            return;
    end      
end


% listboxѡ��ı�Ļص�����-----------------------------------
function listbox1_Callback(hObject, eventdata, handles)

value=get(hObject,'Value')-1;  %value��ʾѡ����listbox�ĵڼ���(��1��ʼ)����1����Ϊ��һ���Ǳ���(name yuwen shuxue yuwen)
if value>=1
set(handles.edit1,'String',num2str(handles.chengji(value,:)));
end


% �˳���ť-------------------------------------------------
function pushbutton2_Callback(hObject, eventdata, handles)

clc;
clear all;
close(gcf);

