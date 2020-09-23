%% 蛙跳撞板问题数据分析
clc;
touchD  = TOUCH;
normalD = NORMAL;

%% 
%{
typedef struct
{
    u8 nState;
    u8 nReserve;
    u16 nCapHeight;
    short nInterpUnitV;
    short nMoveL;
    short nFollowPidUnitV;
}FrogMotionMonitor;
%}

clc;
CurDataStr = normalD;
CurDataCell = cell(length(CurDataStr),1);
for i=1:1:length(CurDataStr)
    strLine = CurDataStr(i);
    charLine = string2chars(strLine);
    charLine = strrep(charLine,' ','');
    charLine = strrep(charLine,'6610550D','');
    % data =[nState(1),nReserve(1),nCapHeight(2),nInterpUnitV(2),nMoveL(2),nFollowPidUnitV(2)];
    %eg_1 = '00009400000000001400245B';
    signs = [false,false,false,true,true,true];
    % row 1
    charsTemp = charLine(1:2);
    val_1 = SignHex2Dec(charsTemp,false);

    % row 2
    charsTemp = charLine(3:4);
    val_2 = SignHex2Dec(charsTemp,false);

    % row 3
    charsTemp = [charLine(7:8),charLine(5:6)];
    val_3 = SignHex2Dec(charsTemp,false);
    
    % row 4
    charsTemp = [charLine(11:12),charLine(9:10)];
    val_4 = SignHex2Dec(charsTemp,false);

    % row 5
    charsTemp = [charLine(13:14),charLine(15:16)];
    val_5 = SignHex2Dec(charsTemp,true);

    % row 6
    charsTemp = [charLine(19:20),charLine(17:18)];
    val_6 = SignHex2Dec(charsTemp,true);
    
    Cols = [val_1,val_2,val_3,val_4,val_5,val_6];
    CurDataCell{i,:} = Cols;
end

%% cell2mat
NormalDataMat  = cell2mat(CurDataCell);