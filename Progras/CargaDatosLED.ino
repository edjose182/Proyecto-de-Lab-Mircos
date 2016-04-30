void setup() { 
 // initialize the digital pins as an output.
// pinMode(2, OUTPUT);
// pinMode(3, OUTPUT);
// pinMode(4, OUTPUT);
// pinMode(5, OUTPUT);
// pinMode(6, OUTPUT);
// pinMode(7, OUTPUT);
// pinMode(8, OUTPUT);
// pinMode(9, OUTPUT);
 pinMode(13, OUTPUT);
// Turn the Serial Protocol ON
 Serial.begin(9600);
}

void loop() {
 byte byteRead;

 /* check if data has been sent from the computer: */
 if (Serial.available()) {
 
 /* read the most recent byte */
 byteRead = Serial.read();
 //You have to subtract '0' from the read Byte to convert from text to a number.
 byteRead=byteRead-'0';
 
 //Turn off all LEDs if the byte Read = 0
 if(byteRead<0){
 //Turn off all LEDS
// digitalWrite(2, LOW);
// digitalWrite(3, LOW);
// digitalWrite(4, LOW);
// digitalWrite(5, LOW);
// digitalWrite(6, LOW);
// digitalWrite(7, LOW);
// digitalWrite(8, LOW);
// digitalWrite(9, LOW);
// digitalWrite(10, LOW);
  digitalWrite(13, LOW);
 }
 
 //Turn LED ON depending on the byte Read.
 if(byteRead>0){
 digitalWrite(13, HIGH); // set the LED on
 
 
 }
 }
 }
