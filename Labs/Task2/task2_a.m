clc
close all
clear all
load digits_task2.mat
W1=zeros(120,120)
for v=1:8
X1=digits(:,:,v);
X=X1(:); %colunm wise taking noteeeee
Y=X;
W=Y*X'
W1=W1+W
end
%in this W COLUNM 1 IS 1ST OUPUT AND ALL INPUTS

% 
% %all digits matrix form
% %learning
% X=zeros(120,8)
% X1=zeros(120,1)
% for i=1:8
% X1(:)=digits(:,:,i)
% X(:,i)=X1; %120 1 120 2 so on updates 
% Y=X; %output same as input
% end
% W=Y*X';

%evaluating performance
for t=1:6
test=distorted_digits(:,:,t)
tt=test(:); %colunm wise takes

ONS=W1*tt

O=sign(ONS)
dd=vec2mat(O,12)' %orderwise sequence divide 
subplot(2,3,t)
imshow(dd)
end



figure
for j=1:6
    subplot(2,3,j)
    imshow(distorted_digits(:,:,j))
end