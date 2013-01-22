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
    
        % obsid, birdid, day, min, ticks, y, x, speed
        %     1,      2,   3,   4,     5, 6, 7,     8
    
    % sort by time
    ids = str2double(gps(:,1));
    [~,IX] = sort(ids);
    gps = gps(IX, :);
   
    
    extraAttributes = 8;
    
    AppendedData = cell(size(gps, 1), 5 + extraAttributes);
    
    birdIds = str2double(gps(:, 2));
    [birds, IS] = unique(birdIds, 'first');
    [~, IE] = unique(birdIds, 'last');

    cell_times = gps(:, 5);
    times = cell2mat(cell_times);
    
    % Do seperately for each bird
    for i = 1:size(birds)
        birdDataIds = find(birdIds == birds(i));
        
        offsets = times(birdDataIds(2:end)) - times(birdDataIds(1:end-1));
        trajStart = find(offsets > 1/1440); % a trajectory has no interval > 60s
        
        for k = 1:(length(trajStart)-1) % for each trajectory
            if (trajStart(k) + 1 ~= trajStart(k+1))
                chunk_ic = birdDataIds(trajStart(k):(trajStart(k+1)-1));
                
                chunk_times = times(chunk_ic);
                text_speeds = gps(chunk_ic, 8);
                num_speeds = clean_speeds(text_speeds);
                acceleration = diff(num_speeds)./diff(chunk_times);
                %acceleration = gfilter(num_speeds, 2, [0 1])
                
                chunk = gps(chunk_ic,:);
                    
                numericData = str2double(chunk(:, [3 4 6 7]));

                distances = squareform(pdist(numericData(:, [3 4])));
                edgePoints = convhull(numericData(:, [3 4]));
                totalArea = polyarea(numericData(edgePoints, 3), numericData(edgePoints, 4));

                totalDistance = sum(diag(distances, 1));
                directDistance = pdist(numericData([1,end], [3 4]));

                
                totalTime = pdist(chunk_times([1 end])) * 100;
                               
                for j = 2:length(chunk_ic)
                    point = gps(chunk_ic(j), [1 2 3 4 8]);
                                        
                    AppendedData(chunk_ic(j), :) = [point, ...
                        num2str(acceleration(j-1), '%f'), ...
                        num2str(totalArea, '%f'), ...
                        num2str(totalTime, 100), ...
                        num2str(directDistance, '%f'), ...
                        num2str(totalDistance, '%f'), ...
                        num2str(directDistance/totalTime, '%f'), ...
                        num2str(totalDistance-directDistance, '%f'), ...
                        num2str(totalDistance/totalTime, '%f')];
                end
               
            end
        end
        
        % remove empty cells
        empty = cellfun('isempty', AppendedData); 
        AppendedData(all(empty,2),:) = [];
        
    end
   
    header = {'obsID', 'birdID', 'day', 'min', 'speed', ...
       'acceleration', 'area', 'time', 'ab_dist', 'tot_dist', ...
       'movement_time', 'real_dist', 'distance_time'};
    
    WriteCellArrayToFile([header;AppendedData], ...
       '../../data/appended/gps_data_extended.csv', ',');
    
    % ________________________________________________
end

















