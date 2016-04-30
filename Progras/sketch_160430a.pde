import processing.serial.*;
import java.io.*;
int mySwitch=0;
int counter=0;
String [] subtext;
Serial myPort;

void setup(){
  //Se crea un switch que controlara la frecuencia con que es leido el texto
  //Cuando mySwitch=1, el programa es configurado para leer el txt
  //Se apaga cuando mySwitch = 0

  mySwitch=1;

  //Se abre la comunicacion serial con el arduino
  myPort= new Serial(this, "COM4", 9600);
  myPort.bufferUntil('\n');
}

void draw(){
  if (mySwitch>0){
    //Este es el llamado utilizado para leer el txt en 
    // la computadora
    readData("C:/Datos.txt"); ////C:\Users\WIN8\Desktop\Edgar\I Semestre 2016\Lab. Micros\Proyecto\Processing\Prueba1\CargaDatos\CargaDatosArduino

    /*El siguiente switch prevve la lectura continua del archivo,
    hasta que estemos listos para leer el archivo otra vez*/

    mySwitch=0;
  }
/* Solo se envian nuevos datos. Esto si el IF permite que se envien 
nuevos datos al arduino*/

if (counter<subtext.length) {
/*Escribe el siguiente numero al puerto serial and lo envia al arduino
*/
myPort.write(subtext[counter]);
delay(500);
myPort.write('0');
delay(100);

/*Se incrementa la variable counter para que el siguiente valor sea
enviado al arduino*/

counter++;
}else{
/*Si el archivo se quedo sin numeros, entonces leera el archivo otra vez
*/

delay(5000);
mySwitch=1;

}

}

///La siguiente funcion es la que se encarga de leer el archivo//

void readData(String myFileName){
  File file= new File(myFileName);
  BufferedReader br= null;

  try{
    br = new BufferedReader(new FileReader(file));
    String text=null;

/*Continuara leyendo cada line hasta encontrar el final del archivo*/

while((text=br.readLine())!=null){
/*Separa cada linea en bits usando una como como un separador*/

subtext=splitTokens(text,",");
}
  }catch(FileNotFoundException e){
    e.printStackTrace();
  }catch(IOException e){

    e.printStackTrace();
  }finally{
    try{
      if(br !=null){

        br.close();
      }
    }catch(IOException e){
      e.printStackTrace();
    }
  }

}