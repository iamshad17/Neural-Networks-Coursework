clear all
close all
clc
 %% A. Solve a set of linear equations by the use of a single layer feedforward NN
 m=30;
 k=10;
 A=normrnd(0,1,[m k]);   % Gaussian distribution of random elements[30x10]
 b=normrnd(0,1,[m 1]);   % Gaussian distribution of random elements[30x1]
 Ainv=A';                % Ainv=[a1 a2 ... am]
 I=eye(m);               % I=[e1 e2 ... em]
 
 % Leaky-LMS algorithm approach for Linear NN
 w = rand(size(A));     % initialize weight vector randomly
 a = 0.002;             % stepsize
 gama = 0.0001;         % leak factor
 x=Ainv;                % inout of the neuron
 c=0;                   % counter  
 
 %theroretical which we use to train
 Apseudo=pinv(A);       % A+ = A_pseudo
 xopt=Apseudo*b;
 Error=A*xopt-b;        % e=||Ax-b||, x=x_opt=A+*b
 ErrorNorm=norm(Error);
 % we are approximating error function since it can be never zero 
 %using pseudo inverse finding minimum error
 
 ErrorNormNN=0;
 % the one we training to apparoximate
 while abs(ErrorNormNN-ErrorNorm)>0.01
 j = randperm(m);   
 for i=1:m
 e=I(:,j(i))-w*x(:,j(i));
 w=(1-gama).*w+a*e*(x(:,j(i)))'; 
 end 
 c=c+1;
 ApseudoNN=w';
 xoptNN=ApseudoNN*b;
 ErrorNN=A*xoptNN-b;
 ErrorNormNN=norm(ErrorNN);
 end
 ApseudoNN
 Apseudo

 