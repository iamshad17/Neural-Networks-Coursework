clc
close all
clear all
x1=[-1:0.1:3] %x1 belongs to -1 to 3
x2=[-3:0.1:3] %x2 belongs to -3 to 3
[X1,X2]=meshgrid(x1,x2);
FX=sin((X1.^2)./4+(X2.^2)./2);
% mesh(X1,X2,FX);
surf(X1,X2,FX);


%sampling input x1,x2s to create target sequence

k=ones(61,41)
a=X1(:);
b=X2(:);
d=FX(:);
kk=k(:);

%colunm wise



%2-5-4-1 
%3 layer neural networks
m=5;
n=2;
k=4;
p=1;
%randomly assigning
w1=(rand(m,n+1)-0.5)./(n+1); %1 is bias
w2=(rand(k,m+1)-0.5)./(m+1);
w3=(rand(p,k+1)-0.5)./(k+1);

ct=1

old1=0;
old2=0;
old3=0;
%initating condition
s2(2501)=0
h2(2501)=0
for oi=1:100
    
%     i=0
% a=randperm(10)
% % this is matlab for loop not for c loop
% %colunm wise is taking
% for t=a
%     i=i+1
% end
e=randperm(length(a)); 
%be careful with randperm
for i=1:2501
X11(i)=a(e(i)); %here e f g are colunm number randomly choosen
X22(i)=b(e(i));
O44(i)=kk(e(i));
FX2(i)=d(e(i));
end
%w.r.t to e f g values in a,b,c are taken randomly


    for j=1:2501
    gamma=1;
x=[X11(j);X22(j);O44(j)]; 
%weights initating based on inputs and outputs
u1=w1*x;
o1=tanh(gamma.*u1);
o1b=[o1;1];
u2=w2*o1b;
o2=tanh(gamma.*u2);
o2b=[o2;1];
u3=w3*o2b;
yy=tanh(gamma.*u3); %output for given inputs
s2(j)=yy;

   %2-5-4-1 
ee(j)=FX2(j)-yy;

%back propgation
ssz=0.03; %alpha step size
%local vectors
d3=diag(ee(j))*(1-tanh((u3(1).^2)))';
dw3=ssz*d3*(o2b)';
d2=diag(((w3(:,1:4))')*(d3))*[(1-tanh((u2(1).^2))) (1-tanh(u2(2).^2)) (1-tanh(u2(3).^2)) (1-tanh(u2(4).^2))]';
dw2=ssz*d2*(o1b)';
d1=diag(((w2(:,1:5))')*(d2))*[(1-tanh((u1(1).^2))) (1-tanh(u1(2).^2)) (1-tanh(u1(3).^2)) (1-tanh(u1(4).^2)) (1-tanh(u1(5)).^2)]';
dw1=ssz*d1*(x)';

%updating weights
w3=w3+dw3;
w2=w2+dw2;
w1=w1+dw1;



%still need to stop updating criteria
%if trying  weights or error till zero then generalization occurs we need to prevent it

    end
    
    % for t=1:2501
%     rr=[X11(t);X22(t);O44(t)];
% u11=old1*rr;
% o11=tanh(gamma.*u11);
% o11b=[o11;1];
% u21=old2*o11b;
% o21=tanh(gamma.*u21);
% o21b=[o21;1];
% u31=old3*o21b;
% h2(t)=tanh(gamma.*u3); %output for given inputs
% end
% %error correction
% e=h2-s2;
% e1=abs(e);
% if (abs(e)<0.05)
%     ct=0
% end
% 
% old1=w1;
% old2=w2;
% old3=w3;
end


%making linearly output sofa shape
%need to fix weights 
%feed forward network
%without equation but creating based on weights we created

%recreating tried based on feed forward network weights should have almost shape
i1=[-1.2:0.1:2.8] %x1 belongs to -1 to 3
i2=[-3.2:0.1:2.8] %x2 belongs to -3 to 3
[q1,q2]=meshgrid(i1,i2);
i11=q1(:);
i22=q2(:);
[aaa bbb]=size(q1)
k=ones(aaa,bbb)
kk12=k(:);
gamma=1;
for bb=1:length(i11)
z=[i11(bb);i22(bb);kk12(bb)]; 
u1=w1*z;
o1=tanh(gamma.*u1);
o1b=[o1;1];
u2=w2*o1b;
o2=tanh(gamma.*u2);
o2b=[o2;1];
u3=w3*o2b;
oo(bb)=tanh(u3); %output for given inputs
end
oo1=vec2mat(oo,61)'
 g1=vec2mat(i11,61)'
 g2=vec2mat(i22,61)'
figure
 surf(g1,g2,oo1);
 %mesh or surf
%randperm and we are training network with limited samples which doesnt
%shape form from limited samples


  
  
  