function [zero_h,trans_relation_A,trans_relation_b]=clock_transformation(root_node,sequence_pair,TPN)
%-this function returns the coordinate transformation relation for the
%computation of state pair class
%===========================================================
%-load datas
Pre=TPN.Pre;
M1=root_node{1};
M2=root_node{2};
sigma_1=sequence_pair{1};
sigma_2=sequence_pair{2};

%-define the symbols===============================================
x=sym('x',[1, length(sigma_1)],{'integer','positive'});% x is the parametric time intervals of sigma_1
y=sym('y',[1, length(sigma_2)],{'integer','positive'});% y is the parametric time intervals of sigma_2
h_1=sym('h1_%d',[1, length(Pre)],{'integer','positive'});% h_1 is the set of clocks of the left part
h_2=sym('h2_%d',[1, length(Pre)],{'integer','positive'});% h_2 is the set of clocks of the right part

%-compute the markings=====================================================
M1_tail=fire_a_sequence(M1,sigma_1,TPN);   % the tail marking of left part
M2_tail=fire_a_sequence(M2,sigma_2,TPN);   % the tail marking of right part
% transition relation between the timing variables of root node and tail node
zero_h=[];
trans_relation_A=[];     % variables to be eliminated
trans_relation_b=[];

%--------------------------------------------------------------------------
for j=1:length(Pre) % for all t_j \in T
    if all(M1_tail>=Pre(:,j)) %if t_j\in En(M1[sequence_1>), note, here M1,M2 is cahnged as above
        E_vec=Enabling_vector(j,M1,sigma_1,TPN);
        if E_vec*[h_1(j),x]'~=0
            %----store E_vec tp coherent with [h1,h2,x,y]
            temp_h1=zeros(1,length(h_1));
            temp_h1(j)=E_vec(1);
            temp_x=[E_vec(2:end)];
            trans_relation_A=[trans_relation_A;temp_h1,zeros(1,length(h_2)),temp_x,zeros(1,length(y))];
            %------------------------
            temp_b=zeros(1,length(h_1)+length(h_2));
            temp_b(j)=1;
            trans_relation_b=[trans_relation_b;temp_b];
        else
            zero_h=[zero_h, h_1(j)==0];
        end
    end
    %--------------------------------------------------------------------------
    if all(M2_tail>=Pre(:,j)) %if t_j\in En(M2[sequence_2>)
        E_vec=Enabling_vector(j,M2,sigma_2,TPN);
        if E_vec*[h_2(j),y]'~=0
            %----store E_vec tp coherent with [h1,h2,x,y]
            temp_h2=zeros(1,length(h_2));
            temp_h2(j)=E_vec(1);
            temp_y=[E_vec(2:end)];
            trans_relation_A=[trans_relation_A;zeros(1,length(h_1)),temp_h2,zeros(1,length(x)),temp_y];
            %----------------------------
            temp_b=zeros(1,length(h_1)+length(h_2));
            temp_b(length(h_1)+j)=1;
            trans_relation_b=[trans_relation_b;temp_b];
        else
            zero_h=[zero_h, h_2(j)==0];
        end
    end
end
end