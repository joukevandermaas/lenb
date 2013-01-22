function numericColumn = StringToNumeric(StringColumn)
%   Collect the types of string values and convert the values to numbers
%   accordingly

    n = size(StringColumn,1);
    numericColumn = cell(n,1);

    Types = cell(1);
    nTypes = 0;
    % collect types
    for exmp=1:n
        if(~strMemberOfARR(StringColumn{exmp,1}, Types))
            nTypes = nTypes + 1;
            Types{1,nTypes} = StringColumn{exmp,1};
        end
    end

    % make strings numeric according to types
    for exmp=1:n
        for type=1:nTypes;
            if(strcmp(StringColumn{exmp,1}, Types{1,type}))
                numericColumn{exmp,1} = num2str(type, '%d');
            end
        end
    end
end