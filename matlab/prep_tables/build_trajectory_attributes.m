function [attributes, header] = build_trajectory_attributes(data, timestamps, indices)
    header = {'obsID', 'birdID', 'day', 'min', 'speed', ...
       'tortuosity', 'area', 'time', 'ab_dist', 'tot_dist'};

    attributes = cell(length(indices)-1, length(header));
    chunk_times = timestamps(indices);
    text_speeds = data(indices, 8);
    %num_speeds = clean_speeds(text_speeds);
    %acceleration = diff(num_speeds)./diff(chunk_times); % dy/dx
    %acceleration = gfilter(num_speeds, 2, [0 1])

    chunk = data(indices,:);

    numericData = str2double(chunk(:, [3 4 6 7]));

    distances = squareform(pdist(numericData(:, [3 4])));
    edgePoints = convhull(numericData(:, [3 4]));
    totalArea = polyarea(numericData(edgePoints, 3), numericData(edgePoints, 4));

    totalDistance = sum(diag(distances, 1));
    directDistance = pdist(numericData([1,end], [3 4]));
    tortuosity = totalDistance / directDistance;

    totalTime = pdist(chunk_times([1 end])) * 100;

    %num2str(acceleration(j-1), '%f'), ...
    for j = 2:length(indices)
        point = [data(indices(j), [1 2 3 4 8]), ...
            num2str(tortuosity, '%f'), ...
            num2str(totalArea, '%f'), ...
            num2str(totalTime, '%f'), ...
            num2str(directDistance, '%f'), ...
            num2str(totalDistance, '%f')];
        attributes(j-1, :) = point;
    end
end
