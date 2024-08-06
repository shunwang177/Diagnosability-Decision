function [T1, T2] = Basis_Trans_minus(C, A)
% T1*C= T2*A
% A*x<=b; C*x=y-->T1*y<=T2*b
   % 获取矩阵的维度
    [l, nC] = size(C);
    [m, nA] = size(A);

    % 确保 A 和 C 的列数相同
    if nC ~= nA
        disp(C);
        disp(A);
        error('Matrix C and A must have the same number of columns');
    end

    % 定义优化变量
    T1 = optimvar('T1', m, l, 'Type', 'integer', 'LowerBound', -1, 'UpperBound', 1);
    T2 = optimvar('T2', m, m, 'Type', 'integer', 'LowerBound',  0, 'UpperBound', 1);

    % 定义优化问题
    problem = optimproblem;

    % 约束条件: T1 * C = T2 * A
    problem.Constraints.cons1 = T1 * C == T2 * A;

    % 设置目标函数（可以是任意常数，因为我们只是求满足约束的解）
    problem.Objective = sum(sum(T1)) - sum(sum(T2));

    % 求解问题
    options = optimoptions('intlinprog', 'Display', 'off');
    sol = solve(problem, 'Options', options);

    % 提取解
    T1 = sol.T1;
    T2 = sol.T2;
end

