function traj_classes = get_trajectory_classes(lookup, classes)
    traj_classes = cell(size(lookup, 1), size(classes, 2));

    for i = 1:size(lookup, 1)
        traj_class_cell = classes(lookup{i, 2}, :);
        traj_class_num = str2double(traj_class_cell);
        traj_classes(i, :) = strtrim(cellstr(int2str(mode(traj_class_num)'))');
    end
end