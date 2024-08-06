% 自定义函数：化简不等式组
function simplified = reduce_inequalities(ineqs, vars)
    % 将不等式组转换为矩阵形式
    [A, b] = equationsToMatrix(ineqs, vars);
    
    % 使用 MATLAB 的逻辑工具化简不等式组
    simplified = [];
    for i = 1:length(vars)
        % 提取与当前变量相关的不等式
        relevant_ineqs = ineqs(contains(string(ineqs), string(vars(i))));
        
        % 提取最大下界和最小上界
        lb = -inf;
        ub = inf;
        for j = 1:length(relevant_ineqs)
            lhs = lhs(relevant_ineqs(j));
            rhs = rhs(relevant_ineqs(j));
            if contains(string(relevant_ineqs(j)), '<=')
                if rhs < ub
                    ub = rhs;
                end
            else
                if lhs > lb
                    lb = lhs;
                end
            end
        end
        
        % 创建化简后的不等式
        if lb > -inf
            simplified = [simplified, lb <= vars(i)];
        end
        if ub < inf
            simplified = [simplified, vars(i) <= ub];
        end
    end
end