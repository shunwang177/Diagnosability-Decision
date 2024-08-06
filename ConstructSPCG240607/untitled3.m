% 示例数据
clear;
clc;
C = [1,1];
A = [1, 0; 0, 1];

% 计算 T1 和 T2
[T1, T2] = Basis_Trans(C, A);

% 显示结果
disp('T1:');
disp(T1);
disp('T2:');
disp(T2);