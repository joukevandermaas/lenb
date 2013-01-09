%Areg Shahbazian, 10283234
%file: main.m
%created: 07.01.2013
%last edited: 08.01.2013
function [ output_args ] = main()
%MAIN 
%   This function rewrites the data for classification and for use in WEKA.
%   -Functions used: WriteCellArrayToFile.m, strMemberOfARR.m, StringToNumeric.m,
%       read_mixed_csv.m, FileToCells.m, DayOfYear.m, CellToNumeric.m
%   -Numeric values are copied
%   -Discrete string values are made numeric
%   -Values in date_time format 'yyyy-mm-dd hh:mm:ss' are split into 'day' and 'minute'
%   -'NA' is rewritten as '?'

    % read and rewrite data
    % ________________________________________________
    BEHAVIOUR = FileToCells('../../data/raw/behaviour.csv', ',');
    behaviour = CellToNumeric(BEHAVIOUR);
    % write to file
    WriteCellArrayToFile(behaviour, '../../data/numeric/numeric_behaviour.csv', ',');
    
    GPS = FileToCells('../../data/raw/gps.csv', ',');
    % delete row_names column
    GPS(:,1) = [];
    gps = CellToNumeric(GPS);
    % write to file
    WriteCellArrayToFile(gps, '../../data/numeric/numeric_gps.csv', ',');
    
    PREDICTORS = FileToCells('../../data/raw/predictors.csv', ',');
    predictors = CellToNumeric(PREDICTORS);
    % write to file
    WriteCellArrayToFile(predictors, '../../data/numeric/numeric_predictors.csv', ',');
    
    HABITAT = FileToCells('../../data/raw/habitat.csv', ',');
    habitat = CellToNumeric(HABITAT);
    % write to file
    WriteCellArrayToFile(habitat,'../../data/numeric/numeric_habitat.csv', ',');
    
    MODEL_OUTPUT = FileToCells('../../data/raw/model_output.csv', ',');
    model_output = CellToNumeric(MODEL_OUTPUT);
    WriteCellArrayToFile(model_output,'../../data/numeric/numeric_model_output.csv', ',');
    % ________________________________________________


    % read and rewrite data
    % ________________________________________________
    
    
    
    
    
    % ________________________________________________
    
    
    output_args = 1;
end

















