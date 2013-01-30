% gives a cell array with data who are near to the centroid of a feature of
% a cluster, to see of clusters are distinctive
% input: cluster number and feature numbers
function compare = find_nearest_data(cluster,feature1,feature2)

classes = FileToCells('../../data/appended/cluster_classes.csv', ',');
classes = CellToNumeric(classes,1,1);

seperated = seperate_class(classes,cluster); %7

colClasses = str2double(classes(:,feature1)); %3
colClasses2 = str2double(classes(:,feature2)); %6

colClass1 = str2double(seperated(:,feature1));
colClass2 = str2double(seperated(:,feature2));
centroid1 = mean(colClass1);
centroid2 = mean(colClass2);

marge1 = 1; %variable
marge2 = 1; %variable

inds = find(colClasses>(centroid1-marge1) & colClasses<(centroid1+marge1)...
    & colClasses2>(centroid2-marge2) & colClasses2<(centroid2+marge2));

compare = cell(length(inds),7);

for i = 1:length(inds)
    for j = 1:7
        compare{i,j} = classes{inds(i),j};
    end
end