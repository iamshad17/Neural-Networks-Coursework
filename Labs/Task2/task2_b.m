clc
close all
clear all
load digits_task2.mat

%all digits matrix form
%learning
X=zeros(120,8)
X1=zeros(120,1)
for i=1:8
X1(:)=digits(:,:,i)
X(:,i)=X1;
Y=X; %output same as input
end
W=Y*pinv(X);
for h=1:120
W(h,h)=0;
end

%W=Y*X'
%diagonal zero
% W=W-8*eye(120)
% training done

%testing for convergence
ip=heavily_distorted_digits
for t=1:6
test=ip(:,:,t)
tt=test(:)
%initialising state vector using noisy input vector
s0=tt
r2=s0' %randperm takes row vector
s1=zeros(120,1)
Wn=zeros(120,120);

q=0
p=2
while p>1  %converging criteria s remains unchanged
    q=q+1; %counter
    a=randperm(length(r2));
theta=0;
for u=1:length(a)
    s1(a(u),1)=sign(W(a(u),:)*s0-theta);
end
%e=norm(s1-s0)
%if (e==0)
  if (s1==s0) %converging criteria s remains unchanged
   p=0
else
    p=p+1
end
s0=s1
% if (Wn/W==zeros(120)+eye(120))
% p=0
% else
%     p=p+1
% end
% Wn=W
end
op=vec2mat(s1,12)';
subplot(2,3,t)
imshow(op)
end


if (s1==s0) %obs its last value only checking
    display('not changed converging')
else
    display('changed not converging')
end
    
figure
for j=1:6
    subplot(2,3,j)
    imshow(ip(:,:,j))
end