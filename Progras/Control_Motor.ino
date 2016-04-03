//////////////////////////////////////////////////////////////////////////////////
// Company: Instituto Tecnológico de Costa Rica
// Engineers: Edgar Campos, Edgar Solera y José Netzer 
// 
// Create Date:     23/03/2016 
// Module Name:    Control_Motor
// Description: Este codigo se encarga de controlar la velocidad y sentido de rotación del motor
// esto mediante un envio de datos desde matlab hasta el arduino.
//////////////////////////////////////////////////////////////////////////////////

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

    
    int velocidad = Serial.readString().toInt();   ////Se convierte el dato recibido en un valor entero


    md.setM1Speed(velocidad); //Se regula la velocidad del motor introduciendo un valor de corriente que esta entre -400 y 400
                              //El dato "velocidad" es la velocidad procesada en matlab pero escalada para que este en un rango
                              //Entre -400 y 400
    
   }
}
