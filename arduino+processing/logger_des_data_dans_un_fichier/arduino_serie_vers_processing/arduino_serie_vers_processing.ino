void setup() {
  Serial.begin(9600);
  pinMode(7, INPUT);
}

void loop() {
  int pir = digitalRead(2);
  int photor = analogRead(A0);
  /*
  Serial.print("pir: ");
  Serial.println(pir);
  Serial.print("photor: ");
  Serial.println(photor);*/

  delay(5000);


  String json;
  json = "{\"photor\":";
  json = json + analogRead(A0);
  json = json +";\"pir\":";
  json = json +  digitalRead(2);
  json = json + "}";

  Serial.println(json);
}
