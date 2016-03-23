int ledPin=13;
void setup() {
  //Iniciamos comunicación con el puerto serie
  pinMode(ledPin,OUTPUT);
  Serial.begin(9600);
  Serial.setTimeout(100);
}

void loop() {
  /*
   * Evaluamos el momento en el cual recibimos un caracter
   * a través del puerto serie
   */
  if (Serial.available() > 0) {
    //Se transforma la lectura a un número entero
    int num = Serial.readString().toInt();
    //Se imprime el número que se recibe
    if(num>0)
    
      digitalWrite(ledPin,HIGH);

    else if(num<=0)

      digitalWrite(ledPin,LOW);
      


    //Serial.print("Numero recibido: ");
    //Serial.println(num);
    //Se calcula la raíz cuadrada del número recibido
    //num = sqrt(num);
    //Se imprime el resultado
    //Serial.print("Raiz cuadrada: ");
    //Serial.println(num);
  }
}
  
  
