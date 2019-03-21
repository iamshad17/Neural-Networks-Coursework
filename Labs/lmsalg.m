function [wt,error] = lmsalg(x,d,mu,nord,a0)%creating function
X=convmalg(x,nord);
[M,N] = size(X);
if nargin < 5, %no of input arguments
    a0 = zeros(1,N);   end
a0   = a0(:).';
error(1) = d(1) - a0*X(1,:).'; 
A(1,:) = a0 + mu*error(1)*conj(X(1,:));%calculating weights
if M>1
for k=2:M-nord+1;
    y(k) = A(k-1,:)*X(k,:).';
    error(k) = d(k) - y(k);
    A(k,:) = A(k-1,:) + mu*error(k)*conj(X(k,:));%updating filter coefficients
    end;
    wt = A(k,:);
   end;



