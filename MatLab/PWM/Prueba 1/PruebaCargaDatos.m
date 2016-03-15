syms x
i=0;
n=757;
condicion=0;
load Datos.txt;
datos_int=ones(n,1);
pwm_output=ones(n,1);
result=ones(n,1);
k=ones(n,1);


for i=1:n
    
    y=int(Datos(i,1),x,0,0.05);
    
    datos_int(i,1)=y;
    
    result(i,1)=int(datos_int(i,1),x,0,0.05);
    
    condicion=1*(result(i,1)>0);
    
    pwm_output(i,1)=condicion*(1.000e-04);
    
    k(i,1)=0+i;
end

% subplot(2,2,1)
% plot(k,result,'blue')
% title('Señal analogica')

% subplot(2,2,2)
% plot(k,pwm_output,'red')
% title('PWM')

max(max(result));

plot(k,result)
hold on
plot(k,pwm_output,'r')

