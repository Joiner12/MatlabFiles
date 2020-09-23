function LPF=LowPassFilterFun(x,cof)
    sizeVct=length(x);
    if ~isvector(x)
        error('input must be a vector')
    elseif sizeVct<2
        error('length of vector is too short')
    else
%         对cof进行限制
        if cof>1 || cof<0
            cof=1;
        end
%         sprintf('%0.2f',cof);
%      low pass filter main block 
        LPF=zeros(0);
        for k=1:1:sizeVct
            if k<2
                LPF(k)=x(k);
            else
                LPF(k)=cof*x(k)+(1-cof)*LPF(k-1);
            end
        end
    end
    plot(x)
    hold on 
    plot(LPF)
    grid on 
    title('Filter vs No Filter')
    legend('NoFilter','Filter')
    
end