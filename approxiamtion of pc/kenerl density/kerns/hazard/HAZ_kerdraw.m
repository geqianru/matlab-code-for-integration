function HAZ_kerdraw
% function HAZ_kerdraw
% draws the kernel

mf=findobj('Tag','HAZ_MAIN');
udata=get(mf,'UserData');
K=udata.K;
Interval=K.support;
l_bound=Interval(1);
u_bound=Interval(2);
if l_bound>u_bound
 l_bound=Interval(2);
 u_bound=Interval(1);
end
if isinf(l_bound) l_bound=-3; end
if isinf(u_bound) u_bound=3; end
l_i=u_bound-l_bound;
l_bound=l_bound-0.1*l_i;
u_bound=u_bound+0.1*l_i;
xx=linspace(l_bound,u_bound,201);
yy=K_val(K,xx);
figure(mf);
plot(xx,yy);
tit=title('Shape of the Kernel');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);

