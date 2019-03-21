clc
close all
clear all
mean=0;
variance=1;
r=1;c=5000;
%independent gaussian distributed
%zero mean random variables and unit variance
e1=normrnd(mean,variance,[r c]); 
e2=normrnd(mean,variance,[r c]);
e3=normrnd(mean,variance,[r c]);

%mutual dependent variables
x1=e1;
x2=-0.5*x1+0.5*e2;
x3=0.4*x1+0.2*x2+0.1*e3;
x=[x1;x2;x3];
Rxx=x*x'; %correlation 3 by 3 matrix is it correct without expectation
%eigen vectors doesnt change direction it can increase or decrease based on
%eigen values which will be helpful for changing dimensions
[em,ev]=eig(Rxx) %eigen vectors em and diagonal are eigen values
eigenvalues=diag(ev);%eigen vectors of autocorrelation matrix explains variance
plot3(x1,x2,x3,'.'); %directly plotting co-ordinates 3d simialr to 2d no function unlike surfplot

m=3; % m<n weight principal components must be less than length of input vector
w=rand(m);

%generalized hebbian algorithm
alpha=0.02;
y=zeros(3,5000)
wo=0;
b=0
on=1
q=0;
%need to add stop criteria condition instead of loop
%error stopping is better than weight which never converges
%can try normalsing old and new weights too
% loop=1;
% for j=1:loop
 while on
    q=q+1;
    i=0;
    a=randperm(length(x));
       for s=1:length(x)
    i=i+1;
    b=a(i);
    y(:,b)=w*(x(:,b));
w=w+alpha*(y(:,b)*x(:,b)'-tril(y(:,b)*y(:,b)')*w);
    end
    %checking for ever loop
 e4=wo*(x)-y; %new -old
 ee1=abs(e4);
 if (ee1<0.3) 
on=0;
end
wo=w;
  end

for u=1:length(x)
o(:,u)=w'*y(:,u);
end

figure
plot3(o(1,:),o(2,:),o(3,:),'.')
title('recontructed')

% princcipal components
% w=abs(w) 
%to prevent negative
figure
%method1
% wo1=[w(1,1),w(2,1),w(3,1);0,0,0]
% wo2=[w(1,2),w(2,2),w(3,2);0,0,0]
% wo3=[w(1,3),w(2,3),w(3,3);0,0,0]
%method2
% wo1=zeros(2,3);
% wo2=zeros(2,3);
% wo3=zeros(2,3);
% wo1(1,:)=w(:,1);
% wo2(1,:)=w(:,2);
% wo3(1,:)=w(:,3);
% plot3(wo1(:,1),wo1(:,2),wo1(:,3))
% hold on
% plot3(wo2(:,1),wo2(:,2),wo2(:,3))   
% hold on
% plot3(wo3(:,1),wo3(:,2),wo3(:,3))
% hold off
%method3
w=abs(w)
    es=5
plot3([linspace(0,w(1,1),es)],[linspace(0,w(2,1),es)],[linspace(0,w(3,1),es)],'k')
hold on
plot3([linspace(0,w(1,2),es)],[linspace(0,w(2,2),es)],[linspace(0,w(3,3),es)],'k')
hold on
plot3([linspace(0,w(1,3),es)],[linspace(0,w(2,3),es)],[linspace(0,w(3,3),es)],'k')
hold on
plot3([linspace(0,em(1,1),es)],[linspace(0,em(2,1),es)],[linspace(0,em(3,1),es)],'r')
hold on
plot3([linspace(0,em(1,2),es)],[linspace(0,em(2,2),es)],[linspace(0,em(3,3),es)],'r')
hold on
plot3([linspace(0,em(1,3),es)],[linspace(0,em(2,3),es)],[linspace(0,em(3,3),es)],'r')
hold off

% from 0 to 1 i think linspace or anyother is straight line only curve
% linspace gives better i guess


%need to use linespace x for smoother graph
%but linspace helps if you want to know how many points
%you want to insert in graph
% x=[1:0.1:2]
% y=linspace(1,2,11) %gives output same as x


