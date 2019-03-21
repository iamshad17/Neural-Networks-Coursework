clc
close all
clear all
x1=lapdist(0,1,1,10000);
x2=lapdist(0,1,1,10000);

P=zeros(1,7)
for k=1:3
A=randi([1 10],2,2);
X=[x1;x2];
U=A*X; %mixed
W=eye(2); %2 mixtures
I=W*W';
L=100;alpha=0.02;
for i=1:L
S=W*U(:,i);
W=W+alpha*(I-2*tanh(S)*S')*W;
alpha=alpha*0.999;
end
P(:,k)=cond(W*A)
end
%need to plot so that all comes 1 almost exactly
%otherwise mixing gone wrong
stem(P)