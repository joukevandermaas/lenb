function kurt = kurtosisAcc(filename)
filename = '../../data/accelerometer_supervised/acc_supervised.csv';
data = FileToCells(filename,',');
xAcc = str2double(data(:,3));

n = dataSplit('../../data/raw/behaviour.csv');

kurt(1) = kurtosis(xAcc(1:n(1))');

for l = 2:(length(n))
    kurt(l) = kurtosis(xAcc(n(l-1):n(l))');
end