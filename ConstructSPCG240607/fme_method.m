function [A_new,b_new]=fme_method(A,b,variables)
    % Given a system inequalities A*x<b, this function returns
    % A_new*x<b_new, where a set of parameters $x(eliminate_var)$ are eliminated;
    %=test data
% A = [ -1, 0, 0, 0, 0; % 3 <= x1 --> -x1 <= -3
% 1, 0, 0, 0, 0; % x1 <= 8 --> x1 <= 8
% 1, 0, 0, 0, 0; % x1 <= 7 --> x1 <= 7
% 0, -1, 0, 0, 0; % 6 <= x2 --> -x2 <= -6
% 0, 1, 0, 0, 0; % x2 <= 8 --> x2 <= 8
% 0, 0, -1, 0, 0; % 4 <= y1 --> -y1 <= -4
% 0, 0, 1, 0, 0; % y1 <= 8 --> y1 <= 8
% 0, 0, 1, 0, 0; % y1 <= 7 --> y1 <= 7
% 0, 0, 0, -1, 0; % 3 <= y2 --> -y2 <= -3
% 0, 0, 0, 1, 0; % y2 <= 8 --> y2 <= 8
% 0, 0, 0, 1, 0; % y2 <= 9 --> y2 <= 9
% 0, 0, 0, -1, -1; % 2 <= y2 + y3 --> -y2 - y3 <= -2
% 0, 0, 0, 0, 1; % y3 <= 7 --> y3 <= 7
% 0, 0, 0, 1, 1]; % y2 + y3 <= 8 --> y2 + y3 <= 8
% b = [-3; 8; 7; -6; 8; -4; 8; 7; -3; 8; 9; -2; 7; 8];
%     variables = [1 3 6]; eliminate x_1,x_3,x_6 from A|b

    % initialize
    A_new = A;
    b_new = b;
    % elimination variables 1 by 1
    for i = 1:length(variables)
        [A_new,b_new]=fourier_motzkin_elimination(A_new,b_new,variables(i));
    end
    % simplification
    [A_new,b_new]=remove_redundant_inequalities(A_new,b_new);
end
