function n = dataSplit(filename)
% tells from where to where the data has to split for anylizing
filename = '../../data/raw/behaviour.csv';

obsIDs = sortObsIDs(filename);

data3 = FileToCells('../../data/accelerometer_supervised/acc_supervised.csv',',');
superIDs = str2double(data3(:,1))
i = 1;
n = zeros(length(obsIDs),1);
n(1) = 1; % start to count by 1
for j = 1:(length(obsIDs)-1)
    if i == 1
        k = 1;
    else
        k = n(i-1);
    end
    while obsIDs(j) == superIDs(k)
        n(i) = n(i) + 1;
        k = k + 1;
    end
    if i > 1
        n(i) = n(i) + n(i-1);
    end
    i = i + 1;
end
% last number is the last superAcc row
n(length(obsIDs)) = length(superIDs);


    