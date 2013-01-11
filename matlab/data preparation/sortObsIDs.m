function obsIDs = sortObsIDs(filename)

filename = '../../data/raw/behaviour.csv';

%data2 = FileToCells('../../data/raw/accelerometer.csv',',');
data = FileToCells(filename,',');


obsIDs = data(:,1);
obsIDs = str2double(obsIDs);
obsIDs = sort(obsIDs);
 
% doubles were used for accExtract
%doubles = data(:,1);
%doubles = str2double(doubles);