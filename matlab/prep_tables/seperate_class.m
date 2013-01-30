% input classified data with class that needs to be seperated
function seperated = seperate_class(data,class)

att = length(data(1,:));
col11 = str2double(data(:, 7));

classInd = find(col11 == class);
seperated = cell(length(classInd),att-1);

for i = 1:length(classInd)
    for j = 1:att-1
        seperated{i,j} = data{classInd(i),j};
    end
end
%'obsID', 'birdID', 'day', 'min', 'speed', ...
%header = {'trajID', ...
%       'tortuosity', 'area', 'time', 'ab_dist', 'tot_dist'};

%seperated = [header;seperated];
