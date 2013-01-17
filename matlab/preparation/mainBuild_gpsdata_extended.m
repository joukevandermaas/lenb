%Jouke van der Maas, 10186883
%file: main.m
%created: 15.01.2013
%last edited: 15.01.2013
function AppendedData = mainBuild_gpsdata_extended()
%MAIN 
%   This function takes the gps-dataset and adds columns
%   for the previous datapoint's data.

    GPS = FileToCells('../../data/raw/gps.csv', ',');
    % delete row_names column
    GPS(:,1) = [];
    gps = CellToNumeric(GPS, 1,1);
        % obsid, birdid, day, min, y, x, speed
        %     1,      2,   3,   4, 5, 6,     7
    
    % sort by time
    ids = str2double(gps(:,1));
    [~,IX] = sort(ids);
    gps = gps(IX, :);
    
    AppendedData = cell(size(gps, 1), 7);
    radius = 3;
    
    birdIds = str2double(gps(:, 2));
    [birds, IS] = unique(birdIds, 'first');
    [~, IE] = unique(birdIds, 'last');
    
    for i = 1:size(birds)
        birdDataIds = find(birdIds == birds(i));
        
        for j = radius+1:(size(birdDataIds, 1)-radius)
            point = gps(birdDataIds(j), [1 2 3 4 7]);
            
            chunk = gps(birdDataIds((j-radius):(j+radius)),:);
            numericData = str2double(chunk(:, 3:7));
            
            distances = squareform(pdist(numericData(:, [3 4])));
            totalDistance = sum(diag(distances, 1));
            
            times = numericData(:, [1 2]);
            days = times(:, 1);
            mins = times(:, 2);
            days = (days - days(1)) * 1440; % 1440 minutes per day
            properTimes = days + mins;
            diff = pdist(properTimes);
            totalTime = diff(2 * radius);
                        
            AppendedData(birdDataIds(j), :) = [point, totalDistance/totalTime, totalDistance];
        end
        
    end
   
    % remove empty cells for each bird
    for i = size(birds):-1:1
       AppendedData((IE(i)-radius+1):IE(i), :) = [];
       AppendedData(IS(i):(IS(i)+radius-1), :) = [];
    end
    
    header = {'obsID', 'birdID', 'day', 'min', 'speed', ...
        'trajectory', 'distance'};
    
    WriteCellArrayToFile([header;AppendedData], ...
        '../../data/appended/gps_data_extended.csv', ',');
    
    % ________________________________________________
end

















