%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Company: Instituto Tecnológico de Costa Rica
% Engineers: Edgar Campos, Edgar Solera y José Netzer 
% 
% Create Date:     23/03/2016 syms x
%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\daniel.Leah-PC.000\Desktop\prueba_Pot\Datos.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/05/01 14:21:39

%% Initialize variables.
INF1=' Cuantos datos quiere simular: ';
Eleccion1=input(INF1);

filename = 'C:\Users\WIN8\Desktop\Modificaciones LabMicros\Datos.txt';
endRow = Eleccion1;

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%14f%16f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow, 'Delimiter', '', 'WhiteSpace', '', 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
VarName1 = dataArray{:, 1};
VarName2 = dataArray{:, 2};
VarName3 = dataArray{:, 3};

%% Clear temporary variables
clearvars filename endRow formatSpec fileID dataArray ans;

INF=' Cual eje solicita: 1)X 2)Y 3)Z ';
Eleccion=input(INF);

if Eleccion==1
    
    DatosAceleracion=VarName1;

elseif Eleccion==2
    DatosAceleracion=VarName2;

elseif Eleccion==3
    DatosAceleracion=VarName3;
         
end


% % % % % % % % % % % % % % % % % % %%obtener velocidades

velocidad=ones(Eleccion1,1);
desplazamiento=ones(Eleccion1,1);
delta_t=0.05;
Corriente=ones(Eleccion1,1);
acelerometro=ones(Eleccion1,1);
v0=0;
d0=0;

for i=1:Eleccion1

     
     velocidad(i,1)=int(DatosAceleracion(i,1),x,0,delta_t)+v0;
 
     v0=velocidad(i,1);
 
     desplazamiento(i,1)=int(velocidad(i,1),x,0,delta_t)+d0;
 
     d0=desplazamiento(i,1);

     Corriente(i,1) = (-6E-05)*(velocidad(i,1)^3) + (2E-16)*(velocidad(i,1)^2) + 4.1231*velocidad(i,1) + (1E-11); 
end

Corriente=Corriente*10000;
Corriente=round(Corriente);

% % % % % % % % % % % % % % % % % % % % % % % %  % % % % 

valor=0;
answer=0; 
b=1;
delete(instrfind({'Port'},{'COM3'}));
puerto_serial=serial('COM3');
puerto_serial.baudrate=9600;
warning('off','MATLAB:serial:fscanf:unsuccessfulread');
fopen(puerto_serial);
pause(2)
for i=1:Eleccion1
answer=Corriente(b,1);
fprintf(puerto_serial,'%i',answer); 
contador=1;
valor=fscanf(puerto_serial,'%d');
while valor~=2 
        valor=fscanf(puerto_serial,'%d');
        if valor>2
           acelerometro(i,1)=valor;    
        end
end
b=b+1;
end 
answer2=0;
fprintf(puerto_serial,'%i',answer2);
fclose(puerto_serial);
delete(puerto_serial);


% Module Name:    datos_envio
% Description: Este codigo se encarga de procesar los datos de un archivo .txt(el cual contiene acelaciones(m/cm^2)).
% Estos datos son integrados 2 veces de forma que se pueda obtener la velocidad y el desplazamiento. Luego de operar
% los datos, estos son escalados y enviados al arduino (los datos se escalan de forma que esten en un rango entre -400 y 400)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
syms x 
load Datos.txt;
s=size(Datos);
% n=s(1,1);
n=100;
t=ones(n,1);
velocidad=ones(n,1);
velocidad_arduino=ones(n,1);
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
 
%%%Se escalaran los datos de velocidad para que estos esten entre el rango de -400 y 400

vo_max=400;

vo_min=-400;

vin_min=min(min(velocidad));

vin_max=max(max(velocidad));

m=(vo_max-vo_min)/(vin_max-vin_min);

b=vo_max-m*vin_max;


for k=1:n
   
velocidad_arduino(k,1)=m*velocidad(k,1)+b;

velocidad_arduino(k,1)=round(velocidad_arduino(k,1));

end


% answer=0; % this is where we'll store the user's answer
% arduino=serial('COM4','BaudRate',9600); % create serial communication object on port COM4
%  
% fopen(arduino); % initiate arduino communication
%  
% for i=1:n
%   
%     fprintf(arduino,'%i',double(answer)); % send answer variable content to arduino
%      answer=aceleracion(i,1);
% end
%  
% fclose(arduino); % end communication with arduino