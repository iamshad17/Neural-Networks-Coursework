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
%Initiating values

%16-3-1 %16 features emi input and 1 output
%2 layer neural networks
%trail and error to decide hidden neurons for min mse
%more nodes less generalization 
%higher training more
n=16;m=3;k=1; %try between 8,11 and 15 
%layers remembers most frequent easy linear classification
%maybe 3 layer performs better

%randomly assigning small numbers
w1b=(rand(m,n+1)-0.5)./(n+1); %1 is bias to give flexibility 
w2b=(rand(k,m+1)-0.5)./(m+1); %like zero input weight doesnt matter


bias=ones(1,length(Inputk));

X=Inputk;
Xb=[X;bias]; %xbar / xbias
alpha=0.038;
t=Target;

%%
%Training Neural Network  using back propogatiion

for epoch=1:42
 %epoch no of times updating training samples
     train=100;
    %randomized start after each testing 
    %dont want network to remember thatswhy epoch
   r=randperm(train);
   yo=zeros(1,train);
%%
   for i=1:train 
   
%output calculating using weights we are estimating
%1st layer  Xb Input
   u1=w1b*Xb(:,r(i)); %includes bias
   o1=tanh(u1); %bipolar sigmoid function
  %2nd layer hidden o1 plus bias input 
   o1b=[o1;1]; %bias addded
   u2=w2b*o1b;
   
   y=tanh(u2);
   
   %weight corrections for each layer using original
   
   e=t(:,r(i))-y;% estimated error from original
   
   %back propogation
   a2=(tanh(u2)).^2;
   b2=ones(length(u2),1);
   dgu2=b2-a2;
   
   %local error vector d and change in weight dw
   d2=diag(e)*dgu2; 
   dw2=alpha*d2*(o1b)';
   
     
   a1=(tanh(u1)).^2;
   b1=ones(length(u1),1);
   dfu1=b1-a1;
   
   d1=(diag((w2b(:,1:m))'*d2))*dfu1; %weight no bias so m
   dw1=alpha*d1*(Xb(:,r(i))');
   
   %      eo(1,r(i))=t(:,r(i))-y;% estimated error from original
    yo(1,r(i))=y;
   %yo contains output of all sets after training for a iteration
   
   %updating weigts for each traning loop
   w2b=w2b+dw2;
   w1b=w1b+dw1;
      
   end
   %end of back propgation for a iteration
%%
%plotting false alarm rates for each iter during training epochs
efp=0;efn=0;ctp=0;ctn=0;
%changing outputs into +1 and -1
yoc=zeros(1,train);

for ii=1:train
    if yo(1,ii)>=0
        yoc(1,ii)=+1;
    else
        yoc(1,ii)=-1;
    end
end
    
 %checking for false postivies and negatives rates
for ar=1:train

    if (yoc(1,ar)==+1) %false positive
ctp=ctp+1;
        if (t(1,ar)==-1)
efp=efp+1;
    end
end

if (yoc(1,ar)==-1) %false negative
  ctn=ctn+1;
    if (t(1,ar)==+1)
efn=efn+1;
    end
end
end
% end of counting false alarm rates 

figure(2)
title('false poitive and false negative training epochs')
legend('Falsepositive','Falsenegative')
xlabel('Training Epochs')
ylabel('False Alarm Rates')
  
plot(epoch,efp/ctp,'*')
   hold on
   plot(epoch,efn/ctn,'o')
   hold on
Far=efp/ctp+efn/ctn; %False Alarm Rates
   figure(3)
title('Epochs Errors vs Validation Errors')
legend('Epoch-Errors','CrossCheck-Errors')
xlabel('Training Epochs')
ylabel('False Alarm Rates')
   plot(epoch,Far,'*') %training errors since false
   hold on
   
   %%
   %generalization checking during training based on each loops
  %recreating based on inputs

 gr=Xb(:,100:200); %next 100 samples

go=zeros(length(gr),1); %output for cross check

 for i=1:100 %100 to 200
%    X(:,r(i))%original training input vs Bias Input
   
%output calculating using weights we are estimating
   u1=w1b*gr(:,i); %100 to 200 input samples
   o1=tanh(u1); %bipolar sigmoid function
   o1b=[o1;1]; %bias addd
   u2=w2b*o1b;
   y=tanh(u2);
   go(i,1)=y'; %output got from 100 to 200 inputs
 end
    
%plotting false alarm rates for each iter of Validation Samples
efpv=0;efnv=0;vtp=0;vtn=0;

%changing outputs into +1 and -1
goc=zeros(1,train);

for ii=1:100 %validation samples length here
    if go(ii,1)>= 0
        goc(ii,1)=+1;
    else
        goc(ii,1)=-1;
    end
end
    

for vs=1:100 %validation samples length here
if (goc(vs,1)==+1) %false positive of validation samples
    vtp=vtp+1;   
    if (t(1,vs+100-1)==-1) %100 to 200 targets need to take
efpv=efpv+1;
    end
end

if (goc(vs,1)==-1) %false negative of validation samples
  vtn=vtn+1;
    if (t(1,vs+100-1)==+1)
efnv=efnv+1;
    end
end
end

%end of assining rates

%testing errors based on loops generalization
   vtpn=(efpv./vtp)+(efnv./vtn);
plot(epoch,vtpn,'o')
   hold on
     
end

%%

%testing phase

%recreating based on inputs

 rboi=Xb(:,200:371);

 
to=zeros(length(rboi),1);
 for i=1:172 
%    X(:,r(i))%original training input
   
%output calculating using weights we are estimating
   u1=w1b*rboi(:,i); %summation
   o1=tanh(u1); %bipolar sigmoid function
   o1b=[o1;1]; %bias addd
   u2=w2b*o1b;
   y=tanh(u2);
   to(i,1)=y' %output for 200 to 371 inputs
 end
 %end of checking got outputs
 %%
 %checking how good our network performed
 
 %by comparing with our data targets
 ptp=0;ptn=0;pfp=0;pfn=0;
 for i=1:172
     %got positive output checking
 if to(i)>= 0 %works same as +1
   if  t(1,i+199)==+1
     ptp=ptp+1;
 else
pfp=pfp+1;
   end 
 end
 
    %got negative output checking
 if to(i)<0 %works same as -1
     if t(1,i+199)==-1
   
     ptn=ptn+1;
 else
pfn=pfn+1;
     end   
  end
 
 end
 
 %true alarm vs false alarm
 pta=ptp+ptn
 pfa=pfp+pfn
 