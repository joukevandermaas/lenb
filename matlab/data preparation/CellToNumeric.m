function NumericData = CellToNumeric(Data)
%   Converts a cell-array with different types to one with only numeric
%   values ins strings and a '?' string for missing values.
%   The output cell-array is still a string-array.
%   Compatible input types: integer values, float values, discrete strings,
%   data-specific date_time values, the string 'NA' for missing values
    
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
            
            %for WEKA
            %NumericData(:,nextCol) = Data(:,i);
            
            nextCol = nextCol+1;
        end
    end
    

end