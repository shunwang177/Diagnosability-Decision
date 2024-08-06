function [A_minus, b_minus,A_plus,b_plus] = Basis_Trans2(C, A, b)
% A*x<=b; C*x=h-->A_h*h<=b_h
% clear
% clc
%----eg. 1--
% A = [1 0;
%      0 1];
% C=[1 1];
%----eg. 2--
% A = [1 ;
%     -1];
% C=[1];
% split A into 2 part
negative_rows=any(A<0, 2);
A_minus=A(negative_rows,:);
A_plus=A(~negative_rows,:);
b_minus=b(negative_rows,:);
b_plus=b(~negative_rows,:);
% compute the transition matrix respectively
if isempty(A_minus)
    T1_minus=[];
    T2_minus=[];
else
    [T1_minus, T2_minus]=Basis_Trans_minus(C,A_minus);
end
%--------------------------
if isempty(A_plus)
    T1_minus=[];
    T2_minus=[];
else
    [T1_plus, T2_plus]=Basis_Trans_plus(C,A_plus);
end

% output
A_plus=T1_plus;
A_minus=T1_minus;
b_plus=T2_plus*b_plus;
b_minus=T2_minus*b_minus;
%--eliminate redundant inequalities--
[A_minus, b_minus] =remove_redundant_inequalities(A_minus,b_minus);
[A_plus, b_plus] =remove_redundant_inequalities(A_plus,b_plus);
end

