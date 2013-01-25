function [ result, header, traj_lookup ] = build_all_attributes( data )
    result = [];
    traj_lookup = [];
    birdIds = str2double(data(:, 2));
    birds = unique(birdIds);

    cell_times = data(:, 5);
    times = cell2mat(cell_times);

    header = {};
    traj_id = 0;
    
    % Do seperately for each bird
    for i = 1:size(birds)
        birdDataIds = find(birdIds == birds(i));
        
        trajStart = find_traj_startingpoints(times(birdDataIds));
        
        for k = 1:(length(trajStart)-1) % for each trajectory
            if (trajStart(k) + 1 ~= trajStart(k+1)) % no single points
                big_chunk_ic = birdDataIds(trajStart(k):(trajStart(k+1)-1));
                subchunks = split_trajectory(big_chunk_ic, times(big_chunk_ic));
                for j = 1:length(subchunks)
                    traj_id = traj_id + 1;
                    chunk_ic = subchunks{j};
                    traj_lookup = [traj_lookup; [traj_id, {chunk_ic(:,1)}]];
                
                    [chunk_attr, header] = build_trajectory_attributes(data, times, chunk_ic);
                    result = [result;[num2str(traj_id, '%d'), chunk_attr]];
                end
            end
        end
    end
    
    header = ['trajID', header];
    % remove empty cells
    empty = cellfun('isempty', result); 
    result(all(empty,2),:) = [];

end
