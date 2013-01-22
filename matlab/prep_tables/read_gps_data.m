function [ gps ] = read_gps_data()
    GPS = FileToCells('../../data/raw/gps.csv', ',');
    % delete row_names column
    GPS(:,1) = [];
    gps = CellToNumeric(GPS, 1,1);
    
        % obsid, birdid, day, min, ticks, y, x, speed
        %     1,      2,   3,   4,     5, 6, 7,     8
    
    % sort by time
    ids = str2double(gps(:,1));
    [~,IX] = sort(ids);
    gps = gps(IX, :);
end

