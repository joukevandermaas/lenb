%Jouke van der Maas, 10186883
%file: main.m
%created: 15.01.2013
%last edited: 15.01.2013
function AppendedData = mainBuild_gpsdata()
%MAIN 
%   This function takes the gps-dataset and adds columns
%   for the previous datapoint's data.

    GPS = FileToCells('../../data/raw/gps.csv', ',');
    % delete row_names column
    GPS(:,1) = [];
    gps = CellToNumeric(GPS, 1,1);
    
    % sort by time
    ids = str2double(gps(:,1));
    [~,IX] = sort(ids);
    gps = gps(IX, :);
    
    AppendedData = cell(size(gps, 1), 12);
    
    birdIds = str2double(gps(:, 2));
    [birds, IA] = unique(birdIds, 'first');
    for i = 1:size(birds)
        birdDataIds = find(birdIds == birds(i));
        
        % add gps data to gps data of previous point
        previds = birdDataIds(1:end-1);
        currids = birdDataIds(2:end);
        
        AppendedData(currids, :) = [gps(currids, :), ...
                gps(previds, 3:end)];
    end
   
    % remove first (empty) cell for each bird
    AppendedData(IA, :) = [];
       
    header = {'obsID', 'birdID', 'day', 'min', 'y', 'x', 'speed', ...
        'prevDay', 'prevMin', 'prevY', 'prevX', 'prevSpeed'};
    
    WriteCellArrayToFile([header;AppendedData], ...
        '../../data/appended/gps_data.csv', ',');
    
    % ________________________________________________
end

















