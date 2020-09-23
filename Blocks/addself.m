%% ¿€º”
function [y] = addself(x,step)
    if nargin < 1
        cprintf('error','Parameter error.\n');
    end
    
    if nargin == 1
        y = x + 1;
    end
    
    if nargin ==2 
        y = x + step;
    end
end