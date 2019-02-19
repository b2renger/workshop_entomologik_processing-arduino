
import processing.serial.*;
Serial myPort;  

int valeur1 = 0;
int valeur2 = 0;


void setup() {
  size(800, 500);
 
  printArray(Serial.list());
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');

}

void draw() {    
  background(0);
  fill(255);

  
}  

void serialEvent (Serial myPort) {
  try {
    while (myPort.available() > 0) {
      String inBuffer = myPort.readStringUntil('\n');
      if (inBuffer != null) {
        if (inBuffer.substring(0, 1).equals("{")) {
          JSONObject json = parseJSONObject(inBuffer);
          if (json == null) {
            
          } else {
            
            valeur1    = json.getInt("valeur1");
            valeur2    = json.getInt("valeur2");
            println(valeur1, valeur2);
            
            JSONArray js  = loadJSONArray("data.json"); // create a new file on the computer's hard drive
     
            JSONObject newjson = new JSONObject(); // create a new json object
            newjson.setString("timestamp", year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second()); // create a timestamp
            newjson.setInt("valeur1", valeur1); // add the first value
            newjson.setInt("valeur2", valeur2); // add the second value
           
            js.append(newjson); // append the new values to the one that we already saved
           
            saveJSONArray(js, "data/data.json"); // save the new values
          }
        } else {
        }
      }
    }
  } 
  catch (Exception e) {
  }
}
