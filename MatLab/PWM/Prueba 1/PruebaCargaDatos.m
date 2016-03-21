syms x
i=0;
n=757;
condicion=0;
esca=0;
load Datos.txt;
datos_int=ones(n,1);
pwm_output=ones(n,1);
result=ones(n,1);
result2=ones(n,1);
k=ones(n,1);


for i=1:n
    
    y=int(Datos(i,1),x,0,0.05);
    
    datos_int(i,1)=y;
    
    result2(i,1)=datos_int(i,1)*(0.002);
    
    result(i,1)=(int(datos_int(i,1),x,0,0.05));
    
    k(i,1)=0+i;

    %%%esca=(k(i,1)*(1.000e-04));
    counter=-3+i;
    
    if (counter>5)
        
        counter=-3;
        
        condicion=1*(result(i,1)>0);
        
    else
        
        condicion=1*(result(i,1)>0);
        
    end
    

    
    pwm_output(i,1)=condicion;
    
    
end

% subplot(2,2,1)
% plot(k,result,'blue')
% title('Señal analogica')

% subplot(2,2,2)
% plot(k,pwm_output,'red')
% title('PWM')

max(max(result))

min(min(result))

max(max(result2))

min(min(result2))

plot(k,result2)
hold on
plot(k,pwm_output,'r')

