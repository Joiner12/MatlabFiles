% sript path
% clc;
% Scriptpath = 'H:\MatlabFiles\���ж���\Scripts';
% if ~isequal(Scriptpath,pwd)
%     cd(Scriptpath)
% end
%  fprintf('script path : %s\n',pwd);

classdef NN_R1
    properties
        line_one = [];
        line_two = [];
        to = [];
        fs = 10;
    end

    methods 
        % ���캯��
        function obj = NN_R1(datas)
            disp('construction called')
            obj.line_one = datas(1);
            obj.line_two = datas(2);
            fprintf("%d\t%d\n",obj.line_one,obj.line_two);
        end
        
        function obj = handle(obj)
            disp('handle function called')
            obj.to = linspace(1,10,10);
            fprintf("%d,%d\n",obj.fs,10001);
        end
    end
    %{
        %% ����Input����
        prom = "what the f**k::";
        x = input(prom);
        if isempty(x)
            disp("nothing got in ")
        else
            fprintf("%s\n",string(x))
        end
    %}
end