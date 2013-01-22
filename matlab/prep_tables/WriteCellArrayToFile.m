function status = WriteCellArrayToFile(Array, filename, delimiter)
%   Writes a cell-array with only strings to a file. Values are seperated
%   by the string in delimiter
    fid = fopen(filename, 'w+');
    for i=1:size(Array, 1)
        for j=1:size(Array, 2)
            if(j~=size(Array, 2))
                fprintf(fid, '%s%s', Array{i,j}, delimiter);
            else
                fprintf(fid, '%s', Array{i,j}); 
            end
        end
        fprintf(fid, '\n');
    end
    fclose(fid);
    status = 1;
end