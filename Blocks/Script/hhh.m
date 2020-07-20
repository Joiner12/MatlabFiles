function hhh()
%{
    Description of the script:
    1.replace of winopen(pwd)
%}
if false
    indexs = input('1.winopen(pwd)|2.loading');
    switch indexs
        case 1
            winopen(pwd);
            fprintf('winopen %s\n',pwd);
        otherwise
            fprintf('loading...\n');
    end
else
    winopen(pwd);
end
end