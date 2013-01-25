%Jouke van der Maas, 10186883
%file: main.m
%created: 15.01.2013
%last edited: 15.01.2013
function [AppendedData, header] = mainBuild_gpsdata_extended()
    
    gps = read_gps_data();

    [AppendedData header traj_lookup] = build_all_attributes(gps);
    
    WriteNestedCells(traj_lookup, '../../data/appended/traj_lookup.txt');
    
    WriteCellArrayToFile([header;AppendedData], ...
      '../../data/appended/gps_data_extended.csv', ',');

end

















