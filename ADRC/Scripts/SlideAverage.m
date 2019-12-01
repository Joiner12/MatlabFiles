function  out=SlideAverage(x,space)
out=zeros(0);
size_X = length(x);
    for k=1:1:size_X
            if k<space
                out(k)=x(k);
            else
                out(k)=(mean(out(k-space+1:1:k-1))+x(k))/2;
            end
    end
end