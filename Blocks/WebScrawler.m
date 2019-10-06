clc;
clear;
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks')
end
fprintf('Reload path: \t%s\n',pwd);
%%
%{
    ��ҳ���棬������ʽ
%}
clc;clear;
tic;
try
    url_daily = 'http://www.dailyenglishquote.com/';
    options = weboptions('RequestMethod','get','CharacterEncoding','UTF-8',...
        'Timeout',5);
    strf = webread(url_daily,options);
    % [1]��ȡ����<p> </p>
    strf_3 = regexp(strf,'<(p).*?>.*?</\1>','match');
    if ~isempty(strf_3) && length(strf_3) > 4
        head = randi(int32((length(strf_3) - 4))/2 - 1) ;
        strf_4 = strf_3(head*2+1:head*2 + 2);
        strf_4 = regexprep(strf_4,'&#\d{4};','');
        en_char = regexp(strf_4{1},'(?<=(<span .*?>)|(<strong .*?>))(.*?)(?=(</span>)|(</strong>))','match')
        zh_char = regexp(strf_4{2},'(?<=<p>)(.*?)(?=</p>)','match')
        % �ض� ����22
        cutzh_char = {};
        cuten_char = {};
        if length(zh_char) > 22
            
        end
        if length(cuten_char) > 25
        end
        asn = {char(en_char);char(zh_char)}
    end
    
catch EM
    EM.identifier
end

if false
    tarFile = 'C:\Users\10520\Desktop\daily.txt';
    websave(tarFile,url_daily);
    fprintf('��ҳʱ�䣺%4d\n',toc);
end
toc
%%
% ʹ�ñ���ƥ����ȡ<p>
clc;
% expression_3 = '<(\w+).*?>.*?</\1>';
expression_3 = '<(p).*?>.*?</\1>';
strf_3 = regexp(strf,expression_3,'match');
for i=1:1:length(strf_3)
    strf_3(i)
end
%%
clc;
strf_4 = strf_3(3:4)
strf_4 = regexprep(strf_4,'&#\d{4};','')
en_char = regexp(strf_4{1},'(?<=(<span .*?>)|(<strong .*?>))(.*?)(?=(</span>)|(</strong>))','match')
zh_char = regexp(strf_4{2},'(?<=<p>)(.*?)(?=</p>)','match')


%%
clc;
for i=1:1:length(strf_3)
    strf_3(i)
end

%% decide box size
%{
  �ضϵķ�ʽʵ��
%}
clc;
clear;
if true
    % �����ַ��ض�
    cutEn = {};
    cutZn = {};
    zh_char = '��������Ҷ����������ᶯҡ�ң�ֻҪ��������ߣ�����֮���������ã��� �� �� �� �� �� �ұ��޴���ȥ';
    en_char = 'It''s a shot in the dark but I''ll make itKnow with all of your heart, you can''t shame meWhen I am with you, there''s no place I''d rather be';
    if length(char(zh_char)) > 22
        cntLen = int32(length(zh_char)/22);
        cutZn = cell(cntLen+1,1);
        for i = 1:1:cntLen+1
            if i*22 < length(zh_char)
                cutZn{i,1} =  zh_char(22*(i-1)+1:22*i);
            else
                cutZn{i,1} =  zh_char(22*(i-1)+1:end);
            end
        end
    end
    
    % Ӣ�Ľض�
    if length(char(en_char)) > 24
        cntLen = int32(length(en_char)/24);
        cutEn = cell(cntLen+1,1);
        for i = 1:1:cntLen+1
            if i*24 < length(en_char)
                cutEn{i,1} =  en_char(24*(i-1)+1:24*i);
            else
                cutEn{i,1} =  en_char(24*(i-1)+1:end);
            end
        end
    end
    cntTemp = 1;
    nono = {};
    if isempty(cutEn)
        EnTemp = char(en_char);
    else
        EnTemp = char(cutEn);
        for i = 1:1:length(EnTemp)
             cntTemp = cntTemp + 1;
             nono{cntTemp} =  EnTemp(i);
        end
    end
    
    if isempty(cutZn)
        ZnTemp = char(zn_char);
    else
        for i = 1:1:length(ZnTemp)
             cntTemp = cntTemp + 1;
             nono(cntTemp) =  ZnTemp(i);
        end
    end
    nono
end

%%

