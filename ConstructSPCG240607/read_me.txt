This procedure can compute the state pair class graph of a labeled TPN 
and verify its diagnosabillity.

To start this procedure, open the ''input.m''
In this page, one need to write the TPN system and then 'run'.
The TPN system given in Figure 1 is:

M0 = [0 0 0 1 0 0]';
TPN.Pre= [[0 1 0 0 0 0]' [0;0;1;0;0;0] [1;0;0;0;0;0] [0;0;0;1;0;0]  [0;0;0;1;0;0] [0;0;0;0;1;0] [0;0;0;0;0;1]];
TPN.Post=[[0;0;1;0;0;0] [1;0;0;0;0;0] [0;1;0;0;0;0] [1;0;1;0;0;0]  [0;0;0;0;1;0] [0;0;0;0;0;1] [0;0;0;0;1;0]];
TPN.Intervals=[[3,7]'  [2,8]' [3,9]' [4,8]' [3,7]' [6,8]' [7,8]']; 
TPN.Labels={'a','b','eps','eps','eps','b','a'};
TPN.Tf=[4];

function [All_SP, Edge,node_0]=Compute_SPCG(M0,TPN) can compute the state pair class graph, where All_SP is the set of all state pair classes, Edge is the transition function, and node_0 is the initial state pair class;

function [All_SP, Edge]=T_diag(M0,TPN) will anwser whether the system is diagnosable and
output a counter-example if the system is not diagnosable;
for example, 
%     {[1]}    {1×1 cell}    {[5 6]}  {[4 2]}    {[2]}
%     {[2]}    {1×1 cell}    {[7]}    {[3 1]}    {[5]}
%     {[5]}    {1×1 cell}    {[6]}    {[2]}    {[9]}
%     {[9]}    {1×1 cell}    {[7]}    {[3 1]}    {[5]}

it mean that there exists a sequence of state pair classes:
 All_SP{1}->All_SP{2}->All_SP{5}->All_SP{9}->All_SP{5}
and the corresponding transition sequence pair is 
(t5 t6 t7 t6 t7, t4 t2 t3 t1 t2 t3 t1).
It supports that the system is not diagnosable