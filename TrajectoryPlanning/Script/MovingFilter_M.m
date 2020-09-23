%{
    »¬¶¯ÂË²¨Æ÷º¯Êý
    @func moving filter
%}
function [dataStack,curOut] =  MovingFilter_M(dataStack,curIn,varargin)
    if nargin == 2
        dataStackTemp = reshape(dataStack,[1,length(dataStack)]);
        dataStack = [dataStackTemp(2:end),curIn];
        curOut = sum(dataStack)/length(dataStack);
    else
        % reserve function
        % remove max values slider scope
        error('reserve function,maybe u should check code,my bro\n');
    end
end