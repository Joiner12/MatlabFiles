fprintf('load path...\n');
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks');
end
fprintf('%s\n',pwd)
%% 
%{
    Reference:https://www.zhihu.com/question/27780598/answer/68285791
%}
[x,t] = meshgrid(0:0.1:1,-1:.03:30);
p = (pi/2)*exp(-t/8);
u = 1-(1-mod(3.6*t,2)).^4/2;
y = 2*(x.^2-x).^2.*sin(p);
r = u.*(x.*sin(p)+y.*cos(p));
figure('color','w'),view(70,70),axis image off
surface(r.*cos(t*pi),r.*sin(t*pi),...
    u.*(x.*cos(p)-y.*sin(p)),'EdgeColor','none','FaceColor','r')
light('style','local','pos',[1 -1 3]),lighting gouraud

%%
%{
    Reference:https://www.zhihu.com/question/27780598/answer/601911383
%}
% no usb webcams
camera = webcam; % Connect to the camera
nnet = alexnet; % Load the neural net
while true
    picture = camera.snapshot;             % Take a picture
    picture = imresize(picture,[227 227]); % Resize the picture for alexnet
    label = classify(nnet,picture);        % Classify the picture
    image(picture);      % Show the picture
    title(char(label));  % Show the label
    drawnow;
end