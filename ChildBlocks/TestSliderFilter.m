%% test block of sliderfilter
clc;clear;
datasIn = ones(1000,1);
datasOut = zeros(1000,1);

for i=1:1:length(datasIn)
    sliderscope = 50;
    datasOut(i) = SliderFilter(datasIn(i),sliderscope,i);
end

figure
plot(datasIn)
hold on 
plot(datasOut)
grid on