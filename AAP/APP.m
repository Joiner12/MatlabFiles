%% Auto Adjust Pid Parameters
clc 
close all 

if 0
    ITAE = zeros(0);
    Sigma = zeros(0);


    KP = 0;KI = 0;KD = 0;
    Counter_01 = 1;
    FunctionCoumter_01 = 0;


    for p = 20:2:100
        KP = p;
        for i = 1:2:50
            KI = i;
            for d = 1:5:100
                [ITAE(Counter_01),Sigma(Counter_01)] = model_01(KP,KI,KD);
                Counter_01 = Counter_01 + 1; 
            end
        end
    end
    warning('output is coming')
    figure(1)
    scatter(ITAE,Sigma,'r','filled')
    title('ITAE && Sigma')
    xlabel('ITAE');ylabel('Sigma')
    grid on 


    figure(2)
    plot(ITAE,Sigma,'r*')
    title('ITAE && Sigma')
    xlabel('ITAE');ylabel('Sigma')
    grid on 

end
% figure(3)
% plot3()

warning('updata file path')