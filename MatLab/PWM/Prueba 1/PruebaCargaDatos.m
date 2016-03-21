syms x
i=0;
condicion=0;
load Datos.txt;
s=size(Datos);
% n=s(1,1);
n=100;
t=ones(n,1);
velocidad=ones(n,1);
v0=0;
desplazamiento=ones(n,1);
d0=0;
delta_t=0.05;
%aceleracion=ones(n,1);

for i=1:n

    %%%aceleracion(i,1)=50;
    
    velocidad(i,1)=int(Datos(i,1),x,0,delta_t)+v0;

    v0=velocidad(i,1);

    desplazamiento(i,1)=int(velocidad(i,1),x,0,delta_t)+d0;

    d0=desplazamiento(i,1);

    t(i,1)=0+i;

end

max(max(Datos))

min(min(Datos))

max(max(velocidad))

min(min(velocidad))

max(max(desplazamiento))

min(min(desplazamiento))

% plot(t,Datos,'blue')
% hold on
plot(t,velocidad,'r')
hold on
plot(t,desplazamiento,'green')

