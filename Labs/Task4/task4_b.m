clc
close all
clear all
load mixtures_task4.mat
fs=12000;t=4;

W=eye(3); %3 mixtures
I=W*W';
L=48000;alpha=0.02;loop=10
s=zeros(3,L)
for k=1:loop
for i=1:L
S=W*U(:,i);
W=W+alpha*(I-2*tanh(S)*S')*W;
alpha=alpha*0.999;
s(:,i)=S;
end
end
figure
plot(s(2,:))
title('unmixed')
figure
plot(U(2,:))
title('mixed')
%sound(s(1,:)/max(s(1,:)),fs) need to normalize  rescale it 
%from -1 to 2 to -10 to 10 graph for speaker rescale
% sound(u(1,:),fs)
