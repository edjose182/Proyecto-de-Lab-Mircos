clear all
clc
syms x 
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
aceleracion=ones(n,1);

for i=1:n

    aceleracion(i,1)=-5+i;
    
    velocidad(i,1)=int(Datos(i,1),x,0,delta_t)+v0;

    v0=velocidad(i,1);

    desplazamiento(i,1)=int(velocidad(i,1),x,0,delta_t)+d0;

    d0=desplazamiento(i,1);

    t(i,1)=0+i;

end
 
answer=0; % this is where we'll store the user's answer
arduino=serial('COM4','BaudRate',9600); % create serial communication object on port COM4
 
fopen(arduino); % initiate arduino communication
 
for i=1:n
  
    fprintf(arduino,'%i',double(answer)); % send answer variable content to arduino
     answer=aceleracion(i,1);
end
 
fclose(arduino); % end communication with arduino