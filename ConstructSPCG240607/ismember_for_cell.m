function isMember=ismember_for_cell(A, B)
% A is a member of B?
% if so, the index of A

%========================================
% A = {'a', [1 2 3]};
% B = {{'a', [1 2 3]}, {'b', [7 8 9 10]}};
isMember = false;
for i = 1:length(B)
    % if A==B{i}
    if cellArrayEqual(A, B{i})
        isMember = i;
        break;
    end
end
end