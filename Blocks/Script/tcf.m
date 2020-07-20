%% try to close figure open
function tcf(varargin)
% varargin is cell
if isequal(length(varargin),0)
    close all;
    fprintf('all figures closed\n')
else
    try
        for i=1:1:length(varargin)
            close(varargin{i});
            fprintf('%s closed.\n',varargin{i});
        end
        %             fprintf('close figure')
    catch
    end
end
end