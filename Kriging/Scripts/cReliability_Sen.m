clc
clear 
load dmodel2;
AKmodel = dmodel2;
format long 
Para1=[0.05,0.043,0.035,0.032,1,1000,2E11];
Para2=0.0045*[0.05,0.043,0.035,0.032,1,1000,2E11];
distribution = {'norm','norm','norm','norm','norm','norm','norm'};
Nx=length(Para1);
Nt=1e2;  

thresh = 0.0125;
%MCS Globle Sensitivity
Dp2 = sobolset(2*Nx,'Skip',1e3,'Leap',1e2);
for n = 0:19
    for i=1:Nx
        AA{n+1,1}(:,i) = icdf(distribution{i},Dp2(n*5E4+1:(n+1)*5E4,i),Para1(i),Para2(i));
        BB{n+1,1}(:,i) = icdf(distribution{i},Dp2(n*5E4+1:(n+1)*5E4,Nx+i),Para1(i),Para2(i));
    end
end
save AA.mat AA
save BB.mat BB

% load AA.mat
% load BB.mat


AAa = zeros(Nt,Nx);
BBb = zeros(Nt,Nx);
for n = 0:19
    AAa(n*5E4+1:(n+1)*5E4,:) = AA{n+1,1};  
    BBb(n*5E4+1:(n+1)*5E4,:) = BB{n+1,1};  
end
DAA = AAa;
DBB = BBb;
[Ay]=g(DAA);
[By]=g(DBB);
NumAR = ((thresh - Ay)>0);
NumBR = ((thresh - By)>0);

M_R = mean(NumAR+NumBR)/2;
for i=1:Nx
    clear DC NumCR 
    DC = DAA;
    DC(:,i) = DBB(:,i);
    [Cy]=g(DC);
    NumCR = ((thresh -Cy)>0);
    
    MCS_Gol_S(i) = mean(NumBR.*(NumCR - NumAR))/(M_R*(1-M_R));
    MCS_Gol_ST(i) = mean((NumAR-NumCR).^2)/2/(M_R-M_R^2);
end
MCS_Gol_S;
MCS_Gol_ST;

%Kri Globle Sensitivity
for n = 0:19
       [KYA] = predictor(AA{n+1,1}, dmodel2);
       KYAA(n*5E4+1:(n+1)*5E4,1) = KYA;
       [KYB] = predictor(BB{n+1,1}, dmodel2);
       KYBB(n*5E4+1:(n+1)*5E4,1) = KYB;  
end

NumKAR = ((thresh -KYAA)>0);
NumKBR = ((thresh -KYBB)>0);
KM_R = mean(NumKAR+NumKBR)/2;
for i = 1:Nx
    clear IRC
    for n = 0:19
        clear KC KYC
        KC = AA{n+1,1};
        KC(:,i) = BB{n+1,1}(:,i);
        [KYC] = predictor(KC, dmodel2);
        KYCC(n*5E4+1:(n+1)*5E4,1) = KYC;
    end
    NumKCR = ((thresh-KYCC)>0);
    Kri_Gol_S(i) = mean(NumKBR.*(NumKCR - NumKAR))/(KM_R*(1-KM_R));
    Kri_Gol_ST(i) = mean((NumKAR-NumKCR).^2)/2/(KM_R-KM_R^2); 
end
Kri_Gol_S;
Kri_Gol_ST;
%%  以上是全局灵敏度
%%  以下是局部灵敏度
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MCS Local Sensitivity
MCS_RR = M_R;
NumRR = [NumAR;NumBR];
Xtt = [AAa;BBb];
for i = 1:Nx
    MCS_Loc_Mu(i) = mean(NumRR.*(Xtt(:,i) - Para1(i))./Para2(i)^2);
    MCS_Loc_Mu(i) = MCS_Loc_Mu(i)*Para2(i)/MCS_RR;
    MCS_Loc_Sigma(i) = mean(NumRR.*(((Xtt(:,i) - Para1(i))./Para2(i)).^2 - 1)./Para2(i));
    MCS_Loc_Sigma(i) = MCS_Loc_Sigma(i)*Para2(i)/MCS_RR;
end
MCS_Loc_Mu;
MCS_Loc_Sigma;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kriging Local Sensitivity
KM_RR = KM_R;
NumRKri = [NumKAR;NumKBR];

for i = 1:Nx
    Kri_Loc_Mu(i) = mean(NumRKri.*(Xtt(:,i) - Para1(i))./Para2(i)^2);
    Kri_Loc_Mu(i) = Kri_Loc_Mu(i)*Para2(i)/KM_RR;
    Kri_Loc_Sigma(i) = mean(NumRKri.*(((Xtt(:,i) - Para1(i))./Para2(i)).^2 - 1)./Para2(i));
    Kri_Loc_Sigma(i) =Kri_Loc_Sigma(i)*Para2(i)/KM_RR;
end
Kri_Loc_Mu;
Kri_Loc_Sigma;


M_R
KM_R

MCS_Gol_S
Kri_Gol_S

MCS_Gol_ST
Kri_Gol_ST

MCS_Loc_Mu
Kri_Loc_Mu

MCS_Loc_Sigma
Kri_Loc_Sigma