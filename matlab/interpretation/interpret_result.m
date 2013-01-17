addpath('../preparation');

data = csvread('../../data/appended/gps_data_classes.csv',1,12);
results = dlmread('../../classifier_result.txt', ' ');

lookup = [results(:, 2) + 1, data(:, 2)];
classtable = zeros(8, 8);

for i = 1:size(lookup, 1)
    idx = lookup(i, :);
    classtable(idx(1), idx(2)) = classtable(idx(1), idx(2)) + 1;
end

classtable = [classtable, [1,2,3,4,5,6,7,8]'];
disp('cls  1     2     3     4     5     6     7     8  |cluster')
disp('     -------------------------------------------  |')
disp(classtable)


