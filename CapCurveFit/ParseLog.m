%% ×Ö·û´®½âÎö
function Value = ParseLog(OriginStr)
    strtemp = char(strrep(strrep(OriginStr,"66 10 55 0D ","")," ",""));
    
    % part 1
    Cpart_1 = strtemp(1:4);
    Cpart_1 = StrFlipping(Cpart_1);
    value_1 = SigHex2Dec(Cpart_1);

    % part 2
    Cpart_2 = strtemp(5:12);
    Cpart_2 = StrFlipping(Cpart_2);
    value_2 = SigHex2Dec(Cpart_2);
    
    % part 3 
    Cpart_3 = strtemp(13:20);
    Cpart_3 = StrFlipping(Cpart_3);
    value_3 = SigHex2Dec(Cpart_3);

    Value=[value_1,value_2,value_3];
end

function val = SigHex2Dec(hexstr)
    if ~ischar(hexstr)
        val = 0;
        return;
    end

    hexstr = strrep(hexstr,' ','');
    decValTemp = hex2dec(hexstr);
    maxDec = 2^(length(hexstr)*4 - 1);
    if decValTemp > maxDec
        val = decValTemp - 2*maxDec;
    else
        val = decValTemp;
    end
end

function Fstr = StrFlipping(Ostr)
    strtemp = strrep(Ostr,' ','');
    strlen = length(strtemp);
    if isequal(strlen,4)
        Fstr = [strtemp(strlen-1:strlen),strtemp(1:strlen/2)];
    elseif isequal(strlen,8)
        % Cpart_7 = [Cpart_7(7:8),Cpart_7(5:6),Cpart_7(3:4),Cpart_7(1:2)];
        Fstr = [strtemp(strlen-1:strlen),strtemp(strlen/2+1:strlen/2+1)... 
        strtemp(strlen/2-1:strlen/2),strtemp(1:strlen/4)];
    else
        Fstr = strtemp;
    end
    return 
end