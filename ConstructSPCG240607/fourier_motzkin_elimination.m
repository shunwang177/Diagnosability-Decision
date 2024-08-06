function [A_new,b_new]=fourier_motzkin_elimination(A,b,eliminate_var)
    % Given a system inequalities A*x<b, this function returns
    % A_new*x<b_new, where parameter $x(eliminate_var)$ is eliminated;
    %=test data
%     clear all;
%     clc;
%     A = [1, 0; -1, 0; 0, 1; 0, -1; 1, 1];
%     b = [8; -3; 8; -6; 10];
%     eliminate_var = 1;
    % classify the rows 
    A_plus = [];
    A_minus = [];
    A_zero = [];
    b_plus = [];
    b_minus = [];
    b_zero = [];
    %a_i x_i<=b_i
    %for each row, if a_i>0;if a_i<0, if a_i=0
    for i = 1:size(A, 1)
        if A(i, eliminate_var) > 0
            A_plus = [A_plus; A(i, :)];
            b_plus = [b_plus; b(i)];
        elseif A(i, eliminate_var) < 0
            A_minus = [A_minus; A(i, :)];
            b_minus = [b_minus; b(i)];
        else
            A_zero = [A_zero; A(i, :)];
            b_zero = [b_zero; b(i)];
        end
    end
    % initialize
    A_new = [];
    b_new = [];
    % elimination
    for i = 1:size(A_plus, 1)
        for j = 1:size(A_minus, 1)
            % as to x_1, for each a_i,1>0, eliminate it by a_j,1<0
            new_A = A_minus(j, :) / abs(A_minus(j, eliminate_var)) + A_plus(i, :) / abs(A_plus(i, eliminate_var));
            new_b = b_minus(j) / abs(A_minus(j, eliminate_var)) + b_plus(i) / abs(A_plus(i, eliminate_var));
            % collect the new inequlities into A_new, b_new
            A_new = [A_new; new_A];
            b_new = [b_new; new_b];
        end
    end
    % Keep the inequalitie that has no relation with $x(eliminate_var)$
    A_new = [A_new; A_zero];
    b_new = [b_new; b_zero];
end
