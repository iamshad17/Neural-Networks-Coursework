    clc
close all
clear all
load picture1_task3.mat

imshow(G);
a=0;bo=1;co=1
pb(200,588)=0; %each block 200
% 10 by 20 block gives 28,21

a=10;b=20;pp=0;

% per block
[m n]=size(G)
a1=m/a;b1=n/b
for j=1:a1
pbb=zeros(a,b);
    for i=1:b1
        pbb=G(a*(j-1)+1:a*j,b*(i-1)+1:b*i);
   pp=pp+1;
        pb(:,pp)=pbb(:) ;
    end
end
% 588 blocks of each size 200 input vectors 

x=zeros(200,588);
x=pb

% x=[pb(:,1);pb(:,2) ...]

% somewhere wrong starting from here
% mm=150; % m<n weight principal components must be less than length of input vector
w=(rand(200,150)-0.5)./150; %150 weights from each input going into 588 neurons
% for small weights
w=w'
% generalized hebbian algorithm
alpha=0.01;
yr=zeros(150,588)
wo=0;
br=0
on=1
q=0;
% need to add stop criteria condition instead of loop
% error stopping is better than weight which never converges
% can try normalsing old and new weights too
loop=100;
for j=1:loop
     q=q+1;
    i=0;
ar=randperm(588);
    for s=1:588
        br=ar(s);
    yr(:,br)=w*(x(:,br));
w=w+alpha*(yr(:,br)*x(:,br)'-tril(yr(:,br)*yr(:,br)')*w);
    end 
     alpha=0.99*alpha;
end
% problem with learning
o=zeros(200,588)

for u=1:length(x)
o(:,u)=w'*yr(:,u); %check here yr
end
% then need to check regetting here

 
% rearranging works good tested by keeping pb
% pb has 588 blocks in colunm which should be rearranged
bck3=zeros(a*a1,b*b1);
 pp=1 
 for j=1:a1
     for i=1:b1
%      bck=pb(:,pp)
bck=o(:,pp)
 bck2=vec2mat(bck,a)';
%how to rearrange blocks now into 28 and 21 of 10 by 20
 op(a*(j-1)+1:a*j,b*(i-1)+1:b*i)=bck2;
 pp=pp+1;
     end
 end

figure
imshow(op)