function h0=mlmin(X,d,K)
MX=max(X);
hh=linspace(MX/100,MX/2,200);
ml=maxlike(X,d,hh,K);
[ml0,I]=min(ml);
h0=hh(I);