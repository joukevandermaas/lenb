function [trajStart] = find_traj_startingpoints(times)
    offsets = diff(times);
    trajStart = find(offsets > 1/1440) + 1; % more than 60s apart
end
