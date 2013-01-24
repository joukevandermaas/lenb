addpath('../prep_tables');

[data, header] = FileToCells('../../data/appended/gps_data_extended.csv', ',');
results = dlmread('../../classifier_result.txt', ' ') + 1;

classes = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'};

class_column = cell(size(results,1), 1);
class_column(:) = classes(results(:, 2));

header = [header, 'class']
table = [data, class_column];
WriteCellArrayToFile([header;table], '../../data/appended/cluster_classes.csv', ',');