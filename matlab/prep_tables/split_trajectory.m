function [ trajectories ] = split_trajectory( chunk, times )
    offsets = diff(times) * 86400; % seconds per day
    trajectories = [];
    
    elapsed = 0;
    start = 1;
    for i = 1:length(offsets)
        elapsed = elapsed + offsets(i);
        if elapsed > 60
            trajectories = [trajectories; {chunk(start:(i+1))}];
            start = i+1;
            elapsed = 0;
        end
    end
end

