%Areg Shahbazian, 10283234
%file: main.m
%created: 07.01.2013
%last edited: 08.01.2013
function mainAppend_GPS_PRED_BEH_all()
%MAIN 
%   This function rewrites the data for classification and for use in WEKA.
%   -Functions used: WriteCellArrayToFile.m, strMemberOfARR.m, StringToNumeric.m,
%       read_mixed_csv.m, FileToCells.m, DayOfYear.m, CellToNumeric.m
%   -Numeric values are copied
%   -Discrete string values are made numeric
%   -Values in date_time format 'yyyy-mm-dd hh:mm:ss' are split into 'day' and 'minute'
%   -'NA' is rewritten as '?'

    % append gps and predictors data to behaviour classes
    % ________________________________________________
    %BEHAVIOUR = FileToCells('../../data/raw/behaviour.csv', ',');
    %behaviour = CellToNumeric(BEHAVIOUR,1,1);
    
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

















