function [All_SP, Edge,node_0]=Compute_SPCG(M0,TPN)
%==================================

%=Initialize: define the root node
node_0=initial_SPC(M0,TPN); % each node is a SPC
All_SP={node_0};     % the set of all state pair class
Edge={};           % direct relation
New={node_0};  % unexplored classes

%=================================
while ~isempty(New)

    % read the 1-th entry as rootnode
    root_node=New{1};
    New(1)=[];

    % root_node={M1,M2,Phi}
    index=ismember_for_cell(root_node,All_SP);
    M1=root_node{1};
    M2=root_node{2};

    % sp_class is the set of transition sequence pairs to be explored
    sp_class=find_sequence_pairs(M1,M2,TPN);

    %=for each indistinguishable transition sequence pairs feasible at (MA, MB)
    for i=1:length(sp_class)
        sequence_pair=sp_class{i};    % read a sequence pair
        [A,b]=timing_constraints_for_sequence_pair(root_node,sequence_pair,TPN); % the corresponding timing constraints
        [~,~,existflag]=linprog(zeros(1,size(A,2)), A, b);
        %---------------------------------------------------
        if existflag==1
            tail_node=next_state_pair_class_2(root_node,sequence_pair,A,b,TPN); % compute the next SPC

            %=====================================================================
            %=whether the newnode is a 'new' one?
            new_index=ismember_for_cell(tail_node,All_SP); % new_index=0 if it is a new node
            if ~new_index
                All_SP{end+1}=tail_node;
                New{end+1}=tail_node;
                new_index=length(All_SP); % update the index of the tail_node
            end

            % add the direct relation into Edge
            Edge{end+1}={index,Proj(sequence_pair{2},TPN),sequence_pair{1},sequence_pair{2},new_index};
        end
    end
end
end