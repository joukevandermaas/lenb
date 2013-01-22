%Jouke van der Maas, 10186883
%file: main.m
%created: 15.01.2013
%last edited: 15.01.2013
function [AppendedData, header] = mainBuild_gpsdata_extended()
%MAIN 
%   This function takes the gps-dataset and adds columns
%   for the previous datapoint's data.
    
    gps = read_gps_data();

    [AppendedData header] = build_all_attributes(gps);
    
    WriteCellArrayToFile([header;AppendedData], ...
       '../../data/appended/gps_data_extended.csv', ',');
    
    % ________________________________________________
end

















