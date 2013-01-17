% check for presence of a string inside a cell array
function MEMB = strMemberOfARR(string, Cell)
    MEMB = 0;
    for C=1:size(Cell, 2)
        for T=1:size(Cell, 1)
            if(strcmp(string, Cell{T,C}))
                MEMB = 1;
                return;
            end
        end
    end
end