%Areg Shahbazian, 10283234
%file: main.m
%created: 07.01.2013
%last edited: 08.01.2013
%function [ output_args ] = mainBuild_gpsdata_extended_classes()
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
    
    %gps = mainBuild_gpsdata_extended();
    
    %PREDICTORS = FileToCells('../../data/raw/predictors.csv', ',');
    %predictors = CellToNumeric(PREDICTORS, 1, 1);
    
    AppendedData = cell(size(behaviour,1),10);
    % append data to classes
    ids = str2double(behaviour(:, 1));
    gpsIds = str2double(gps(:, 1));
    
    for i = 1:length(ids)
       j = find(gpsIds == ids(i));
       AppendedData(i, :) = ...
           [gps(j, :), behaviour(i, 2:4)];
    end
    
    header = {'obsID', 'birdID', 'day', 'min', 'speed', ...
        'trajectory', 'distance', 'c3', 'c8', 'c16'};
    
    WriteCellArrayToFile([header;AppendedData], '../../data/appended/gps_data_extended_classes.csv', ',');
    
    % ________________________________________________

    
    
    output_args = 1;
%end

















