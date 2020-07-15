classdef  CurveFitting
    methods (Static)
        function [m,b,func] = OrdinaryLS(x,y)
            if ~isequal(length(x),length(y))
                error('length of input not the same size');
            end
            
            if length(x) <= 1 || length(y) <= 1
                warning('not enough data ')
                return;
            end
            
            mTemp = sum(x.^2)*sum(y) - sum(x)*sum(x.*y);
            denTemp = (length(x)*sum(x.^2) - pow2(sum(x),2));
            m = mTemp./denTemp;

            bTemp = sum(x)*sum(y)*length(x) - sum(x)*sum(x.*y);
            b = bTemp./denTemp;

            func = @(m,b,x)m*x+b;
        end
    end
end