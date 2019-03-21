clc;close all;clear all

load Task3_data
figure
imshow(I)
G=I;
Ir=G(:);



pb(64,5814)=0; %each block 200
% 10 by 20 block gives 28,21

a=8;b=8;pp=0;

% per block
[m n]=size(G);
a1=m/a;b1=n/b;
for j=1:a1
pbb=zeros(a,b);
    for i=1:b1
        pbb=G(a*(j-1)+1:a*j,b*(i-1)+1:b*i);
   pp=pp+1;
        pb(:,pp)=pbb(:) ;
    end
end

Rxx=(pb*pb')/5814;
[V,ev]=eig(Rxx) ;
%returns diagonal matrix D of generalized eigenvalues and full matrix 
%V whose columns are the corresponding right eigenvectors, 
%eigen vectors V and diagonal are eigen values
eigenvalues=(diag(ev));
%eigen vectors of autocorrelation matrix explains variance
%Note that, the principal components are really 
%the eigenvalues sorted in descending order, i.e., d64 ? ... ? d2 ? d


x=zeros(64,5814);
x=pb;

% x=[pb(:,1);pb(:,2) ...]

% somewhere wrong starting from here
% mm=150; % m<n weight principal components must be less than length of input vector
pc=11
w=(rand(64,pc)-0.5)./60; %150 weights from each input going into 588 neurons
% for small weights
w=w';
% generalized hebbian algorithm
alpha=0.01;
yr=zeros(pc,5814);
wo=0;
br=0
on=1
q=0;
% need to add stop criteria condition instead of loop
% error stopping is better than weight which never converges
% can try normalsing old and new weights too
% for loop=1:30; %for checking emse iterations -17db
 loop=10
for j=1:loop
     q=q+1;
    i=0;
ar=randperm(5814);
    for s=1:5814
        br=ar(s);
    yr(:,br)=w*(x(:,br));
w=w+alpha*(yr(:,br)*x(:,br)'-tril(yr(:,br)*yr(:,br)')*w);
    end 
     alpha=0.99*alpha;
end
% problem with learning
o=zeros(64,5814);

for u=1:length(x)
o(:,u)=w'*yr(:,u); %check here yr
end
% then need to check regetting here


o=o;
% rearranging works good tested by keeping pb
% pb has 588 blocks in colunm which should be rearranged
bck3=zeros(a*a1,b*b1);
 pp=1 
 for j=1:a1
     for i=1:b1
%      bck=pb(:,pp)
bck=o(:,pp);
 bck2=vec2mat(bck,a)';
%how to rearrange blocks now into 28 and 21 of 10 by 20
 op(a*(j-1)+1:a*j,b*(i-1)+1:b*i)=bck2;
 pp=pp+1;
     end
 end
figure(5)
imshow(op)
hold on
emse1=0;emse2=0; %check this
for i=1:456
    for j=1:816
       en= (I(i,j)-op(i,j))^2; %I is input op is output
       ed=(I(i,j))^2;
    emse1=emse1+en;
    emse2=emse2+ed;
    end
end
emse=emse1/emse2
emsedb=10*log10(emse)

% err = immse(pb,o) %comand based error
% err2=10*log10(err)
% CM=100*(1-(pc/64))
figure(6)
plot(loop,emsedb,'*')
hold on
% end %for checking iterations based error









