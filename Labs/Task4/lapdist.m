function x=lapdist(a,b,m,n);

% LAPDIST   Random number generator for Laplace distribution,
%                      L(a,b) ~ exp(-|x-a|/b)/(2b)
% where a is the mean in [-inf,inf] and b>0 is the scalar parameter.
%
% x=lapdist(a,b,m,n) generates a m-by-n matrix with Laplace distributed
% random entries.
%

% (c) 1999, XJT & NGR, Ronneby.

rand('state',cputime);
x1=rand(m,n);
x0=rand(m,n);
x2=rand(m,n);

x=log(x1./x2);
x=x*b+a;

return