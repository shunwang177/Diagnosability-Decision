function isEqual = cellArrayEqual(cell1, cell2)
%whether 2 cells are equavilent?
    if length(cell1) ~= length(cell2)
        isEqual = false;
        return;
    end
    isEqual = true;
    for i = 1:length(cell1)
        if iscell(cell1{i}) && iscell(cell2{i})
            isEqual = isEqual && cellArrayEqual(cell1{i}, cell2{i});
        elseif isnumeric(cell1{i}) && isnumeric(cell2{i})
            isEqual = isEqual && isequal(cell1{i}, cell2{i});
        else
            isEqual = isEqual && isequal(cell1{i}, cell2{i});
        end
    end
end