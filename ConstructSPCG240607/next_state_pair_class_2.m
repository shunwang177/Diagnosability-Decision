function tail_node=next_state_pair_class_2(root_node,sequence_pair,A,b,TPN)
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
Pre=TPN.Pre;
M1=root_node{1};%M1 & M2 will updated when computing the ineqs(after step 46).
M2=root_node{2};
sigma_1=sequence_pair{1};
sigma_2=sequence_pair{2};

%===define variables==========
x=sym('x',[1, length(sigma_1)],{'integer','positive'});% x is the parametric time intervals of sigma_1
y=sym('y',[1, length(sigma_2)],{'integer','positive'});% y is the parametric time intervals of sigma_2
h_1=sym('h1_%d',[1, length(Pre)],{'integer','positive'});% h_1 is the set of clocks of the left part
h_2=sym('h2_%d',[1, length(Pre)],{'integer','positive'});% h_2 is the set of clocks of the right part

%===compute the transformation relation=============================================================
[trans_relation_zero,trans_relation_A,trans_relation_b]=...
    clock_transformation(root_node,sequence_pair,TPN);

%===Compute the set of ineqs consistent with timing constrains
% [A,b]=timing_constraints_for_sequence_pair(root_node,sequence_pair,TPN);

%===if [A|b] is feasible, Step1 removes independent variables by FME-method

    %---FME-method
    eliminate_vars=find(all(trans_relation_A == 0, 1));
    [A,b]=fme_method(A,b,eliminate_vars);

%===then transform 
ineq_set_h=[];
if ~isempty(trans_relation_A)
    [A_minus, b_minus,A_plus,b_plus]=Basis_Trans2(trans_relation_A, A, b);
    for i=1:size(A_minus,1)
        ineq=-A_minus(i,:)*trans_relation_b*[h_1,h_2]'>=-b_minus(i,:);
        ineq_set_h=[ineq_set_h,ineq];
    end
    for i=1:size(A_plus,1)
        ineq=A_plus(i,:)*trans_relation_b*[h_1,h_2]'<=b_plus(i,:);
        ineq_set_h=[ineq_set_h,ineq];
    end
end
ineq_set_h=[ineq_set_h,trans_relation_zero];


%--express [A,b] as ineqs and then replace variables according to the trans_relationship
%--This method may not work in case of [1<=x1<=2, 2<=x2<=4]|h=x1+x2
%     ineq_set_h=[];
%     for i=1:size(A,1)
%         if b(i)<=0
%             ineq=-A(i,:)*[h_1,h_2,x,y]'>=-b(i);
%         else
%             ineq=A(i,:)*[h_1,h_2,x,y]'<=b(i);
%         end
%         ineq_set_h=[ineq_set_h,ineq];
%     end
%     ineq_set_h=[subs(ineq_set_h,trans_relation_old,trans_relation_new), trans_relation_zero];

%===output==============
M1_tail=fire_a_sequence(M1,sigma_1,TPN);   % the tail marking of left part
M2_tail=fire_a_sequence(M2,sigma_2,TPN);   % the tail marking of right part

%----------------------------
tail_node{1}=M1_tail;
tail_node{2}=M2_tail;
tail_node{3}=ineq_set_h;
end