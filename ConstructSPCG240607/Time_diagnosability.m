function is_diag=Time_diagnosability(M0,TPN)
%==whether a TPN system is diagnosable?

%==read the input data=======================
Tf=TPN.Tf;

%=Initialize=================================
[All_SP, Edge, ~]=Compute_SPCG(M0,TPN); % Edge=[{1,'b',[5 6 ],[4 2],2}, {...}, {...}]
is_diag=false;

% step1: read the Edge such that
node_0={1,'normal'}
New={node_0};
All_node={node_0};

%=================================
while ~isempty(New)

    % read the 1-th entry as rootnode
    root_node=New{1};
    New(1)=[];

    % root_node={SPC,tag}, SPC={M1,M2,Phi}
    index=root_node{1};
    tag=root_node{2};
    next_edges=find_next_edge(index,Edge);

    %=for each indistinguishable transition sequence pairs feasible at (MA, MB)
    if ~isempty(next_edges)
        for i=1:length(next_edges)
            edge=Edge{i}; % Edge=[{1,'b',[5 6 ],[4 2],2}]
            sigma_2=edge{4};  % read the right part of the sequence pair
            new_index=edge{end}; % read the next node
            %--------------------------------------------------------
            new_tag='uncertain'; % compute the next tag
            if strcmp(tag,'normal')&& isempty(intersect(sigma_2,Tf))
                new_tag='normal';
            end
            new_node={new_index,new_tag};
            % --------------------------
            if ~ismember_for_cell(new_node,All_node)
                All_node{end+1}=new_node;
                New{end+1}=new_node;
            end
        end
    end
end
end