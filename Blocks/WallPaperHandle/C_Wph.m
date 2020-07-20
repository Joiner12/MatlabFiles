% modify  wallpaper
classdef C_Wph
    methods (Static)
        function [DegRow,DegCol] = deltaFigure(A)
            % ͼ��mat��� rgb
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
            
            % ���ݶ�
            for i=1:1:size_a(1)
                DegRow(i,:) = diff(Atemp(i,:));
            end
            % ���ݶ�
            for j = 1:1:size_a(2)
                DegCol(:,j) = diff(Atemp(:,j));
            end
            
        end
    end
end