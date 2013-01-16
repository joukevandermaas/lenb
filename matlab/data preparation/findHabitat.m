% Finds all habitat values whith known behaviour
function [ output_args ] = findHabitat()

BEHAVIOUR = FileToCells('../../data/raw/behaviour.csv', ',');
behaviour = CellToNumeric(BEHAVIOUR,1,1);

HABITAT = FileToCells('../../data/raw/habitat.csv', ',');
habitat = CellToNumeric(HABITAT,1,1);

counter = 0;
for i=1:size(behaviour,1)
    obsID = behaviour{i,1};
    for j=1:size(habitat,1) % for all object IDs
        if(strcmp(habitat{j,1}, obsID)) % if there is a match with a obID
            counter = counter+1;
            AppendedData{counter,1} = obsID;
            AppendedData{counter,2} = habitat{j,2};
            AppendedData{counter,3} = habitat{j,3};
            AppendedData{counter,4} = habitat{j,4};
        end
    end
end
% remove last row because it is a duplication
AppendedData(size(AppendedData,1),:) = [];
% write to file
%WriteCellArrayToFile(AppendedData, '../../data/accelerometer_supervised/habitat_supervised', ',');
    
output_args = AppendedData;