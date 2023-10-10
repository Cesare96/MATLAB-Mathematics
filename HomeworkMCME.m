%% unconstrained optimization
[x1, x2] = meshgrid(-3:0.1:3, -3:0.1:3); 
f1 = (2-(x1+x2).^2-(x2.^2+x2-x1).^2);
figure
surf (x1,x2,f1)
figure
contour(x1, x2, f1, 800)
ylabel('x2')
xlabel('x1')
zlabel('f(x1,x2')
colorbar
z0=[0,0];
z1=[2,-2];
z2=[0.5,-1];
[xmin0 fmin0]=fminunc(@f1,z0);
[xmin1 fmin1]=fminunc(@f1,z1);
[xmin2 fmin2]=fminunc(@f1,z2);
[xmin00 fmin00]=fminsearch(@f1,z0);
[xmin11 fmin11]=fminsearch(@f1,z1);
[xmin22 fmin22]=fminsearch(@f1,z2);
%% constrain optimization (minima)
[x1, x2] = meshgrid(-10:0.05:10, -10:0.05:10);
f2=(x1+3.*x2);
constr1=(x1-1).^2+x2.^2-5<=0;
constr2=-x1-x2.^2<=0;
feasible=constr1.*constr2;
feasible(feasible==0)=NaN;
f2=f2.*feasible;
figure
subplot(1,2,1)
surf (x1,x2,f2)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('f(x1,x2')
subplot(1,2,2)
contour(x1,x2,f2,200)
colorbar
xA=[1 0];
[xminA fminA]=fmincon(@f2,xA,[],[],[],[],[],[],@constr);
xB=[0 -1];
[xminB fminB]=fmincon(@f2,xB,[],[],[],[],[],[],@constr);
xC=[1 1];
[xminC,fminC]=fmincon(@f2,xC,[],[],[],[],[],[],@constr);
%% constraint optimization (maxima)
[x1, x2] = meshgrid(-10:0.05:10, -10:0.05:10);
f2bis=(x1+3.*x2);
constr1=(x1-1).^2+x2.^2-5<=0;
constr2=-x1-x2.^2<=0;
feasible=constr1.*constr2;
feasible(feasible==0)=NaN;
f2bis=f2bis.*feasible;
figure
subplot(1,2,1)
surf (x1,x2,f2)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('f(x1,x2')
subplot(1,2,2)
contour(x1,x2,f2bis,200)
colorbar
xA=[1 0];
[xbisminA fbisminA]=fmincon(@f2bis,xA,[],[],[],[],[],[],@constr);
xB=[0 -1];
[xbisminB fbisminB]=fmincon(@f2bis,xB,[],[],[],[],[],[],@constr);
xC=[1 1];
[xbisminC,fbisminC]=fmincon(@f2bis,xC,[],[],[],[],[],[],@constr);
%% ODE
% % my solution
T=6;
texact=0:0.1:6;
yexact=1./(-(texact.^3)-2);
figure
plot(texact,yexact)
xlabel('t')
ylabel('f(t)')
title('Exact Particular Solution')
%% Matlab solution
t0=0;
y0=-1/2;
[t,y]=ode45(@z,[t0,T],y0);
figure
plot(t,y)
xlabel('t')
ylabel('f(t)')
title('Approximated Particular Solution')
%% 
figure
plot(t,y,texact,yexact)
xlabel('t')
ylabel('f(t)')
title('graph overlapping solutions')
legend('approximated particular solution','exact particular solution')
%% error
t_yexact=1./(-(t.^3)-2);
error= abs(t_yexact-y);
figure
plot(t,error)
