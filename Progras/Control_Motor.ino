#include "DualMC33926MotorShield.h"  ///Primero se habilitan las librerias

DualMC33926MotorShield md; ///Se habilita la variable md
int M1PWM =9;              ///Se indican los pines
int M1DIR=7;               ///Que se activaran en el arduino 
//int M1FB=A0;
int D2n=4;
int SFn=12;

void setup()
{
  pinMode(D2n,OUTPUT);    ////Se habilitan los pines de salida
  pinMode(M1PWM,OUTPUT);  ////Se habilitan los pines de salida
  pinMode(M1DIR,OUTPUT);  ////Se habilitan los pines de salida
  Serial.begin(9600);     ///Se habilita el puerto serial
  Serial.setTimeout(100); ///Se pone un tiempo de espera para la recepción de datos
  md.init();              ///se inicializa la variable md
}

void loop() {
  /*
   * Evaluamos el momento en el cual recibimos un caracter
   * a través del puerto serie
   */

  if (Serial.available() > 0) {

    
    digitalWrite(D2n,HIGH);   ////Se ponen en alto para
                              ////activar el movimiento del motor
    digitalWrite(M1PWM,HIGH); 
  
    int num = Serial.readString().toInt();   ////Se convierte el dato recibido en un valor entero

    if(num>0){
    
      digitalWrite(M1DIR,LOW);  ///Se evalua el signo del dato 
                                ///Para definir la dirección de giro
    }
    
    else if(num<0){

      digitalWrite(M1DIR,HIGH);     ///Se evalua el signo del dato
                                    ///Para definir la dirección de giro
      num=num*(-1);                 /// Se convierte el valor recibido a un entero positivo
    }

    else if(num==0){

      digitalWrite(D2n,LOW);       ///Si el valor recibido es cero, el motor se colocara en una posición fija(punto muerto)


    }

    md.setM1Speed(num);            /// Se regula la velocidad del motor
    }

   else{

    digitalWrite(M1PWM,LOW);      ///Si no se recibe ningun dato el mator se detiene

    digitalWrite(D2n,HIGH);
    
    
   }
}
