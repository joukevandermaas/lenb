function [ output_args ] = addKurtosis()
%MAIN 
%   This function add kurtosis to the data

    % read and rewrite data
    % ________________________________________________
    BEHAVIOUR = FileToCells('../../data/raw/behaviour.csv', ',');
    behaviour = CellToNumeric(BEHAVIOUR,1,1);
    
    GPS = FileToCells('../../data/raw/gps.csv', ',');
    % delete row_names column
    GPS(:,1) = [];
    gps = CellToNumeric(GPS, 1,1);
    
    PREDICTORS = FileToCells('../../data/raw/predictors.csv', ',');
    predictors = CellToNumeric(PREDICTORS, 1, 1);
    
    kurt = kurtosisAcc('../../data/accelerometer_supervised/acc_supervised.csv');
    kurtosis = num2cell(kurt');
    %kurtosis = CellToNumeric(KURTOSIS);
    
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

        % append predictors data to example
        for j=1:size(predictors,1)
            if(strcmp(predictors{j,1}, obsID))
                for k=2:size(predictors,2)-1
                    AppendedData{i,nextColumn} = predictors{j,k};
                    nextColumn = nextColumn + 1;
                end
                
                break;
            end
        end
        
        for k=2:size(behaviour,2)
            AppendedData{i,nextColumn} = behaviour{i,k};
            nextColumn = nextColumn + 1;
        end
        
        AppendedData{i,nextColumn} = kurtosis{i};
        
    end
    
    % write to file
    WriteCellArrayToFile(AppendedData, '../../data/appended GPS_PRED_BEH/appended_plus_kurtosis.csv', ',');
    
    output_args = 1;
end