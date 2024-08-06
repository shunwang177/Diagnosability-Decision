function [A_new, b_new] = remove_redundant_inequalities(A, b)
    % Number of inequalities
    [m, ~] = size(A);
    % Logical array to mark redundant inequalities
    redundant = false(m, 1);
    temp_redundant= false(m, 1);
    % Loop through each inequality
    for i = 1:m

        % Create a temporary matrix and vector excluding the current inequality
        temp_redundant=redundant;
        temp_redundant(i) = true;
        A_temp = A(~temp_redundant, :);
        b_temp = b(~temp_redundant, :);
        
        % Solve the linear program to see if the current inequality is redundant
        [~, min_bi] = linprog(-A(i, :), A_temp, b_temp);
        
        % If the linear program is feasible, the inequality is redundant
        if -min_bi <= b(i)
            redundant(i) = true;
        end
    end
    
    % Create new matrices excluding redundant inequalities
    A_new = A(~redundant, :);
    b_new = b(~redundant);
end
