function [A_h, b_h] = Basis_Trans(C, A, b)
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
A_h=[T1_minus;T1_plus];
b_h=blkdiag(T2_minus,T2_plus)*[b_minus;b_plus];
% [A_h, b_h] =remove_redundant_inequalities(A_h,b_h);
end

