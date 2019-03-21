clc
close all
clear all
es=10;%sampled at region respectively equally
x1=linspace(-1,3,es);
x2=linspace(-3,3,es);
[X1,X2]=meshgrid(x1,x2);
[m,n]=size(X1);
b=ones(m,n);
F=sin((X1.^2)./4+(X2.^2)./2);
surf(X1,X2,F)

%creating input and target sequence
X1c=X1(:);X2c=X2(:);
bc=b(:);Fc=F(:);
x=[X1c X2c];
m=es;
w1=linspace(-1,3,m); % 5 by 5 matrix
w2=linspace(-3,3,m); % 5 by 5 matrix
[W1 W2]=meshgrid(w1,w2);
W1c=W1(:);
W2c=W2(:);
Wc=[W1c W2c];
% clc
% clear all
% syms a b c
% norm([a;b;c])
Y=zeros(es*es,2);
Ynorm=zeros(es*es,1);
gbt=zeros(es*es,es*es+1)
for j=1:es*es
for i=1:es*es
Y(i,1:2)=x(j,1:2)-Wc(i,1:2);
Ynorm(i)=norm(Y(i,1:2));
end
[v,k]=min(Ynorm) 

%radial basis
d=sqrt((-1-3).^2+(-3-3).^2); %(-1,-3) and (3,3)
% d=max(abs(wi-wj))
M=es*es;
Md=-(M)/(d.^2)
g=zeros(es*es,1);
for i=1:es*es
   g(i)=exp(Md*(Ynorm(i).^2)) ;
end

gb=[g;1];
gbt(j,:)=gb';
end

wopt=pinv(gbt)*Fc;

%rbf training completion




%testing phase

es=es;%sampled at region respectively equally
x1=linspace(-1.2,2.8,es);
x2=linspace(-3.2,2.8,es);
[X1,X2]=meshgrid(x1,x2);
[m,n]=size(X1);
b=ones(m,n);

%creating input and target sequence
X1c=X1(:);X2c=X2(:);
bc=b(:);
x=[X1c X2c];
m=es;
w1=linspace(-1.2,2.8,m); % 5 by 5 matrix
w2=linspace(-2.7,2.8,m); % 5 by 5 matrix
[W1 W2]=meshgrid(w1,w2);
W1c=W1(:);
W2c=W2(:);
Wc=[W1c W2c];
% clc
% clear all
% syms a b c
% norm([a;b;c])
Y=zeros(es*es,2);
Ynorm=zeros(es*es,1);
for j=1:es*es
for i=1:es*es
Y(i,1:2)=x(j,1:2)-Wc(i,1:2);
Ynorm(i)=norm(Y(i,1:2));
end
[v,k]=min(Ynorm) 

%radial basis
d=sqrt((-1-3).^2+(-3-3).^2); %(-1,-3) and (3,3)
% d=max(abs(wi-wj))
M=es*es;
Md=-(M)/(d.^2)
g=zeros(es*es,1);
for i=1:es*es
   g(i)=exp(Md*(Ynorm(i).^2)) ;
   
end

gb=[g;1];
gbt(j,:)=gb';
end

output=gbt*wopt
op=vec2mat(output,es)'
figure
surf(X1,X2,op)






