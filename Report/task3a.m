clc;close all;clear all

load Task3_data

figure(1)
imshow(I)


G=I;
Ir=G(:); 

%% picture Blocks
pb(64,5814)=0; %each block 64

a=8;b=8;pp=0;

% Dividing Image into blocks by rows and colunms blocks
[m n]=size(G);
a1=m/a;b1=n/b;
for j=1:a1%rows
pbb=zeros(a,b);
    for i=1:b1 %colunms
        pbb=G(a*(j-1)+1:a*j,b*(i-1)+1:b*i); 
   pp=pp+1;
        pb(:,pp)=pbb(:) ;%keeping blocks in one multiple colunms
    end
end
%pb is our xb
%% Auto Correlation
Rxx=(pb*pb')/5814;
[V,ev]=eig(Rxx) ;
%returns diagonal matrix D of generalized eigenvalues and full matrix 
%V whose columns are the corresponding right eigenvectors, 
%eigen vectors V and diagonal are eigen values
eigenvalues=(diag(ev));
%eigen vectors of autocorrelation matrix explains variance
%Note that, the principal components are really 
%the eigenvalues sorted in descending order, i.e., d64 ? ... ? d2 ? d

aa=zeros(63,1);bb=zeros(63,1)
for pc=1:63 %How many principal components taking for better clarit
    
% M=1:pc is what it takes
M=64-pc+1:64; %variance is larger at end so taking from ending.
%  V1=V(:,M); %decreasing order try later

Q=V(:,M); %Q is compression matrix V is eigen vectors
%Q taking from back since eigen values sorted decreasing order
%from back due to varience

yb=zeros(pc,5814); %for compression definign
for k=1:5814
yb(:,k)=(Q')*pb(:,k); %each block
end

%4 principal components instead of 64 original pb

%reconstructing Q*yb or full at once
ub=Q*Q'*pb;
o=ub;
%reconstructed from compression using principal components


%% rearranging works good tested by keeping pb oringal and seeing
% pb has 5814 blocks in colunm which should be rearranged
% bck3=zeros(a*a1,b*b1); %back to orignal picture
 pp=1; 
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
%% For -17 db Compressed figure and Image unreadable
if (pc==5)
figure(2)
  imshow(op)
  title('output of compressed rearraged blocks')
 hold on
end
 %% Mean Square Error
 emse1=0;emse2=0; %check this
for i=1:456
    for j=1:816
       en= (I(i,j)-op(i,j)).^2;
       %I is input op is output after compression
       ed=(I(i,j)).^2;
    emse1=emse1+en;
    emse2=emse2+ed;
    end
end
emse=emse1./emse2;
emsedb=10*(log10(emse));

aa(pc)=emsedb; %giving error to respective principal components

% err = immse(pb,ub); %comand based mean square error
% err2=10*log10(err);

CM=100*(1-(pc/64));
bb(pc)=CM; %giving compression of respective principal
 

end

%% plotting emse vs Cm
figure(3)
 plot(aa,bb,'*') %aa error bb compression prinicipal componnents
 title('Mean Square Error vs Compression')
 xlabel('EMSE')
 ylabel('C(M)')
 hold on





