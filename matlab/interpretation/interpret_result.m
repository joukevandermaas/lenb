addpath('../prep_tables');

noAttributes = 6;

data = csvread('../../data/appended/gps_data_extended_classes.csv',1,noAttributes);
results = dlmread('../../classifier_result.txt', ' ');

[clusters, ~, indices] = unique(results(:, 2));

lookup = [indices, data(:, 2)];
classtable = zeros(8,8);

for i = 1:size(lookup, 1)
    idx = lookup(i, :);
    classtable(idx(1), idx(2)) = classtable(idx(1), idx(2)) + 1;
end

disp('cls  1     2     3     4     5     6     7     8  |cluster')
disp('     -------------------------------------------  |')
disp([classtable, (1:8)'])

classT = sort(sum(classtable, 1));
clustT = sort(sum(classtable, 2));

disp('Percentages')
disp('     class   cluster')

disp([(classT / sum(classT) * 100)', ...
      clustT / sum(clustT) * 100])
