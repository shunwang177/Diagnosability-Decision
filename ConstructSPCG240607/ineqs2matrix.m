function [A,b]=ineqs2matrix(Ineq_set, vars)
%=======================================
% clear all
% clc
% syms x1 x2 y1 y2 y3;
% vars=[x1 x2 y1 y2 y3];
% Ineq_set = [3 <= x1, x1 <= 8, x1 <= 7, ...
% 6 <= x2, x2 <= 8, ...
% 4 <= y1, y1 <= 8, y1 <= 7, ...
% 3 <= y2, y2 <= 8, y2 <= 9, ...
% 2 <= y2 + y3, y3 <= 7, y2 + y3 <= 8]
% Ineq_set = [3 <= x1; x1 <= 8; x1 <= 7; ...
% 6 <= x2; x2 <= 8; ...
% 4 <= y1; y1 <= 8; y1 <= 7; ...
% 3 <= y2; y2 <= 8; y2 <= 9;...
% 2 <= y2 + y3; y3 <= 7; y2 + y3 <= 8]
% eqs=[];
%==partition
eq_set=[];
for i=1:length(Ineq_set)
    left=lhs(Ineq_set(i));
    right=rhs(Ineq_set(i));
    eq=left==right;
    eq_set=[eq_set,eq];
if contains(char(Ineq_set(i)), '==')
    eq=-left==-right;
    eq_set=[eq_set,eq];
end
end
 %-----------------
 [A,b]=equationsToMatrix(eq_set,vars);
 A=double(A);
 b=double(b);
end