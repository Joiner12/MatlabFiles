% sript path
clc;
Scriptpath = 'H:\MatlabFiles\Blocks';
if ~isequal(Scriptpath,pwd)
    cd(Scriptpath)
end
 fprintf('script path : %s\n',pwd);
%% WORD CLOUD
%{
    ���˼·��
    1.*.txt�ṩ��Դ��
    2.ʹ�� 
%}
clc;clear;
punccharacters_1 = ["{","}","//","/","*","|","(",")","."];
punccharacters_2 = [">","&",";","-","+","%","=",",",":","#"];
% fileread():��������string��ʽ����
filename = "C:\Users\Whtest\Desktop\kalman.txt";
% filename = "C:\Users\Whtest\Desktop\devilorangel.txt";
contens_str = string(fileread(filename));
content_1 = replace(contens_str,[punccharacters_1,punccharacters_2]," ");
% ��ά�ַ������ӣ����ַ������տո���Ϊһά�ַ�������
content_2 = split(join(content_1));
% ɾ�����ַ���
content_2(strlength(content_2) < 5) = [];
% �������飬ɾ���ظ��ַ����Ĺ���
text_final = categorical(content_2);

figure(1)
wordcloud(text_final)
