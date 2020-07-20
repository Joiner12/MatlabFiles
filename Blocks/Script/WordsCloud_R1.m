%% 
clc;
ScriptPath = 'D:\Codes\MatlabFiles\Blocks\';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath)
end
fprintf('����·��:%s\n',pwd);

%%
%{
    ���˼·��
    1.����ָ
    2.���ƣ�
%}
clc;
file ='C:\Users\10520\Desktop\word.txt';
DrawWordsCloud(file)


%% 
%{
    @parameters:word :�ַ������� 
    @fullfile:����.txt
%}
function DrawWordsCloud(fullfile)
    fprintf('��ͼ�������\n');
    tic
    repCharters_1 = ["." "?" "!" "," ";" ":" "��" "(" "}" ")" "{"];
    repCharters_2 = ["�ظ�" "����" "|"];
    gbkCharters_1 = ["��" "��" "/" "��" "��" "��" "��" "��" "��"];
    if 0
        %���һ�ٵ�try catch����
        try
            content = fileread(fullfile);
        catch
            disp('ԭʼ���ݴ���')
        end
    else
        content = fileread(fullfile);
        content_str = string(content);
        content_str = replace(content_str,[repCharters_1 repCharters_2 gbkCharters_1]," ");
        % ���ַ����ֽ���ַ�������
        words = split(join(content_str));
        words(strlength(words) < 1) = [];
        draw_words = categorical(words);
        figure
        wordcloud(draw_words);
    end
    toc
end