clc;close all;clear all;
load Task1_data.mat;

%%
%Hopfield Start

%all digits matrix form
%learning
X=zeros(120,8)
X1=zeros(120,1)
for i=1:8
X1(:)=digits(:,:,i)
X(:,i)=X1;
end
Y=X; %output same as input

% % weights of all digits are adding initally and keeping as memory
% W1=zeros(120,120)
% for v=1:8
% X1=digits(:,:,v);
% X=X1(:); %colunm wise taking noteeeee
% Y=X;
% W=Y*X'
% W1=W1+W
% end
% %in this W COLUNM 1 IS 1ST OUPUT AND ALL INPUTS

% pinv works and giving best for auto associative meory
W=Y*pinv(X);
% diagonal zero pinv for autocoreelation symentric matrix
for h=1:120
W(h,h)=0;
end
% 
% %correlation works best for hetro association
% W=Y*X'; %Y=X Auto association matrix form adding weights
% % diagonal zero
% W=W-8*eye(120); %8 digits memory it has
% % training done fixed weights

%testing for convergence
ip=heavily_distorted_digits; %input unkown distorted digits
opt=zeros(12,10,6);
for t=1:6 %6 heavily distorted digits
onedigit=ip(:,:,t);
onedigitr=onedigit(:); %digit to colunm
s0=onedigitr; %initialising state vector using noisy input vector
% r2=s0' %obs randperm takes row vector even if colunm vector
s1=zeros(120,1);
Wn=zeros(120,120);
qa=0;p=2; %qq counter if while for loops counting
%   while p>1  %converging criteria s remains unchanged
    for loop=1
    qa=qa+1; %counter
    j=randperm(length(s0)); %each loop randmoizing

    theta=0; %must be thetaj though kept 0 for now so no need
%updating where j is choosen randomly matrix way 

for u=1:120
    s1(j(u),1)=sign(W(j(u),:)*s0-theta);
    %s1 each digit rowsdata state j is different digits
%s0 old state s1 new state
end

%repeats updating until s remains unchanged using while only
% 
if (s1==s0) %converging criteria s remains unchanged
   p=0 %p is taken 2 initally and  stops when no change in states
end

s0=s1; %new state replacing old state each loop
%output is final state
 end

%output displaying automatically every digit after correcting digit
op=vec2mat(s1,12)'; 
opt(:,:,t)=op;
figure (1)
title('Hopfield')
subplot(2,3,t)
imshow(op)
hold on
end

%each digit over
% if (s1==s0) %obs its last value digit only checking
%     %     display( ' changed states converging')
% end   
%Hopfield end

%%
    
% for Q=1:6
%     subplot(2,3,Q)
%     imshow(ip(:,:,Q))
% figure (3) %for comparing with old ones input
% title('Input Heavily Distorted Digits')
% hold on
% end


%%
%stochastic boltzman since it stablized 
%at other points than desired ones in local minimums

for ff=1:6
pot=opt(:,:,ff);
pt=pot(:);
%not choosen w randomly j
theta=0; %bias
% T=120%temperature constant
% for loop=1:4
q=0;    T=1; %4 for Hopfield output 7 but high randomness in zero to get
%as t is zero it approaches hopfield 
%for now keeping zero for testing hopfield
u=zeros(120,1);s5=zeros(120,1);
ss=zeros(120,1);

xi=pt;p=2;
% while T<0.01 
%stopping condition can be t reaches to zero 
%as no change in optimum after reaching boltzman same as boltzman
%     q=q+1
 for loop=1
%  while p>1  %converging criteria s remains u  nchanged

for j=1:120
u(j)=W(j,:)*xi-theta;
p(j)=1/(1+exp(-(u(j))/T)); %pj is giving alwasys CLOSE TO 0 or 1 check
%since its probability and random we are comparing 
%with random value and if high probability then no doubt it will
%give 1 sometimes even if high probability it may come 0
%the rand takes care of this randomnesssssssss by comparing

if rand<=p(j) 
    ss(j,1)=+1;
else
    ss(j,1)=-1;
end
T=0.7*T; %new state as less T faster reaches to zero and hopfield
%high scalar multiplier slower it reaches to zero aftr iteration
end

xi=ss;
end
figure(2)
title('Boltzman Output')
opp=vec2mat(xi,12)';
subplot(2,3,ff)
imshow(opp)
hold on
end
