function mainBuild_gpsdata_extended_classes()
    BEHAVIOUR = FileToCells('../../data/raw/behaviour.csv', ',');
    behaviour = CellToNumeric(BEHAVIOUR,1,1);

    gps = read_gps_data();
    [~, header] = mainBuild_gpsdata_extended(gps);
    
    cgps = filter_gps_data(gps, behaviour);
    classes = cgps(:, (end-2):end);
    cgps = cgps(:, 1:(end-3));

    [AppendedData header traj_lookup] = build_all_attributes(cgps);
    
    class_columns = get_trajectory_classes(traj_lookup, classes);
    
    WriteNestedCells(traj_lookup, '../../data/appended/traj_lookup_classes.txt');
    
    header = [header, {'c3', 'c8', 'c16'}];
    WriteCellArrayToFile([header;[AppendedData, class_columns]], ...
      '../../data/appended/gps_data_extended_classes.csv', ',');
end

















