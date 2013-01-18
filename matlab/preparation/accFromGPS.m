function acc = accFromGPS()

GPS = FileToCells('../../data/raw/gps.csv', ',');
speed = str2double(GPS(:,7));


acc = gfilter(speed,2,[0,1]); % first derivative in x-direction, sigma = 2
