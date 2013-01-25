function [trajStart] = find_traj_startingpointsNEW(times)
    temp = 1;
    tempStart = times(1,1);
    trajStart = 1;
    
    for i=2:size(times, 1)
        % 30 min per trajectory
        if((i - temp) > 2 && times(i,1)-tempStart > (1/48))
            trajStart = [trajStart;i];
            tempStart = times(i,1);
            temp = i;
        end
        
    end
    
    
end