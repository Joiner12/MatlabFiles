%% Path
clc;
if ~isqual('H:\MatlabFiles\ADRC\Scripts',pwd)
    cd H:\MatlabFiles\ADRC\Scripts
end
fprintf('load path...\n%s\n',pwd);

%% 
%{
    explore gaussian white noise
%}
clc;
noiseGWN = wgn(1000,1,0);
noiseGWNSort = sort(noiseGWN);

close all
shg;
figure(1)
subplot(221)
plot(noiseGWN)
legend('‘≠ º')
set(get(gca, 'title'), 'String','gaussian white noise');

subplot(222)
y1 = fft(noiseGWN,length(noiseGWN));
y1 = y1.*conj(y1);
plot(y1(1:int32(length(y1)/2)))
set(get(gca, 'title'), 'String','power spectrum');

subplot(223)
histogram(noiseGWN,100)
set(get(gca, 'title'), 'String', 'distrubuce');

subplot(224)
plot(noiseGWNSort)
set(get(gca, 'title'), 'String', 'gwn÷ÿ≈≈–Ú');
set(get(gca,'gridminoralpha'),'String','on')

