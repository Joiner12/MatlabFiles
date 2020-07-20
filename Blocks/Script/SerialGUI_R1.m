%% SERIAL PORT GUI & LOG INFO
%{

    ref:
    [1]MATLAB 串口读取姿态数据及GUI实时动态显示设计https://www.jianshu.com/p/6f22c8d35961
%}


% COM callback 函数设置
% --- Executes on selection change in ppcom.
function ppcom_Callback(hObject, eventdata, handles)
% hObject    handle to ppcom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ppcom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ppcom
global COM;
val=get(hObject,'value');
switch val
    case 1
        COM='COM1';
        fprintf('ceshi_COM=1\n');
    case 2
        COM='COM2';
    case 3
        COM='COM3';
    case 4
        COM='COM4';
    case 5
        COM='COM5';
    case 6
        COM='COM6';
    case 7
        COM='COM7';
    case 8
        COM='COM8';
    case 9
        COM='COM9';
end
end

% 波特率callback 函数设置
function ppbandrate_Callback(hObject, eventdata, handles)
% hObject    handle to ppbandrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ppbandrate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ppbandrate
global rate;
val=get(hObject,'value');
switch val
    case 1
        rate=9600;
    case 2
        rate=19200;
    case 3
        rate=38400;
    case 4
        rate=115200;
end
end

% 打开串口
function activityReco_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to activityReco (see VARARGIN)

global COM;
global rate;
global act a;
global count;
global act_data t;
global p x;
count=1;x=-15;
act=zeros(12,1);
t=0;
p = plot(t,act,...
    'EraseMode','background','MarkerSize',5);
% axis([x x+20 -200 200]);
% grid(handles.axplotact,'on');
set(handles.axplotact,'XLim',[x x+20],'YLim',[-200 200]);
set(handles.axplotact,'XTickLabel',[]);
legendaxes=legend(handles.axplotact,{'Yaw','Pitch','Roll','Accx','Accy','Accz','GYROx','GYROy','GYROz','Magx','Magy','Magz'},1);
set(legendaxes,'Location','northeastoutside');
act_data=[]; a=[];
COM='COM5'
rate = 115200;
set(handles.ppcom,'value', 5);
set(handles.ppbandrate,'value',4);
set(handles.pbcloseserial,'Enable','off');
% Choose default command line output for activityReco
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
end

% 关闭串口
function pbcloseserial_Callback(hObject, eventdata, handles)
% hObject    handle to pbcloseserial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
fclose(s);
delete(s);
set(handles.pbcloseserial,'Enable','on');
set(handles.pbopenserial,'Enable','off');
fprintf('close com');
end

% 显示功能
function ReceiveCallback( obj,event,handles)     %创建中断响应函数
global s a fid;
global count;
global  act;
global act_data;
global t x p;
str = fread(s,100,'uint8');%读取数据
hex=dec2hex(str);
IMU_data = [];Motion_data=[];
sign_head1=hex2dec('A5');sign_head2 = hex2dec('5A');
sign_finish=hex2dec('AA');sign_IMU=hex2dec('A1');sign_Motion=hex2dec('A2');

a= [a;str];
j=1;
while (~isempty(a))
    if j>size(a,1)
        break;
    end
    if a(j)==sign_head1 && a(j+1) == sign_head2
        if (j+a(j+2)+1) > size(a,1)
            break;
        end
        index_start = j+2;
        index_finish= index_start + a(j+2)-1;
        pack = a(index_start:index_finish);
        if ~isempty(pack) &&pack(pack(1))== sign_finish
            if pack(2) == sign_IMU
                IMU_data(1,:) = Get_IMU(pack);
                j = index_finish;
                continue;
            end
            if pack(2) ==sign_Motion
                Motion_data(1,:) = Get_Motion(pack);
                j = index_finish;
            end
            if ~isempty(IMU_data) && ~isempty(Motion_data)
                count=count+1;
                act_data = [IMU_data,Motion_data]';
                %                         fprintf(fid,'%8.1f%8.1f%8.1f%8.1f%8.1f%8.1f%8d%8d%8d%8d%8d%8d%8d%8d%8d\n',act_data);
                t=[t 0.1*count];
                act=[act,[act_data(1:3);act_data(7:9)*100/16384;act_data(10:12)*pi/180;act_data(13:15)]];%%绘图数据归一化-200-200
                set(handles.edshowdata,'string',num2str(act_data));
                
                axis(handles.axplotact);
                if ~get(handles.rbpause,'Value')
                    if get(handles.rbshowangles,'Value')
                        set(p(1),'XData',t,'YData',act(1,:));
                        set(p(2),'XData',t,'YData',act(2,:));
                        set(p(3),'XData',t,'YData',act(3,:));
                    end
                    if get(handles.rbshowacc,'Value')
                        set(p(4),'XData',t,'YData',act(4,:));
                        set(p(5),'XData',t,'YData',act(5,:));
                        set(p(6),'XData',t,'YData',act(6,:));
                    end
                    if  get(handles.rbshowgyro,'Value')
                        set(p(7),'XData',t,'YData',act(7,:));
                        set(p(8),'XData',t,'YData',act(8,:));
                        set(p(9),'XData',t,'YData',act(9,:));
                    end
                    if get(handles.rbshowmag,'Value')
                        set(p(10),'XData',t,'YData',act(10,:));
                        set(p(11),'XData',t,'YData',act(11,:));
                        set(p(12),'XData',t,'YData',act(12,:));
                    end
                    drawnow
                    x=x+0.1;
                    set(handles.axplotact,'ytick',-200:50:200);
                    axis(handles.axplotact,[x x+20 -200 200]);
                    %                            set(handles.axplotact,'xtick',x:x+20);
                    if size(t,2) >400
                        t(1)=[];
                        act(:,1)=[];
                    end
                end
            end
            %                   set(handles.edshowdata,'String',num2str(act));
            Motion_data=[];IMU_data=[];
            a(1:index_finish)=[];
            j=1;
            %                   pause(0.005);
        end
    else
        j=j+1;
    end
end
end