j = 1;
for k = 1:length(obsIDs)
    for i = 1:length(doubles)
        if doubles(i) == obsIDs(k)
            %remData{j,1} = [data2{i,:}];
            remData{j,1} = data2{i,1};
            remData{j,2} = data2{i,2};
            remData{j,3} = data2{i,3};
            remData{j,4} = data2{i,4};
            remData{j,5} = data2{i,5};
            j = j + 1;
        end
    end 
end

WriteCellArrayToFile(remData, '../../data/accelerometer_supervised/acc_supervised.csv', ',');