function kurt = kurtosisAcc()
% Calculates the kurtosis of accelerometer data
data = FileToCells('../../data/accelerometer_supervised/acc_supervised.csv',',');
xAcc = str2double(data(:,3));

n = dataSplit('../../data/raw/behaviour.csv');

kurt(1) = kurtosis(xAcc(1:n(1))');

for i = 2:(length(n))
    kurt(i) = kurtosis(xAcc(n(i-1):n(i))');
end

% transforms it in a csv file
%C = num2cell(kurt')
%WriteCellArrayToFile(C, '../../data/accelerometer_supervised/kurtosis.csv', ',');