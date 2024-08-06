function Diag=diagnoser(TPN,M0)
%this func. return the logic diagnoser of a TPN
%=================================
%=the initial node is tagged with 'normal'
ds0={M0, M0, 'normal'};
DS{1}=ds0;
Edge={};
Tf=TPN.Tf;

%=================================
New={ds0}; %the set of nodes to be further explored
while ~isempty(New)
 %=read the 1-th entry as rootnode
 root_node=New{1};
 New(1)=[];
 %=root_node={MA,MB,tag}
 M1=root_node{1};
 M2=root_node{2};
 tag=root_node{3};
 %=sp_class is the set of transition sequence pairs to be explored
 sp_class=find_sequence_pairs(M1,M2,TPN);

 %=for each indistinguishable transition sequence pairs feasible at (MA, MB)
 for i=1:length(sp_class)
     %=====================================================================
     %=compute the new node
     %current_sp={[...],[...]}, the transition sequence pair to be fired
     current_sp=sp_class{i};
     new_MA=fire_a_sequence(M1,current_sp{1},TPN);
     new_MB=fire_a_sequence(M2,current_sp{2},TPN);
     newtag='uncertain'; %default setting
     %=if the root node is 'normal' and current_sp{2} is 'normal', the
     %resulted node is 'normal'; current_sp{1} is defaultly 'normal'. 
     if strcmp(tag,'normal')&& isempty(intersect(current_sp{2},Tf))
         newtag='normal';
     end
     newnode={new_MA,new_MB,newtag};

     %=====================================================================
     %=add new edge
%    edge=struct('root_node',root_node,'label',Proj(current_sp{2},TPN),'sequence_pair',current_sp,'tail_node',newnode);
     Edge{end+1}={root_node,Proj(current_sp{2},TPN),current_sp,newnode};

     %=====================================================================
     %=if the newnode is 'new', add it to DS, to queue for further exploration;
     if ~ismember_for_cell(newnode,DS)
         DS{end+1}=newnode;
         New{end+1}=newnode;
     end
 end
end
 Diag={DS,Edge,ds0};
end

