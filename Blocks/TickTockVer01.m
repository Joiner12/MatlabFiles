classdef TickTock < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        TickTockUIFigure  matlab.ui.Figure
        TICKTOCKLabel     matlab.ui.control.Label
        GMT8EditField     matlab.ui.control.EditField
        TRACKButton       matlab.ui.control.Button
        Lamp              matlab.ui.control.Lamp
        SysInfoLabel      matlab.ui.control.Label
        GMT8Label_2       matlab.ui.control.Label
        Label             matlab.ui.control.Label
        TimerButton       matlab.ui.control.StateButton
        UIAxes            matlab.ui.control.UIAxes
        Button            matlab.ui.control.Button
    end

    
    properties (Access = public)
        CurTime string % �ؼ�ʱ����ʾ
    end
    
    properties (Access = private)
        % ʱ����ʾ��ʱ��
        Timer_01 = timer('StartDelay', 5, 'Period', 1, 'TasksToExecute', Inf, 'ExecutionMode', 'fixedRate');
        
        % ʱ��ͳ��
        StartTick = '';   % ��ʱ������ʱ��
        EndTick = '';     % ��ʱ������ʱ��
        ItemDuration = 0; % ����ʱ�� min
        ItemName char ;   % �¼�
        ItemDetail char;  % �¼�����
        
        
        % ��ʱ��,ˢ����ʾ
        Timer_02 = timer('Period', 1, 'TasksToExecute', Inf, 'ExecutionMode', 'fixedRate'); % Description
        
        % ��ʱ��2��ˢ����ʾ
        Timer_03 = timer('Period',10,'TasksToExecute',Inf,'ExecutionMode', 'fixedRate');
        ExitSelection char; % �˳���־
        PreSysInfo char; % ��һ����¼��Ϣ
    end
    
    methods (Access = private)
        
        function ShowTime_01(app)
            % ��ʾ���ڶ�
            if true
                app.GMT8Label_2.FontName = 'Serif';
                app.GMT8Label_2.FontSize = 14;
                app.GMT8Label_2.FontWeight = 'bold';
                CurTime_02 = strcat(datestr(now,'yyyy/mm/dd'),'-',datestr(now,'hh:mm:ss'));
                app.GMT8Label_2.FontColor =  [0.26 0.26 0.26];
                app.GMT8EditField.Value = CurTime_02;
            end
        end
        
        function DrawDurationBar_01(app)
            temp = etime(datevec(datestr(datetime('now'),'yy/mm/dd  HH:MM:SS')),...
                datevec(app.StartTick));
            app.ItemDuration = int32(temp/1); % min
            %fprintf('%ds\n',app.ItemDuration);
            b_1 = barh(app.UIAxes,0.25,app.ItemDuration,0.45);
            % ������״ͼ
            b_1.FaceColor = [0 1 0];
            b_1.EdgeColor = [rand rand rand];
            b_1.LineWidth = 1.2;
        end
        
        %{
            Designe thoughts:
            1.Keep an item information by one line in log_01.txt,
            including item name,time,duration and so on;
        %}
        function KeepItemInfo(app)
            %{
                logpathѡ����Ҫ�����ļ���·������
            %}
            logpath = 'D:\Codes\MatlabFiles\Blocks\TickTockFiles';
            logname = 'log.txt';
            fileID = fopen(strcat(logpath,'\',logname),'a+');
            if ~isequal(fileID,0)
                % ʱ��|����|����|����ʱ��
                StTemp = app.StartTick;
                EtTemp = app.EndTick;
                DutationtTemp = app.ItemDuration;
                ItemNameTemp =  app.ItemName;
                ItemDetailTemp = app.ItemDetail;
                app.PreSysInfo = strcat(ItemNameTemp,'|',...
                    ItemDetailTemp,'|',num2str(DutationtTemp));
                fprintf(fileID,'%s\t|\t%s\t|\t%s\t|\t%s\t|\t%d\n',StTemp...
                    ,EtTemp,ItemNameTemp,ItemDetailTemp,DutationtTemp);
                disp('file open succeed...')
            end
            fclose(fileID);
        end
        
        function selection = CloseReq(app)
            % get
            value = app.ExitSelection;
            selection = questdlg('Are you sure ?',...
                'Exit','Yes','No','No');
            % set
            app.ExitSelection = selection;
        end
        
        % �����Ϣ & ������ʾinfo
        function ClearKeepInfo(app)
            app.StartTick = '';
            app.EndTick = '';
            app.ItemDuration = 0;
            app.ItemName = '';
            app.ItemDetail = '';
        end
        
        function UpdatePanle(app)
            if ~isequal(app.ItemDuration,0)
                app.TRACKButton.BackgroundColor = [0.1,0.5,0.8];
            else
                app.TRACKButton.BackgroundColor = [0.9,0.9,0.9];
            end
        end
        
        % ������ʾ״����Ϣ
        function UpdataSysInfo(app,info)
            if ischar(info)
                app.SysInfoLabel.Text = info;
            end
        end
        
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            clc;
            InfoStart = strcat('������હ���','');
            fprintf('%s\n',InfoStart);
            % ���Ʊ���ͼ
            % app.TickTockUIFigure.ImageSource = 'Wallpaper_21.jpg';
            
            % ��ʼ��������ʾ
            app.GMT8EditField.Value = "Initializing...";
            
            % ������ʱ��1
            app.Timer_01.TimerFcn = @(~, ~) ShowTime_01(app);
            start(app.Timer_01);
            
            % ��ʱ��2 �󶨺���
            app.Timer_02.TimerFcn = @(~,~) DrawDurationBar_01(app);
            
            % ��ʱ��3�󶨺���
            app.Timer_03.TimerFcn = @(~,~) UpdatePanle(app);
            start(app.Timer_03);
            % ��ʼ��ʱ��
            app.StartTick = '';
            app.EndTick = '';
            % fprintf('%s,%s\n',app.StartTick,app.EndTick);
        end

        % Button pushed function: TRACKButton
        function TRACKButtonPushed(app, event)
            % ��ʱ����¼��
            if app.TimerButton.Value
                sysInfo = '��¼��ť������';
                UpdataSysInfo(app,sysInfo);
                %                 app.SysInfoLabel.Text = sysInfo;
            else
                sysInfo = '�����¼';
                app.SysInfoLabel.Text = sysInfo;
                if app.ItemDuration ~= 0
                    prompt_01 = {'ItemName','ItemDetail'};
                    title_01 = 'KEEP INFO';
                    dims_01 = [1 40];
                    answer_01 = inputdlg(prompt_01,title_01,dims_01);
                    if isempty(answer_01)
                        return;
                    end
                    ansPartOne = answer_01{1};
                    ansPartTwo = answer_01{2};
                    if isempty(ansPartOne) || isempty(ansPartTwo)
                        return;
                    else
                        app.ItemName = ansPartOne;
                        app.ItemDetail = ansPartTwo;
                    end
                    answer_02 = questdlg('Track the Info',...
                        'KEEP INFO','YES','NO','NO');
                    switch answer_02
                        case 'YES'
                            % ����
                            KeepItemInfo(app);
                            ClearKeepInfo(app);
                            
                        case 'NO'
                            % nothing
                    end
                else
                    UpdataSysInfo(app,app.PreSysInfo);
                    %app.SysInfoLabel.Text = app.PreSysInfo;
                end
            end
            
        end

        % Close request function: TickTockUIFigure
        function TickTockUIFigureCloseRequest(app, event)
            % �ر�����
            selection = CloseReq(app);
            if isequal(selection,'Yes')
                % timer stop ���»ص�����
                if ~isempty(timerfind(app.Timer_01))
                    delete(app.Timer_01);
                end
                % �ֶ�ɾ����ʱ��
                delete(timerfind(app.Timer_02));
                delete(timerfind(app.Timer_03));
                delete(timerfindall);
                delete(app);
            else
                return;
            end
            
        end

        % Value changed function: TimerButton
        function TimerButtonValueChanged(app, event)
            %{
                ����ʽ���أ�������Ϊ״̬�ı䣬��״̬�ı�֮����
                Ϊ��ʼ������ʹ�ã�
            %}
            % ��ʼ��֮��value = true;
            value = app.TimerButton.Value;
            state_01 = ["Start","Stop "];
            % ����״̬
            if ~value
                % ������ʱ��״̬��
                app.TimerButton.Text = state_01(1);
                app.Lamp.Color = [0.64 0.08 0.1];
                
                app.EndTick = datestr(datetime('now'),'yy/mm/dd  HH:MM:SS');
                
                if ~isempty(timerfind(app.Timer_02))
                    stop(app.Timer_02);
                end
            else
                app.TimerButton.Text = state_01(2);
                app.Lamp.Color = [0 1 0];
                
                % ֹͣ��ʱ��״̬��
                app.ItemDuration = 0;
                
                app.StartTick = datestr(datetime('now'),'yy/mm/dd  HH:MM:SS');
                start(app.Timer_02);
            end
            
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            defaultPath = 'D:\Codes\MatlabFiles\Blocks\TickTockFiles\';
            logname = 'log.txt';
            fullLog = strcat(defaultPath,logname);
            try
                winopen(fullLog)
            catch
                disp('log open failed')
            end
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create TickTockUIFigure
            app.TickTockUIFigure = uifigure;
            app.TickTockUIFigure.Color = [0.5294 0.8078 0.9216];
            app.TickTockUIFigure.Position = [100 100 640 480];
            app.TickTockUIFigure.Name = 'Tick-Tock';
            app.TickTockUIFigure.CloseRequestFcn = createCallbackFcn(app, @TickTockUIFigureCloseRequest, true);

            % Create TICKTOCKLabel
            app.TICKTOCKLabel = uilabel(app.TickTockUIFigure);
            app.TICKTOCKLabel.HorizontalAlignment = 'center';
            app.TICKTOCKLabel.FontName = 'Arvo';
            app.TICKTOCKLabel.FontSize = 28;
            app.TICKTOCKLabel.FontWeight = 'bold';
            app.TICKTOCKLabel.Position = [236 432 171 49];
            app.TICKTOCKLabel.Text = 'TICK TOCK';

            % Create GMT8EditField
            app.GMT8EditField = uieditfield(app.TickTockUIFigure, 'text');
            app.GMT8EditField.FontName = 'Times';
            app.GMT8EditField.FontSize = 14;
            app.GMT8EditField.FontWeight = 'bold';
            app.GMT8EditField.Position = [99 395 129 22];

            % Create TRACKButton
            app.TRACKButton = uibutton(app.TickTockUIFigure, 'push');
            app.TRACKButton.ButtonPushedFcn = createCallbackFcn(app, @TRACKButtonPushed, true);
            app.TRACKButton.BackgroundColor = [0.9412 0.9412 0.9412];
            app.TRACKButton.FontName = 'Franklin Gothic Medium';
            app.TRACKButton.FontWeight = 'bold';
            app.TRACKButton.Position = [37 17 64 25];
            app.TRACKButton.Text = 'TRACK';

            % Create Lamp
            app.Lamp = uilamp(app.TickTockUIFigure);
            app.Lamp.Position = [173 323 25 25];
            app.Lamp.Color = [0.6392 0.0784 0.1804];

            % Create SysInfoLabel
            app.SysInfoLabel = uilabel(app.TickTockUIFigure);
            app.SysInfoLabel.FontName = '���� Light';
            app.SysInfoLabel.FontWeight = 'bold';
            app.SysInfoLabel.Position = [111 18 369 22];
            app.SysInfoLabel.Text = 'Sys-Info';

            % Create GMT8Label_2
            app.GMT8Label_2 = uilabel(app.TickTockUIFigure);
            app.GMT8Label_2.HorizontalAlignment = 'right';
            app.GMT8Label_2.FontName = 'Times';
            app.GMT8Label_2.FontWeight = 'bold';
            app.GMT8Label_2.Position = [43 395 47 22];
            app.GMT8Label_2.Text = 'GMT+8';

            % Create Label
            app.Label = uilabel(app.TickTockUIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [173 323 25 22];
            app.Label.Text = '';

            % Create TimerButton
            app.TimerButton = uibutton(app.TickTockUIFigure, 'state');
            app.TimerButton.ValueChangedFcn = createCallbackFcn(app, @TimerButtonValueChanged, true);
            app.TimerButton.Icon = 'power_button.png';
            app.TimerButton.Text = 'Timer';
            app.TimerButton.BackgroundColor = [1 1 1];
            app.TimerButton.FontName = 'Microsoft JhengHei UI';
            app.TimerButton.FontColor = [0 0.451 0.7412];
            app.TimerButton.Position = [46 323 100 24];
            app.TimerButton.Value = true;

            % Create UIAxes
            app.UIAxes = uiaxes(app.TickTockUIFigure);
            app.UIAxes.FontSize = 10;
            app.UIAxes.FontWeight = 'bold';
            app.UIAxes.XLim = [0 240];
            app.UIAxes.YLim = [0 0.5];
            app.UIAxes.MinorGridLineStyle = '-';
            app.UIAxes.GridColor = [0.651 0.651 0.651];
            app.UIAxes.GridAlpha = 0.15;
            app.UIAxes.MinorGridColor = [0.651 0.651 0.651];
            app.UIAxes.XColor = [0.8 0.8 0.8];
            app.UIAxes.XTick = [0 30 60 90 120 150 180 210 240];
            app.UIAxes.XTickLabel = {'0'; '30'; '60'; '90'; '120'; '150'; '180'; '210'; '240'};
            app.UIAxes.YColor = [1 1 1];
            app.UIAxes.YTick = [];
            app.UIAxes.YTickLabel = '';
            app.UIAxes.LineWidth = 1;
            app.UIAxes.XGrid = 'on';
            app.UIAxes.XMinorGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.YMinorGrid = 'on';
            app.UIAxes.TitleFontWeight = 'bold';
            app.UIAxes.BackgroundColor = [1 1 1];
            app.UIAxes.Clipping = 'off';
            app.UIAxes.Position = [235 305 363 59];

            % Create Button
            app.Button = uibutton(app.TickTockUIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [514 17 100 25];
            app.Button.Text = '�鿴��־';
        end
    end

    methods (Access = public)

        % Construct app
        function app = TickTock

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.TickTockUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.TickTockUIFigure)
        end
    end
end