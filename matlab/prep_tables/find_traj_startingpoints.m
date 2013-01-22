function [trajStart] = find_traj_startingpoints(times)
    offsets = times(2:end) - times(1:end-1);
    trajStart = find(offsets > 1/1440); % more than 60s apart
end
