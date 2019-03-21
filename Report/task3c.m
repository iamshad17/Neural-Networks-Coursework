clc;close all;clear all;
load Task3_data.mat
G=I;
Ir=G(:);

pb(64,5814)=0; %each block 200

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
X=pb; %x1 is X(:,1) etcccc so on x5814 
t=X; %target same as X input sinc weights takes care of compression


% bias=ones(1,5814); %training total of 5814 samples 

pc=7

%64-7-64 
%2 layer neural networks
w1b=(rand(pc,64)-0.5)./(64); 
w2b=(rand(64,pc)-0.5)./(7); 
%initialized weights

Xb=[X]; %xbar / xbias
alpha=0.006;


%training backpropogation

for loop=1:20
    
    %randomized start after each testing
%    r=randperm(5814); 
% remmebring is better for compression since we
%    are not predicting or in need of one
%why not random because without randperm its giving better error
    r=1:5814;
   for i=1:5814 %:5814
%    X(:,r(i))%original training input
   
%output calculating using weights we are estimating
   u1=w1b*Xb(:,r(i)); %summation
   o1=tanh(u1); %bipolar sigmoid function
   o1b=[o1]; %bias addd
   u2=w2b*o1b;
   y=tanh(u2);
   
   %weight corrections for each layer using original
   
   e=t(:,r(i))-y;% estimated error from original
   
   %back propogation
   a2=tanh((u2)).^2;
   b2=ones(length(u2),1);
   c2=b2-a2;
   d2=diag(e)*c2; %transposed already b writing in matrix
   dw2=alpha*d2*(o1b)';
   
   a11=(tanh(u1)).^2;
   b11=ones(length(u1),1);
   c1=b11-a11;
   d1=(diag((w2b(:,1:pc))'*d2))*c1;
   dw1=alpha*d1*(Xb(:,r(i))');
   %updating weigts for each traning loop
   w2b=w2b+dw2;
   w1b=w1b+dw1;
    end
   
      
end
  
%without bias
w1ob=w1b;
w2ob=w2b;

   %now we get w1 for compression and w2 to restore it
   %testing
   compression=w1ob*pb;
      reconstuction=w2ob*compression;
    
   o=reconstuction;
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
figure
imshow(op)
   
   
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


   
   
   
