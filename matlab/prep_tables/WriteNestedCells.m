function WriteNestedCells( data, file )
    
    fileId = fopen(file, 'w');
    
    for i = 1:size(data, 1)
        fprintf(fileId, '%d\n', data{i, 1});
        fprintf(fileId, '  %d\n', data{i, 2});
    end
    
    fclose(fileId);

end

