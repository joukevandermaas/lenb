%Jouke van der Maas, 10186883
%file: main.m
%created: 15.01.2013
%last edited: 15.01.2013
function [AppendedData, header] = mainBuild_gpsdata_extended()
%MAIN 
%   This function takes the gps-dataset and adds columns
%   for the previous datapoint's data.
    addpath('attributes');
    
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
    
    extraAttributes = 8;
    
    AppendedData = cell(size(gps, 1), 5 + extraAttributes);
    radius = 3;
    
    birdIds = str2double(gps(:, 2));
    [birds, IS] = unique(birdIds, 'first');
    [~, IE] = unique(birdIds, 'last');
    
    for i = 1:size(birds)
        birdDataIds = find(birdIds == birds(i));
        
        text_speeds = gps(birdDataIds,7);
        num_speeds = clean_speeds(text_speeds);
        acceleration = gfilter(num_speeds, 2, [0 1]);
        
        for j = radius+1:(size(birdDataIds, 1)-radius)
            point = gps(birdDataIds(j), [1 2 3 4 7]);
            
            chunk = gps(birdDataIds((j-radius):(j+radius)),:);
            
            numericData = str2double(chunk(:, 3:6));
            
            distances = squareform(pdist(numericData(:, [3 4])));
            edgePoints = convhull(numericData(:, [3 4]));
            totalArea = polyarea(numericData(edgePoints, 3), numericData(edgePoints, 4));
                        
            totalDistance = sum(diag(distances, 1));
            directDistance = diag(distances, 2*radius);
            
            times = numericData(:, [1 2]);
            days = times(:, 1);
            mins = times(:, 2);
            days = (days - days(1)) * 1440; % 1440 minutes per day
            properTimes = days + mins;
            diff = pdist(properTimes);
            totalTime = diff(2 * radius);
            
            AppendedData(birdDataIds(j), :) = [point, ...
                num2str(acceleration(j), '%f'), ...
                num2str(totalArea, '%f'), ...
                num2str(totalTime, '%d'), ...
                num2str(directDistance, '%f'), ...
                num2str(totalDistance, '%f'), ...
                num2str(directDistance/totalTime, '%f'), ...
                num2str(totalDistance-directDistance, '%f'), ...
                num2str(totalDistance/totalTime, '%f')];
        end
        
    end
   
    % remove empty cells for each bird
    for i = size(birds):-1:1
       AppendedData((IE(i)-radius+1):IE(i), :) = [];
       AppendedData(IS(i):(IS(i)+radius-1), :) = [];
    end
    
    header = {'obsID', 'birdID', 'day', 'min', 'speed', ...
        'acceleration', 'area', 'time', 'ab_dist', 'tot_dist', ...
        'movement_time', 'real_dist', 'distance_time'};
    
    WriteCellArrayToFile([header;AppendedData], ...
        '../../data/appended/gps_data_extended.csv', ',');
    
    % ________________________________________________
end

















