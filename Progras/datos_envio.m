//////////////////////////////////////////////////////////////////////////////////
// Company: Instituto Tecnológico de Costa Rica
// Engineers: Edgar Campos, Edgar Solera y José Netzer 
// 
// Create Date:     23/03/2016 
// Module Name:    datos_envio
// Description: Este codigo se encarga de procesar los datos de un archivo .txt(el cual contiene acelaciones(m/cm^2)).
// Estos datos son integrados 2 veces de forma que se pueda obtener la velocidad y el desplazamiento. Luego de operar
// los datos, estos son escalados y enviados al arduino (los datos se escalan de forma que esten en un rango entre -400 y 400)
//////////////////////////////////////////////////////////////////////////////////

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