function [Data Header] = FileToCells(filename, delimiter)
%   Reads data from file and removes the first row
    Data = read_mixed_csv(filename, delimiter);
    % Remove labels from data
    Header = Data(1,:);
    Data(1,:) = [];
end