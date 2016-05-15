#include "DualMC33926MotorShield.h"  ///Primero se habilitan las librerias

DualMC33926MotorShield md; ///Se habilita la variable md

void setup()
{
  Serial.begin(9600);     ///Se habilita el puerto serial
  md.init();              ///se inicializa la variable md
}
//Analog read pins
const int xPin=10;

//The minimum and maximum values that came from
//the accelerometer while standing still
//You very well may need to change these
int minVal = 265;
int maxVal = 402;
char cadena[30]; //Creamos un array que almacenará los caracteres que escribiremos en la consola del PC. Le asignamos  un tope de caracteres, en este caso 30
byte posicion=0;  //Variable para cambiar la posición de los caracteres del array
int valor;  //Variable del valor entero

int ON=1;
int OFF=2;

//to hold the caculated values
double x;

void loop() {
  /*
   * os el momento en el cual recibimos un caracter
   * a través del puerto serie
   */

  int xRead= analogRead(xPin);

  x=xRead;

  if (Serial.available() > 0) {

              Serial.println(ON);

              memset(cadena, 0,sizeof(cadena));//memset borra el contenido del array  "cadena" desde la posición 0 hasta el final sizeof
              while(Serial.available()>0) //Mientras haya datos en el buffer ejecuta la función
              {
                delay(5); //Poner un pequeño delay para mejorar la recepción de datos
                cadena[posicion]=Serial.read();//Lee un carácter del string "cadena" de la "posicion", luego lee el siguiente carácter con "posicion++"
                posicion++;
              }
              
              valor=atoi(cadena);//Convertimos la cadena de caracteres en enteros
              md.setM1Speed(valor);

              
              Serial.println(x);
              delay(700);
              Serial.println(OFF);
              posicion=0;//Ponemos la posicion a 0
   }
}

