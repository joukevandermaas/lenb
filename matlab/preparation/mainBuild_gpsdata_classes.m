%Areg Shahbazian, 10283234
%file: main.m
%created: 07.01.2013
%last edited: 08.01.2013
function [ output_args ] = mainBuild_gpsdata_classes()
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
    BEHAVIOUR = FileToCells('../../data/raw/behaviour.csv', ',');
    behaviour = CellToNumeric(BEHAVIOUR,1,1);
    
    gps = mainBuild_gpsdata();
    
    %PREDICTORS = FileToCells('../../data/raw/predictors.csv', ',');
    %predictors = CellToNumeric(PREDICTORS, 1, 1);
    
    AppendedData = cell(size(behaviour,1),1);
    % append data to classes
    for i=1:size(behaviour,1)
    %   for every labeled example
        obsID = behaviour{i,1};
        AppendedData{i,1} = obsID;
        nextColumn = 2;
        
        % append gps-data to example
        for j=1:size(gps,1)
            if(strcmp(gps{j,1}, obsID))
                for k=2:size(gps,2)
                    AppendedData{i,nextColumn} = gps{j,k};
                    nextColumn = nextColumn + 1;
                end
                
                break;
            end
        end

        for k=2:size(behaviour,2)
            AppendedData{i,nextColumn} = behaviour{i,k};
            nextColumn = nextColumn + 1;
        end
        
    end
    
    header = {'obsID', 'birdID', 'day', 'min', 'y', 'x', 'speed', ...
        'prevDay', 'prevMin', 'prevY', 'prevX', 'prevSpeed', 'c3', 'c8', 'c16'};
    
    WriteCellArrayToFile([header;AppendedData], '../../data/appended/gps_data_classes.csv', ',');
    
    % ________________________________________________

    
    
    output_args = 1;
end

















