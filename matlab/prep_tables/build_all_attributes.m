function [ result, header ] = build_all_attributes( data )
    result = [];
    birdIds = str2double(data(:, 2));
    birds = unique(birdIds);

    cell_times = data(:, 5);
    times = cell2mat(cell_times);
    
    result_index = 1;
    header = {};
    
    % Do seperately for each bird
    for i = 1:size(birds)
        birdDataIds = find(birdIds == birds(i));
        
        trajStart = find_traj_startingpointsNEW(times(birdDataIds));
        
        for k = 1:(length(trajStart)-1) % for each trajectory
            if (trajStart(k) + 1 ~= trajStart(k+1)) % no single points
                chunk_ic = birdDataIds(trajStart(k):(trajStart(k+1)-1));
                
                [chunk_attr, header] = build_trajectory_attributes(data, times, chunk_ic);
                result = [result;chunk_attr];
            end
        end
        
        % remove empty cells
        empty = cellfun('isempty', result); 
        result(all(empty,2),:) = [];
        
    end

end



