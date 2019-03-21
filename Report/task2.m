clc;close all;clear all;
load Task2_data.mat


J1r=J1(:);
J2r=J2(:);
U=zeros(2,50000)
U(1,:)=J1r(:,1)'
U(2,:)=J2r(:,1)'

W=eye(2); %2 mixtures
I=W*W';
L=50000;alpha=0.02;loop=1;
%less stepsize better image
%wbt stepsize and loops convergence
%too less stepsize artifacts observed even loops not correcting
%w.r.t convergence and stepsize
 s=zeros(2,L)
 for k=1:loop
 for i=1:L
 S=W*U(:,i);
 W=W+alpha*((I-2*tanh(S)*S'))*W; % divide by 50000
alpha=alpha*0.99;
 s(:,i)=S;
 end
 end
 
 a=s(1,:)
 b=s(2,:)
 o1=a';
 o2=b';
 ov1=vec2mat(o1,200)'
 ov2=vec2mat(o2,200)'

 
figure
imshow(J1)
figure
imshow(J2)

figure
imshow(ov1)
figure
imshow(ov2)

