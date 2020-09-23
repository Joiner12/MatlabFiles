%% simulator for frog leap down
clc;
global whileCnt;
simudata = cell(0);
for test_i =1:1:1
    pos = zeros(0);
    vels = zeros(0);
    accs = zeros(0);
    p0 = 5; % mm
    acc = 9.8/1e3.*1; % g ¡ú mm/ms^2
    acc_M = acc;
    maxV = 0.5; % mm/ms
    curV = 0;
    remL = p0;
    vel = 0;
    FLAG = false;
    
    whileCnt = 1;
    while true
        curV = vel;
        tarL = remL;
        
        % Trapezoidal velocity planning
        
        [vel,remL] = Mp.Interplt(acc,maxV,curV,tarL,0,1+0.2*(test_i-1));
        % [AccRegulated,EnableFlag] = AccRegulator(CurVel,SetAcc,RemL)
        [acc_M,FLAG] = AccRegulator(curV,acc,tarL);
        % To prevent program from entering " dead circulation "
        pos(whileCnt) = tarL;
        vels(whileCnt) = curV;
        accs(whileCnt) = acc_M;
        whileCnt = whileCnt+1;
        if whileCnt > 1e4 || remL <= 0
            break;
        end
    end
    simudata{test_i,1} = pos;
    simudata{test_i,2} = vels;
    simudata{test_i,3} = accs;
    simudata{test_i,4} = strcat('Îó²îÂÊ:',num2str(1+0.2*(test_i-1)));
end
%%
if false
    tcf('trapezoidal')
    figure('name','trapezoidal');
    subplot(311)
    plot(linspace(1,length(vels),length(vels)),pos)
    ModifyCurFigProperties()
    set(get(gca, 'XLabel'), 'String', 'steps(ms)');
    set(get(gca, 'YLabel'), 'String', 'remL(mm)');
    
    subplot(312)
    plot(linspace(1,length(pos),length(pos)),vels)
    ModifyCurFigProperties()
    set(get(gca, 'XLabel'), 'String', 'steps(ms)');
    set(get(gca, 'YLabel'), 'String', 'velocity(mm/ms)');
    
    subplot(313)
    plot(linspace(1,length(accs),length(accs)),accs)
    ModifyCurFigProperties()
    set(get(gca, 'XLabel'), 'String', 'steps(ms)');
    set(get(gca, 'YLabel'), 'String', 'acc(mm/ms^2)');
end


%%
tcf('trapezoidal')
figure('name','trapezoidal');
subplot(311)
for i=1:1:length(simudata)
    data_1 = simudata{i,1};
    plot(data_1)
    hold on
end
hold off
ModifyCurFigProperties()
legend(simudata{:,4})
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'remL(mm)');

subplot(312)
for i=1:1:length(simudata)
    data_1 = simudata{i,2};
    plot(data_1)
    hold on
end
hold off
ModifyCurFigProperties()
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'velocity(mm/ms)');
legend(simudata{:,4})
subplot(313)
for i=1:1:length(simudata)
    data_1 = simudata{i,3};
    plot(data_1)
    hold on
end
hold off
ModifyCurFigProperties()
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'acc(mm/ms^2)');
legend(simudata{:,4})
