function filtered = filter_gps_data(data, classes)
    filtered = cell(size(classes,1),size(data, 2) + 3);
    % append data to classes
    ids = str2double(classes(:, 1));
    gpsIds = str2double(data(:, 1));
    
    for i = 1:length(ids)
       j = gpsIds == ids(i);
       if (sum(j) > 0)      
           filtered(i, :) = ...
              [data(j, :), classes(i, 2:4)];
       end
    end
    
    % remove empty cells
    empty = cellfun('isempty', filtered); 
    filtered(all(empty,2),:) = [];
end