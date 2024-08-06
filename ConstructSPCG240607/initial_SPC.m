function root_node=initial_SPC(M0,TPN)
%= this procedure output the initial state pair class of a TPN system

%=define clock variables
Pre=TPN.Pre;
h_1=sym('h1_%d',[1, length(Pre)],{'integer','positive'});
h_2=sym('h2_%d',[1, length(Pre)],{'integer','positive'});
Phi0=[];

%=Initialize: define the root node
for i=1:size(Pre,2)
    if all(M0>=Pre(:,i))
        ineq1=h_1(i)==0;
        ineq2=h_2(i)==0;
        Phi0=[Phi0, ineq1, ineq2];
    end
end
root_node={M0,M0,Phi0}; % initial state pair class
end