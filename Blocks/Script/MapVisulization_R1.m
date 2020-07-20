%% Map Visualization 
clc;
latSeattle = 38.1;
lonSeattle = 105;
latAnchorage = 30.12;
lonAnchorage = 105;

try 
    close('geo_1')
catch
    fprintf('no such figure opened\n');
end

geo_1 = figure();
geo_1.Name = 'geo_1';
g1 = geoplot([latSeattle latAnchorage],[lonSeattle lonAnchorage]);
% set properties of lines
g1.LineWidth = 2;g1.Color = 'g';g1.LineStyle = '-.';
L1 = line([-10 10], [0 30], 'Color', 'b', 'LineWidth', 1.2, 'LineStyle', '-');
% geobasemap('colorterrain')