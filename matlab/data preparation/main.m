%Areg Shahbazian, 10283234
%file: main.m
%created: 07.01.2013
%last edited: 08.01.2013
function [ output_args ] = main()
%MAIN 
%   This function rewrites the data for classification and for use in WEKA.
%   -Numeric values are copied
%   -Discrete string values are made numeric
%   -Values in date_time format 'yyyy-mm-dd hh:mm:ss' are 
%   -'NA' is rewritten as '?'

    BEHAVIOUR = FileToCells('../../data/behaviour.csv', ',');
    behaviour = CellToNumeric(BEHAVIOUR);
    % write to file
    WriteCellArrayToFile(behaviour, '../../data Numeric/numeric_behaviour.csv', ',');
    
    GPS = FileToCells('../../data/gps.csv', ',');
    % delete row_names column
    GPS(:,1) = [];
    gps = CellToNumeric(GPS);
    % write to file
    WriteCellArrayToFile(gps, '../../data Numeric/numeric_gps.csv', ',');
    
    PREDICTORS = FileToCells('../../data/predictors.csv', ',');
    predictors = CellToNumeric(PREDICTORS);
    % write to file
    WriteCellArrayToFile(predictors, '../../data Numeric/numeric_predictors.csv', ',');
    
    HABITAT = FileToCells('../../data/habitat.csv', ',');
    habitat = CellToNumeric(HABITAT);
    % write to file
    WriteCellArrayToFile(habitat,'../../data Numeric/numeric_habitat.csv', ',');
    
    MODEL_OUTPUT = FileToCells('../../data/model_output.csv', ',');
    model_output = CellToNumeric(MODEL_OUTPUT);
    WriteCellArrayToFile(model_output,'../../data Numeric/numeric_model_output.csv', ',');
    

    output_args = 1;
end

function status = WriteCellArrayToFile(Array, filename, delimiter)
%   Writes a cell-array with only strings to a file. Values are seperated
%   by the string in delimiter
    fid = fopen(filename, 'w');
    for i=1:size(Array, 1)
        for j=1:size(Array, 2)
            if(j~=size(Array, 2))
                fprintf(fid, '%s%s', Array{i,j}, delimiter);
            else
                fprintf(fid, '%s', Array{i,j}); 
            end
        end
        fprintf(fid, '\n');
    end
    fclose(fid);
    status = 1;
end

function Data = FileToCells(filename, delimiter)
%   Reads data from file and removes the first row
    Data = read_mixed_csv(filename, delimiter);
    % Remove labels from data
    Data(1,:) = [];
end

function NumericData = CellToNumeric(Data)
%   Converts a cell-array with different types to one with only numeric
%   types and a '?' string for missing values
%   Compatible types: integer values, float values, discrete strings,
%   data-specific date_time values, the string 'NA'
    
    nRows = size(Data, 1);
    nCols = size(Data, 2);
    % new Cell array with only numeric data (except for the missing values 'NA')
    % these are converted to '?' , for use with the WEKA-toolkit
    NumericData = cell(nRows,nCols);
    
    % for each attribute
    nextCol = 1;
    for i=1:nCols   
        % test the first value for
        [temp, status] = str2num(Data{1,i});
        vals = size(sscanf(Data{1,i}, '%d-%d-%d %d:%d:%d'), 1);
        
        % if date_time value
        if(vals == 6)
            %split date_time column in two columns
            % (1) nth day of the year
            % (2) m minutes after 00:00
            Days = cell(nRows,1);
            Minutes = cell(nRows,1);
            for j=1:nRows
                date_time = sscanf(Data{j,i}, '%d-%d-%d %d:%d:%d');
                Minutes{j,1} = num2str(((date_time(4,1)*60)+date_time(5,1)), '%d');
                Days{j,1} = num2str(DayOfYear(date_time(2,1), date_time(3,1)) , '%d');
            end
             NumericData(:,nextCol) = Days;
             NumericData(:,nextCol+1) = Minutes;
             nextCol = nextCol+2;
             
        % if integer/float value (include missing (NA))
        elseif(status)
            tempColumn = cell(1);
            % copy numerical values of strings
            for j=1:nRows
                if(~strcmp(Data{j,i}, 'NA'))
                    tempColumn{j,1} = Data{j,i};
                else
                    tempColumn{j,1} = '?';
                end
            end
            NumericData(:,nextCol) = tempColumn;
            nextCol = nextCol+1;
        % if string value
        else
            %replace strings in column with numeric values
            NumericData(:,nextCol) = StringToNumeric(Data(:,i));
            nextCol = nextCol+1;
        end
    end
    
    function nthDay = DayOfYear(month,day)
    %   Calculate the days passed after 31.12
        month_add = [1,-2,1,0,1,0,1,1,0,1,0,1];
        nthDay = ((month-1)*30);
        for k=1:month-1
            nthDay = nthDay + month_add(1,k);
        end
        nthDay = nthDay + day;
    end
     
    function numericColumn = StringToNumeric(StringColumn)
    %   convert string classes to numerical classes
        numericColumn = cell(nRows,1);
        
        Types = cell(1);
        nTypes = 0;
        % collect types
        for exmp=1:nRows
            if(~strMemberOfARR(StringColumn{exmp,1}, Types))
                nTypes = nTypes + 1;
                Types{1,nTypes} = StringColumn{exmp,1};
            end
        end

        % make strings numeric according to types
        for exmp=1:nRows
            for type=1:nTypes;
                if(strcmp(StringColumn{exmp,1}, Types{1,type}))
                    numericColumn{exmp,1} = num2str(type, '%d');
                end
            end
        end

        % check for presence of a string inside a cell array
        function MEMB = strMemberOfARR(string, Cell)
            MEMB = 0;
            for C=1:size(Cell, 2)
                for T=1:size(Cell, 1)
                    if(strcmp(string, Cell{T,C}))
                        MEMB = 1;
                        return;
                    end
                end
            end
        end
    end

end
















