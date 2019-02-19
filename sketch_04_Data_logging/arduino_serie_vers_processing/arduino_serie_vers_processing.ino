/*This code write data from two sensors on the serial port
 * one sensor is plugged in analog 0
 * the other one is plugged in digital 2
 */

void setup() {
  Serial.begin(9600);
  pinMode(7, INPUT);
}

void loop() {

  delay(5000);


  String json;
  json = "{\"valeur1\":";
  json = json + analogRead(A0);
  json = json +";\"valeur2\":";
  json = json +  digitalRead(2);
  json = json + "}";

  Serial.println(json);
}
