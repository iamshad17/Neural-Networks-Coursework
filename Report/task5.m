clc;close all;clear all;
load Task4_data.mat;

%%
%preporcessing cause its in 4 input values shape 
Inputk=zeros(16,371);
for k=1:371
    Inum=2*(Input(:,k)-min(Input(:,k)));
    Idem=1+max(Input(:,k))-min(Input(:,k));
Inputk(:,k)=Inum./Idem;
Inputk(:,k)=Inputk(:,k)-1;
end
%%
X=Inputk;t=Target;

%SOFM Method begining
%Clustering
% 16 inputs 3 neurons
M=3 %neurons 3 to 6
w=rand(16,M);
alpha=0.04;
for epoch=1:3
SOFMsamples=100;
e=randperm(SOFMsamples);

%selecting vector randomly from training set

for i=1:SOFMsamples
    d=[];
    for j=1:M %calculates for every neuron
    Dj= norm(X(:,e(i))-w(:,j)); %l2 norm
    d=[d Dj];
    end
    [V,k]=min(d); %k gives winning neuron
    
    %step size decreasing
%     alpha=0.999*alpha;
    
    %weights on winning neuron are updated
    w(:,k)=w(:,k)+alpha*(X(:,e(i))-w(:,k));
    
    %neighbour hood weights updating with radius1
    %need to add and decrease neighbouring of wining
    
    if k<M %for prevent exceeding since doesnt exist grtr than 5
w(:,k+1)=w(:,k+1)+alpha*(X(:,e(i))-w(:,k+1));
    end
    
    if k>1 %since subtracting doesnt exist less than 1
w(:,k-1)=w(:,k-1)+alpha*(X(:,e(i))-w(:,k-1));
    end
    
end
end
%SOFM Method end weights unifromly distributed
%%
% kohnen updating with fixed weights
%training RBF Network

Y=zeros(16,M);
Ynorm=zeros(M,1);
Trainingsamples=100;
gbt=zeros(Trainingsamples,M);
for j=1:Trainingsamples %of 16 size each
    
for i=1:M %neuron norm calculating based on training samples
Y(1:16,i)=X(1:16,j)-w(1:16,i);
Ynorm(i)=norm(Y(1:16,i));
end

%radial basis function calculation of g
dr=w(:);
d=max(dr)-min(dr);
%d is maximum distance between weights in neuron

M=M; %number of neurons
Md=-((M)/(d.^2));
g=zeros(M,1);
for i=1:M
   g(i)=exp((Md*((Ynorm(i).^2)))) ;
end

% gb=[g;1];
 gbt(j,:)=g;

end
%MIMO-LMS

wopt=pinv(gbt)*t(1,1:Trainingsamples)';
%end of radial basis  network training
%%
%testing phase

Y=zeros(16,M);
Ynorm=zeros(M,1);
% gbt=zeros(5,es*es+1)
z=zeros(172,1);


for j=200:371 %testing 200 to 371 samples
for i=1:M %neuron
Y(1:16,i)=X(1:16,j)-w(1:16,i);
Ynorm(i)=norm(Y(1:16,i));
end

%radial basis
dr=w(:);
d=max(dr)-min(dr);
%d is maximum distance between weights in neuron

M=M; %number of neurons
Md=-(M)/(d.^2);
g=zeros(M,1);
for i=1:M
   g(i)=exp((Md*(Ynorm(i).^2))) ;
end

% gb=[g;1];
%  gbt(:,j)=g;
z(j-199)=g'*wopt;
end

%%
%checking True Alarms and False Alarms
o=z;
t=Target;
 ptp=0;ptn=0;pfp=0;pfn=0;
 for i=1:172
 if o(i)>=0
   if  t(1,i+199)==+1
     ptp=ptp+1;
 else
pfp=pfp+1;
   end 
    end
 
 if o(i)<0
     if t(1,i+199)==-1
   
     ptn=ptn+1;
 else
pfn=pfn+1;
 end   
 end
 
 end
 
 %true alarm
 pta=ptp+ptn
 pfa=pfp+pfn
 

