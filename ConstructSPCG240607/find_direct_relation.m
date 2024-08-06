function [sigma_1, sigma_2]=find_direct_relation(a, b, Edge)
% this function find the transition sequence pair between node a and b;
% there may be more that one solution, here we only output the 1st one

%=Initialize=================================
% Edge=[{1,'b',[5 6 ],[4 2],2}, {...}, {...}]
for i=1:length(Edge)
    edge=Edge{i};
    if a==edge{1} && b==edge{end}
        sigma_1=edge{3};
        sigma_2=edge{4};
        return
    end
end
end