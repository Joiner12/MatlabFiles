% modify  wallpaper
classdef C_Wph
    methods (Static)
        function [DegRow,DegCol] = deltaFigure(A)
            % 图像mat检测 rgb
            size_a = size(A);
            DegRow = zeros(0);
            DegCol = DegRow;
            % rgb2gray
            try
                if isequal(size_a(3),3)
                    Atemp = rgb2gray(A);
                end
            catch
                Atemp = A;
            end
            
            % 行梯度
            for i=1:1:size_a(1)
                DegRow(i,:) = diff(Atemp(i,:));
            end
            % 列梯度
            for j = 1:1:size_a(2)
                DegCol(:,j) = diff(Atemp(:,j));
            end
            
        end
    end
end