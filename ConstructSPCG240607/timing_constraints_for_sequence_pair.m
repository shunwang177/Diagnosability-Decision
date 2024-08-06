function [A,b]=timing_constraints_for_sequence_pair(root_node,sequence_pair,TPN)
% root_node=(M1,M2,\Phi), sequence_pair=(sigma_1,sigma_2)
%==this function returns a set of constraints such that M_1[sigma_1>,
%M_2[sigma_2> and Proj(sigma_1)=Proj(sigma_2)
%===input=====================================================================================
% Phi=[];
% root_node={[0 0 0 1 0 0]',[0 0 0 1 0 0]',Phi};
% clocks_1=sym('h1_%d',[1, length(Pre)],{'integer','positive'});
% clocks_2=sym('h2_%d',[1, length(Pre)],{'integer','positive'});
% sequence_pair={[5 6],[4 3 2]};
%==read the input data=================================================================
Intervals=TPN.Intervals;
l=Intervals(1,:);
u=Intervals(2,:);
Pre=TPN.Pre;
Post=TPN.Post;
M1=root_node{1};%M1 & M2 will updated when computing the ineqs(after step 46).
M2=root_node{2};
Ineq_h=root_node{3};
sigma_1=sequence_pair{1};
sigma_2=sequence_pair{2};

%===define variables==========
x=sym('x',[1, length(sigma_1)],{'integer','positive'});% x is the parametric time intervals of sigma_1
y=sym('y',[1, length(sigma_2)],{'integer','positive'});% y is the parametric time intervals of sigma_2
h_1=sym('h1_%d',[1, length(Pre)],{'integer','positive'});% h_1 is the set of clocks of the left part
h_2=sym('h2_%d',[1, length(Pre)],{'integer','positive'});% h_2 is the set of clocks of the right part

%===Compute the set of ineqs consistent with timing constrains
% the resulted Ineq_set and Its matrix form s.t. A*[h1,h2,x,y]'<=b
A=[];
b=[];

%---the timing constraints S_0\in rootnode
[A_h,b_h]=ineqs2matrix(Ineq_h,[h_1,h_2]); % read Ineq_h as matrix
A_h(end,length(h_1)+length(h_2)+length(x)+length(y))=0;
A=[A;A_h];
b=[b;b_h];

%---the timing constraints of M1[sequence_1>
for i=0:length(sigma_1)-1
    % Alg.1-Eq(4) sequence_1(i+1) means t_{i+1},
    E_vec=Enabling_vector(sigma_1(i+1),root_node{1},sigma_1(1:i),TPN); %root_node{1}[sigma_1(1:i)>[sigma_1(i+1)>
    temp_h1=zeros(1,length(h_1));
    temp_x=zeros(1,length(x));
    temp_h1(sigma_1(i+1))=E_vec(1); %E_vec(1) is the coefficient of h(sigma_1(i+1))
    temp_x(1:i+1)=[E_vec(2:end), 1];      %temp3 is the coefficient of x
    A=[A;-temp_h1,zeros(1,length(h_2)),-temp_x,zeros(1,length(y))];
    b=[b;-l(sigma_1(i+1))];
    % Alg.1-Eq(3)
    for j=1:length(Pre)      %for each t_j\in T
        if all(M1>=Pre(:,j)) %if t_j\in En(M1)
            E_vec=Enabling_vector(j,root_node{1},sigma_1(1:i),TPN);
            temp_h1=zeros(1,length(h_1));
            temp_x=zeros(1,length(x));
            temp_h1(j)=E_vec(1);
            temp_x(1:i+1)=[E_vec(2:end), 1];
            A=[A;temp_h1,zeros(1,length(h_2)),temp_x,zeros(1,length(y));...
                -temp_h1,zeros(1,length(h_2)),-temp_x,zeros(1,length(y))];
            b=[b;u(j);0];
        end
    end
    % update M1
    M1=M1-Pre(:,sigma_1(i+1))+Post(:,sigma_1(i+1));
end

%---the timing constraints of M2[sequence_2>
%---corresponding to Alg.1-Eq(6-7)
for i=0:length(sigma_2)-1
    % Alg.1-Eq(4)=====sequence_1(i+1) means t_{i+1}
    E_vec=Enabling_vector(sigma_2(i+1),root_node{2},sigma_2(1:i),TPN);
    temp_h2=zeros(1,length(h_2));
    temp_y=zeros(1,length(y));
    temp_h2(sigma_2(i+1))=E_vec(1);%E_vec(1) is the coefficient of h'(sigma_2(i+1))
    temp_y(1:i+1)=[E_vec(2:end), 1];%temp4 is the coefficient of y
    A=[A;zeros(1,length(h_1)),-temp_h2,zeros(1,length(x)),-temp_y];
    b=[b;-l(sigma_2(i+1))];
    % Alg.1-Eq(3)
    for j=1:length(Pre)
        if all(M2>=Pre(:,j)) %if t_j\in En(MA)
            E_vec=Enabling_vector(j,root_node{2},sigma_2(1:i),TPN);
            temp_h2=zeros(1,length(h_2));
            temp_y=zeros(1,length(y));
            temp_h2(j)=E_vec(1);
            temp_y(1:i+1)=[E_vec(2:end), 1];%temp4 is the coefficient of y
            A=[A; zeros(1,length(h_1)), temp_h2, zeros(1,length(x)), temp_y;...
                zeros(1,length(h_1)), -temp_h2, zeros(1,length(x)), -temp_y];
            b=[b;u(j);0];
        end
    end
    % update M2
    M2=M2-Pre(:,sigma_2(i+1))+Post(:,sigma_2(i+1));
end

%===corresponding to Alg.1-Eq(9): Proj(sequence_1)=Proj(sequence_2)========
temp_x=ones(1,length(x));
temp_y=ones(1,length(y));
A=[A;zeros(1,length(h_1)+length(h_2)),temp_x,-temp_y;zeros(1,length(h_1)+length(h_2)),-temp_x,temp_y];
b=[b;0;0];

end