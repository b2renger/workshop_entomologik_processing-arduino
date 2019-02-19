void setup() {
  Serial.begin(9600); //open the serial port
}

void loop() {

  int value = analogRead(0); // read the value on analog 0

  // format a string to a json format and add our value read from A0
  String json;
  json = "{\"valeur1\":";
  json = json + value;
  json = json + "}";

  // post the string on the serial port
  Serial.println(json);
}
